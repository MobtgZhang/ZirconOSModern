//! Controls - ZirconOS Modern Metro-styled UI Controls
//! Flat buttons (no borders, color fill on hover/press),
//! flat textbox (1px bottom border only), toggle switch,
//! AppBar (bottom command bar), tile control (live tile).

const theme = @import("theme.zig");

pub const COLORREF = theme.COLORREF;

// ── Common Control State ──

pub const ControlState = enum(u8) {
    normal = 0,
    hover = 1,
    pressed = 2,
    focused = 3,
    disabled = 4,
    checked = 5,
    checked_hover = 6,
    indeterminate = 7,
};

pub const Alignment = enum(u8) {
    left = 0,
    center = 1,
    right = 2,
};

// ── Flat Push Button ── (no border, color fill on hover/press)

pub const MAX_LABEL_LEN: usize = 48;

pub const PushButton = struct {
    x: i32 = 0,
    y: i32 = 0,
    width: i32 = theme.BUTTON_MIN_WIDTH,
    height: i32 = theme.BUTTON_HEIGHT,
    label: [MAX_LABEL_LEN]u8 = [_]u8{0} ** MAX_LABEL_LEN,
    label_len: usize = 0,
    state: ControlState = .normal,
    is_default: bool = false,
    is_enabled: bool = true,
    command_id: u32 = 0,

    pub fn getLabel(self: *const PushButton) []const u8 {
        return self.label[0..self.label_len];
    }

    pub fn setLabel(self: *PushButton, text: []const u8) void {
        const n = @min(text.len, MAX_LABEL_LEN);
        @memcpy(self.label[0..n], text[0..n]);
        self.label_len = n;
    }

    pub fn hitTest(self: *const PushButton, mx: i32, my: i32) bool {
        return mx >= self.x and mx < self.x + self.width and
            my >= self.y and my < self.y + self.height;
    }

    pub fn getColors(self: *const PushButton) struct {
        bg: COLORREF,
        text: COLORREF,
        border: COLORREF,
    } {
        const colors = theme.getColors();
        if (!self.is_enabled) {
            return .{
                .bg = colors.button_disabled,
                .text = colors.button_disabled_text,
                .border = colors.button_disabled,
            };
        }
        return switch (self.state) {
            .pressed => .{
                .bg = colors.button_pressed,
                .text = colors.button_text,
                .border = colors.button_pressed,
            },
            .hover => .{
                .bg = colors.button_hover,
                .text = colors.button_text,
                .border = colors.button_hover,
            },
            else => .{
                .bg = colors.button_normal,
                .text = colors.button_text,
                .border = colors.button_normal,
            },
        };
    }
};

// ── Flat Text Box ── (1px bottom border only)

pub const MAX_TEXT_LEN: usize = 256;

