//! Taskbar - ZirconOS Modern Flat Dark Taskbar
//! 40px flat dark taskbar with Windows flag Start button (no text),
//! flat task buttons, system tray with flat icons, date+time clock.

const theme = @import("theme.zig");

pub const COLORREF = theme.COLORREF;

// ── Task Button ──

pub const MAX_TASK_BUTTONS: usize = 32;
pub const MAX_TASK_NAME_LEN: usize = 64;

pub const TaskButtonState = enum(u8) {
    normal = 0,
    active = 1,
    hover = 2,
    flashing = 3,
    minimized = 4,
};

pub const TaskButton = struct {
    hwnd: u64 = 0,
    name: [MAX_TASK_NAME_LEN]u8 = [_]u8{0} ** MAX_TASK_NAME_LEN,
    name_len: usize = 0,
    icon_id: u32 = 0,
    state: TaskButtonState = .normal,
    is_visible: bool = false,
    x: i32 = 0,
    width: i32 = 0,
    flash_count: u32 = 0,

    pub fn getName(self: *const TaskButton) []const u8 {
        return self.name[0..self.name_len];
    }
};

// ── System Tray ──

pub const MAX_TRAY_ICONS: usize = 16;

pub const TrayIcon = struct {
    id: u32 = 0,
    owner_hwnd: u64 = 0,
    icon_id: u32 = 0,
    tooltip: [64]u8 = [_]u8{0} ** 64,
    tooltip_len: usize = 0,
    is_visible: bool = false,
    x: i32 = 0,

    pub fn getTooltip(self: *const TrayIcon) []const u8 {
        return self.tooltip[0..self.tooltip_len];
    }
};

// ── Clock (date and time) ──

pub const TaskbarClock = struct {
    hour: u8 = 0,
    minute: u8 = 0,
    second: u8 = 0,
    day: u8 = 1,
    month: u8 = 1,
    year: u16 = 2013,
    show_seconds: bool = false,
    is_24h: bool = false,
    x: i32 = 0,
    width: i32 = theme.TASKBAR_CLOCK_WIDTH,

    pub fn getTimeString(self: *const TaskbarClock, buffer: []u8) usize {
        if (buffer.len < 8) return 0;
        var h = self.hour;
        const suffix: u8 = if (!self.is_24h and h >= 12) 'P' else 'A';
        if (!self.is_24h) {
            if (h == 0) h = 12 else if (h > 12) h -= 12;
        }

        var pos: usize = 0;
        if (h >= 10) {
            buffer[pos] = '0' + h / 10;
            pos += 1;
        }
        buffer[pos] = '0' + h % 10;
        pos += 1;
        buffer[pos] = ':';
        pos += 1;
        buffer[pos] = '0' + self.minute / 10;
        pos += 1;
        buffer[pos] = '0' + self.minute % 10;
        pos += 1;

        if (self.show_seconds) {
            buffer[pos] = ':';
            pos += 1;
            buffer[pos] = '0' + self.second / 10;
            pos += 1;
            buffer[pos] = '0' + self.second % 10;
            pos += 1;
        }

        if (!self.is_24h and pos + 3 <= buffer.len) {
            buffer[pos] = ' ';
            pos += 1;
            buffer[pos] = suffix;
            pos += 1;
            buffer[pos] = 'M';
            pos += 1;
        }

        return pos;
    }

    pub fn getDateString(self: *const TaskbarClock, buffer: []u8) usize {
        if (buffer.len < 10) return 0;
        var pos: usize = 0;
        buffer[pos] = '0' + self.month / 10;
        pos += 1;
        buffer[pos] = '0' + self.month % 10;
        pos += 1;
        buffer[pos] = '/';
        pos += 1;
        buffer[pos] = '0' + self.day / 10;
        pos += 1;
        buffer[pos] = '0' + self.day % 10;
        pos += 1;
        buffer[pos] = '/';
        pos += 1;
        const y = @as(u16, self.year) % 100;
        buffer[pos] = '0' + @as(u8, @intCast(y / 10));
        pos += 1;
        buffer[pos] = '0' + @as(u8, @intCast(y % 10));
        pos += 1;
        return pos;
    }
};

// ── Start Button (Windows flag, no text) ──

pub const StartButtonState = enum(u8) {
    normal = 0,
    hover = 1,
    pressed = 2,
    start_screen_open = 3,
};

pub const StartButton = struct {
    state: StartButtonState = .normal,
    x: i32 = 0,
    y: i32 = 0,
    width: i32 = theme.START_BTN_WIDTH,
    height: i32 = theme.START_BTN_HEIGHT,

    pub fn hitTest(self: *const StartButton, mx: i32, my: i32) bool {
        return mx >= self.x and mx < self.x + self.width and
            my >= self.y and my < self.y + self.height;
    }

    pub fn getColors(self: *const StartButton) struct {
        bg: COLORREF,
        icon: COLORREF,
    } {
        const colors = theme.getColors();
        return switch (self.state) {
            .pressed, .start_screen_open => .{
                .bg = colors.accent,
                .icon = theme.RGB(0xFF, 0xFF, 0xFF),
            },
            .hover => .{
                .bg = colors.start_btn_hover,
                .icon = theme.RGB(0xFF, 0xFF, 0xFF),
            },
            .normal => .{
                .bg = colors.start_btn_bg,
                .icon = theme.RGB(0xFF, 0xFF, 0xFF),
            },
        };
    }
};

// ── Taskbar Settings ──

pub const TaskbarSettings = struct {
    auto_hide: bool = false,
    always_on_top: bool = true,
    show_clock: bool = true,
    lock_taskbar: bool = true,
    height: i32 = theme.TASKBAR_HEIGHT,
};

// ── Global State ──

var task_buttons: [MAX_TASK_BUTTONS]TaskButton = [_]TaskButton{.{}} ** MAX_TASK_BUTTONS;
var task_count: usize = 0;

var tray_icons: [MAX_TRAY_ICONS]TrayIcon = [_]TrayIcon{.{}} ** MAX_TRAY_ICONS;
var tray_icon_count: usize = 0;

var clock: TaskbarClock = .{};
var start_button: StartButton = .{};
var taskbar_settings: TaskbarSettings = .{};

var screen_width: i32 = 800;
var screen_height: i32 = 600;
var taskbar_initialized: bool = false;

// ── Task Button Management ──

pub fn addTaskButton(hwnd: u64, name: []const u8, icon_id: u32) ?*TaskButton {
    if (task_count >= MAX_TASK_BUTTONS) return null;

    var btn = &task_buttons[task_count];
    btn.* = .{};
    btn.hwnd = hwnd;
    btn.icon_id = icon_id;
    btn.is_visible = true;
    btn.state = .normal;

    const n = @min(name.len, MAX_TASK_NAME_LEN);
    @memcpy(btn.name[0..n], name[0..n]);
    btn.name_len = n;

    task_count += 1;
    recalculateTaskLayout();
    return btn;
}

pub fn removeTaskButton(hwnd: u64) bool {
    var i: usize = 0;
    while (i < task_count) {
        if (task_buttons[i].hwnd == hwnd) {
            var j = i;
            while (j + 1 < task_count) : (j += 1) {
                task_buttons[j] = task_buttons[j + 1];
            }
            task_buttons[task_count - 1] = .{};
            task_count -= 1;
            recalculateTaskLayout();
            return true;
        }
        i += 1;
    }
    return false;
}

pub fn setActiveTask(hwnd: u64) void {
    for (task_buttons[0..task_count]) |*btn| {
        if (!btn.is_visible) continue;
        btn.state = if (btn.hwnd == hwnd) .active else .normal;
    }
}

pub fn flashTask(hwnd: u64) void {
    for (task_buttons[0..task_count]) |*btn| {
        if (btn.hwnd == hwnd and btn.state != .active) {
            btn.state = .flashing;
            btn.flash_count = 0;
        }
    }
}

pub fn getTaskButton(index: usize) ?*const TaskButton {
    if (index < task_count and task_buttons[index].is_visible) {
        return &task_buttons[index];
    }
    return null;
}

pub fn getTaskCount() usize {
    var count: usize = 0;
    for (task_buttons[0..task_count]) |*btn| {
        if (btn.is_visible) count += 1;
    }
    return count;
}

pub fn hitTestTask(x: i32, y: i32) ?usize {
    const tb_y = getTaskbarY();
    if (y < tb_y or y >= tb_y + taskbar_settings.height) return null;

    for (task_buttons[0..task_count], 0..) |*btn, i| {
        if (!btn.is_visible) continue;
        if (x >= btn.x and x < btn.x + btn.width) return i;
    }
    return null;
}

// ── System Tray ──

pub fn addTrayIcon(id: u32, owner: u64, icon_id: u32, tooltip: []const u8) bool {
    if (tray_icon_count >= MAX_TRAY_ICONS) return false;
    var icon = &tray_icons[tray_icon_count];
    icon.* = .{};
    icon.id = id;
    icon.owner_hwnd = owner;
    icon.icon_id = icon_id;
    icon.is_visible = true;

    const n = @min(tooltip.len, icon.tooltip.len);
    @memcpy(icon.tooltip[0..n], tooltip[0..n]);
    icon.tooltip_len = n;

    tray_icon_count += 1;
    return true;
}