pub const TextBox = struct {
    x: i32 = 0,
    y: i32 = 0,
    width: i32 = 200,
    height: i32 = theme.TEXTBOX_HEIGHT,
    text: [MAX_TEXT_LEN]u8 = [_]u8{0} ** MAX_TEXT_LEN,
    text_len: usize = 0,
    cursor_pos: usize = 0,
    selection_start: usize = 0,
    selection_end: usize = 0,
    scroll_offset: usize = 0,
    state: ControlState = .normal,
    is_password: bool = false,
    is_readonly: bool = false,
    is_enabled: bool = true,
    is_multiline: bool = false,
    max_length: usize = MAX_TEXT_LEN,
    placeholder: [48]u8 = [_]u8{0} ** 48,
    placeholder_len: usize = 0,

    pub fn getText(self: *const TextBox) []const u8 {
        return self.text[0..self.text_len];
    }

    pub fn setText(self: *TextBox, t: []const u8) void {
        const n = @min(t.len, self.max_length);
        @memcpy(self.text[0..n], t[0..n]);
        self.text_len = n;
        self.cursor_pos = n;
    }

    pub fn setPlaceholder(self: *TextBox, ph: []const u8) void {
        const n = @min(ph.len, self.placeholder.len);
        @memcpy(self.placeholder[0..n], ph[0..n]);
        self.placeholder_len = n;
    }

    pub fn insertChar(self: *TextBox, c: u8) bool {
        if (!self.is_enabled or self.is_readonly) return false;
        if (self.text_len >= self.max_length) return false;

        var i = self.text_len;
        while (i > self.cursor_pos) : (i -= 1) {
            self.text[i] = self.text[i - 1];
        }
        self.text[self.cursor_pos] = c;
        self.text_len += 1;
        self.cursor_pos += 1;
        return true;
    }

    pub fn deleteChar(self: *TextBox) bool {
        if (!self.is_enabled or self.is_readonly) return false;
        if (self.cursor_pos == 0) return false;

        var i = self.cursor_pos - 1;
        while (i < self.text_len - 1) : (i += 1) {
            self.text[i] = self.text[i + 1];
        }
        self.text_len -= 1;
        self.cursor_pos -= 1;
        return true;
    }

    pub fn hitTest(self: *const TextBox, mx: i32, my: i32) bool {
        return mx >= self.x and mx < self.x + self.width and
            my >= self.y and my < self.y + self.height;
    }

    pub fn getColors(self: *const TextBox) struct {
        bg: COLORREF,
        text_color: COLORREF,
        border: COLORREF,
        selection_bg: COLORREF,
        selection_text: COLORREF,
        placeholder_color: COLORREF,
    } {
        const colors = theme.getColors();
        if (!self.is_enabled) {
            return .{
                .bg = theme.RGB(0xF0, 0xF0, 0xF0),
                .text_color = colors.text_disabled,
                .border = theme.RGB(0xC0, 0xC0, 0xC0),
                .selection_bg = theme.RGB(0xC0, 0xC0, 0xC0),
                .selection_text = theme.RGB(0x00, 0x00, 0x00),
                .placeholder_color = colors.text_disabled,
            };
        }
        return .{
            .bg = colors.textbox_bg,
            .text_color = colors.text_primary,
            .border = if (self.state == .focused) colors.textbox_focus_border else colors.textbox_border,
            .selection_bg = colors.selection_bg,
            .selection_text = colors.selection_text,
            .placeholder_color = colors.text_secondary,
        };
    }
};

// ── Toggle Switch ── (wide rectangular, Metro-style)

pub const ToggleSwitch = struct {
    x: i32 = 0,
    y: i32 = 0,
    width: i32 = theme.TOGGLE_WIDTH,
    height: i32 = theme.TOGGLE_HEIGHT,
    is_on: bool = false,
    is_enabled: bool = true,
    state: ControlState = .normal,
    label: [MAX_LABEL_LEN]u8 = [_]u8{0} ** MAX_LABEL_LEN,
    label_len: usize = 0,

    pub fn getLabel(self: *const ToggleSwitch) []const u8 {
        return self.label[0..self.label_len];
    }

    pub fn setLabel(self: *ToggleSwitch, text: []const u8) void {
        const n = @min(text.len, MAX_LABEL_LEN);
        @memcpy(self.label[0..n], text[0..n]);
        self.label_len = n;
    }

    pub fn toggle(self: *ToggleSwitch) void {
        if (self.is_enabled) {
            self.is_on = !self.is_on;
        }
    }

    pub fn hitTest(self: *const ToggleSwitch, mx: i32, my: i32) bool {
        return mx >= self.x and mx < self.x + self.width and
            my >= self.y and my < self.y + self.height;
    }

    pub fn getColors(self: *const ToggleSwitch) struct {
        track: COLORREF,
        thumb: COLORREF,
        text: COLORREF,
    } {
        const colors = theme.getColors();
        if (!self.is_enabled) {
            return .{
                .track = colors.button_disabled,
                .thumb = theme.RGB(0xFF, 0xFF, 0xFF),
                .text = colors.text_disabled,
            };
        }
        return .{
            .track = if (self.is_on) colors.toggle_on else colors.toggle_off,
            .thumb = colors.toggle_thumb,
            .text = colors.text_primary,
        };
    }

    pub fn getStatusText(self: *const ToggleSwitch) []const u8 {
        return if (self.is_on) "On" else "Off";
    }
};

// ── App Bar ── (bottom command bar, Metro-style)

pub const MAX_APPBAR_ITEMS: usize = 8;
pub const MAX_APPBAR_LABEL_LEN: usize = 24;

pub const AppBarItem = struct {
    icon_id: u32 = 0,
    label: [MAX_APPBAR_LABEL_LEN]u8 = [_]u8{0} ** MAX_APPBAR_LABEL_LEN,
    label_len: usize = 0,
    command_id: u32 = 0,
    is_enabled: bool = true,
    state: ControlState = .normal,

    pub fn getLabel(self: *const AppBarItem) []const u8 {
        return self.label[0..self.label_len];
    }
};

pub const AppBar = struct {
    items: [MAX_APPBAR_ITEMS]AppBarItem = [_]AppBarItem{.{}} ** MAX_APPBAR_ITEMS,
    item_count: usize = 0,
    is_visible: bool = false,
    screen_width: i32 = 1024,

    pub fn addItem(self: *AppBar, label: []const u8, icon_id: u32, cmd_id: u32) bool {
        if (self.item_count >= MAX_APPBAR_ITEMS) return false;
        var item = &self.items[self.item_count];
        item.* = .{};
        item.icon_id = icon_id;
        item.command_id = cmd_id;
        const n = @min(label.len, MAX_APPBAR_LABEL_LEN);
        @memcpy(item.label[0..n], label[0..n]);
        item.label_len = n;
        self.item_count += 1;
        return true;
    }

    pub fn show(self: *AppBar) void {
        self.is_visible = true;
    }

    pub fn hide(self: *AppBar) void {
        self.is_visible = false;
    }

    pub fn getColors(_: *const AppBar) struct {
        bg: COLORREF,
        text: COLORREF,
        icon_hover: COLORREF,
    } {
        const colors = theme.getColors();
        return .{
            .bg = colors.app_bar_bg,
            .text = colors.app_bar_text,
            .icon_hover = colors.accent,
        };
    }
};

// ── Tile Control ── (live tile with title/subtitle)

pub const TileSize = enum(u8) {
    small = 0,
    medium = 1,
    wide = 2,
    large = 3,
};

pub const MAX_TILE_TITLE_LEN: usize = 32;
pub const MAX_TILE_SUBTITLE_LEN: usize = 48;