pub fn removeTrayIcon(id: u32) bool {
    var i: usize = 0;
    while (i < tray_icon_count) {
        if (tray_icons[i].id == id) {
            var j = i;
            while (j + 1 < tray_icon_count) : (j += 1) {
                tray_icons[j] = tray_icons[j + 1];
            }
            tray_icons[tray_icon_count - 1] = .{};
            tray_icon_count -= 1;
            return true;
        }
        i += 1;
    }
    return false;
}

pub fn getTrayIconCount() usize {
    var count: usize = 0;
    for (tray_icons[0..tray_icon_count]) |*icon| {
        if (icon.is_visible) count += 1;
    }
    return count;
}

// ── Clock ──

pub fn updateClock(hour: u8, minute: u8, second: u8) void {
    clock.hour = hour;
    clock.minute = minute;
    clock.second = second;
}

pub fn updateClockDate(day: u8, month: u8, year: u16) void {
    clock.day = day;
    clock.month = month;
    clock.year = year;
}

pub fn getClock() *const TaskbarClock {
    return &clock;
}

// ── Start Button ──

pub fn getStartButton() *const StartButton {
    return &start_button;
}

pub fn setStartButtonState(state: StartButtonState) void {
    start_button.state = state;
}

pub fn isStartScreenOpen() bool {
    return start_button.state == .start_screen_open;
}

pub fn toggleStartScreen() void {
    if (start_button.state == .start_screen_open) {
        start_button.state = .normal;
    } else {
        start_button.state = .start_screen_open;
    }
}

// ── Layout ──

pub fn getTaskbarY() i32 {
    return screen_height - taskbar_settings.height;
}

pub fn getTaskbarRect() struct { x: i32, y: i32, w: i32, h: i32 } {
    return .{
        .x = 0,
        .y = screen_height - taskbar_settings.height,
        .w = screen_width,
        .h = taskbar_settings.height,
    };
}

pub fn getTaskbarColors() struct {
    bg: COLORREF,
    tray_bg: COLORREF,
    clock_text: COLORREF,
    active_indicator: COLORREF,
} {
    const colors = theme.getColors();
    return .{
        .bg = colors.taskbar_bg,
        .tray_bg = colors.tray_bg,
        .clock_text = colors.clock_text,
        .active_indicator = colors.accent,
    };
}

fn recalculateTaskLayout() void {
    const start_end = theme.START_BTN_WIDTH;
    const tray_width = computeTrayWidth();
    const clock_width: i32 = if (taskbar_settings.show_clock) theme.TASKBAR_CLOCK_WIDTH else 0;
    const task_area_start = start_end;
    const task_area_end = screen_width - tray_width - clock_width - 4;
    const task_area_width = @max(task_area_end - task_area_start, 0);

    var visible_count: i32 = 0;
    for (task_buttons[0..task_count]) |*btn| {
        if (btn.is_visible) visible_count += 1;
    }

    const btn_width: i32 = if (visible_count > 0)
        @min(48, @divTrunc(task_area_width, visible_count))
    else
        48;

    var pos: i32 = task_area_start;
    for (task_buttons[0..task_count]) |*btn| {
        if (!btn.is_visible) continue;
        btn.x = pos;
        btn.width = btn_width;
        pos += btn_width;
    }
}

fn computeTrayWidth() i32 {
    var count: i32 = 0;
    for (tray_icons[0..tray_icon_count]) |*icon| {
        if (icon.is_visible) count += 1;
    }
    return count * 24 + 8;
}

// ── Settings ──

pub fn getSettings() *const TaskbarSettings {
    return &taskbar_settings;
}

pub fn setScreenSize(w: i32, h: i32) void {
    screen_width = w;
    screen_height = h;
    start_button.y = getTaskbarY();
    recalculateTaskLayout();
}

// ── Initialization ──

pub fn init() void {
    task_count = 0;
    tray_icon_count = 0;
    taskbar_settings = .{};
    clock = .{};
    start_button = .{
        .x = 0,
        .y = screen_height - theme.TASKBAR_HEIGHT,
        .width = theme.START_BTN_WIDTH,
        .height = theme.START_BTN_HEIGHT,
    };

    _ = addTrayIcon(1, 0, 10, "Speakers");
    _ = addTrayIcon(2, 0, 11, "Network");
    _ = addTrayIcon(3, 0, 12, "Action Center");

    updateClock(12, 0, 0);
    updateClockDate(26, 10, 2013);
    recalculateTaskLayout();
    taskbar_initialized = true;
}