pub const Tile = struct {
    x: i32 = 0,
    y: i32 = 0,
    size: TileSize = .medium,
    title: [MAX_TILE_TITLE_LEN]u8 = [_]u8{0} ** MAX_TILE_TITLE_LEN,
    title_len: usize = 0,
    subtitle: [MAX_TILE_SUBTITLE_LEN]u8 = [_]u8{0} ** MAX_TILE_SUBTITLE_LEN,
    subtitle_len: usize = 0,
    icon_id: u32 = 0,
    bg_color: COLORREF = 0,
    is_live: bool = false,
    notification_count: u32 = 0,
    state: ControlState = .normal,
    target_path: [128]u8 = [_]u8{0} ** 128,
    target_path_len: usize = 0,
    group_index: u32 = 0,

    pub fn getTitle(self: *const Tile) []const u8 {
        return self.title[0..self.title_len];
    }

    pub fn setTitle(self: *Tile, text: []const u8) void {
        const n = @min(text.len, MAX_TILE_TITLE_LEN);
        @memcpy(self.title[0..n], text[0..n]);
        self.title_len = n;
    }

    pub fn getSubtitle(self: *const Tile) []const u8 {
        return self.subtitle[0..self.subtitle_len];
    }

    pub fn setSubtitle(self: *Tile, text: []const u8) void {
        const n = @min(text.len, MAX_TILE_SUBTITLE_LEN);
        @memcpy(self.subtitle[0..n], text[0..n]);
        self.subtitle_len = n;
    }

    pub fn getTargetPath(self: *const Tile) []const u8 {
        return self.target_path[0..self.target_path_len];
    }

    pub fn getWidth(self: *const Tile) i32 {
        return switch (self.size) {
            .small => theme.TILE_SMALL_W,
            .medium => theme.TILE_MEDIUM_W,
            .wide => theme.TILE_WIDE_W,
            .large => theme.TILE_LARGE_W,
        };
    }

    pub fn getHeight(self: *const Tile) i32 {
        return switch (self.size) {
            .small => theme.TILE_SMALL_H,
            .medium => theme.TILE_MEDIUM_H,
            .wide => theme.TILE_WIDE_H,
            .large => theme.TILE_LARGE_H,
        };
    }

    pub fn hitTest(self: *const Tile, mx: i32, my: i32) bool {
        return mx >= self.x and mx < self.x + self.getWidth() and
            my >= self.y and my < self.y + self.getHeight();
    }

    pub fn getColors(self: *const Tile) struct {
        bg: COLORREF,
        text: COLORREF,
    } {
        const colors = theme.getColors();
        const bg = if (self.bg_color != 0) self.bg_color else colors.tile_bg;
        return switch (self.state) {
            .hover => .{
                .bg = theme.lightenColor(bg, 25),
                .text = colors.tile_text,
            },
            .pressed => .{
                .bg = theme.darkenColor(bg, 20),
                .text = colors.tile_text,
            },
            else => .{
                .bg = bg,
                .text = colors.tile_text,
            },
        };
    }
};

// ── Progress Bar ── (flat Metro style)

pub const ProgressBar = struct {
    x: i32 = 0,
    y: i32 = 0,
    width: i32 = 200,
    height: i32 = 4,
    min_value: u32 = 0,
    max_value: u32 = 100,
    current_value: u32 = 0,
    is_indeterminate: bool = false,

    pub fn getPercentage(self: *const ProgressBar) u32 {
        const range = self.max_value - self.min_value;
        if (range == 0) return 0;
        return (self.current_value - self.min_value) * 100 / range;
    }

    pub fn getFillWidth(self: *const ProgressBar) i32 {
        const pct = self.getPercentage();
        return @divTrunc(self.width * @as(i32, @intCast(pct)), 100);
    }

    pub fn getColors(_: *const ProgressBar) struct {
        bg: COLORREF,
        fill: COLORREF,
    } {
        const colors = theme.getColors();
        return .{
            .bg = theme.RGB(0xE6, 0xE6, 0xE6),
            .fill = colors.accent,
        };
    }
};

// ── Tooltip ──

pub const Tooltip = struct {
    text: [128]u8 = [_]u8{0} ** 128,
    text_len: usize = 0,
    x: i32 = 0,
    y: i32 = 0,
    is_visible: bool = false,
    show_delay: u32 = 500,
    timer: u32 = 0,

    pub fn getText(self: *const Tooltip) []const u8 {
        return self.text[0..self.text_len];
    }

    pub fn show(self: *Tooltip, text: []const u8, x: i32, y: i32) void {
        const n = @min(text.len, self.text.len);
        @memcpy(self.text[0..n], text[0..n]);
        self.text_len = n;
        self.x = x;
        self.y = y;
        self.is_visible = true;
    }

    pub fn hide(self: *Tooltip) void {
        self.is_visible = false;
    }

    pub fn getColors(_: *const Tooltip) struct {
        bg: COLORREF,
        text_color: COLORREF,
    } {
        const colors = theme.getColors();
        return .{
            .bg = colors.tooltip_bg,
            .text_color = colors.tooltip_text,
        };
    }
};

// ── Initialization ──

pub fn init() void {}
