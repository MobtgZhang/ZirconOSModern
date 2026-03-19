//! ZirconOS Modern Theme - Windows 8/8.1 Metro/Modern UI Visual Style
//! Flat UI with no gradients, no rounded corners, no shadows.
//! Bold flat color blocks, accent color system, tile sizes.

pub const COLORREF = u32;

pub fn RGB(r: u8, g: u8, b: u8) COLORREF {
    return @as(u32, r) | (@as(u32, g) << 8) | (@as(u32, b) << 16);
}

pub fn getRValue(color: COLORREF) u8 {
    return @intCast(color & 0xFF);
}

pub fn getGValue(color: COLORREF) u8 {
    return @intCast((color >> 8) & 0xFF);
}

pub fn getBValue(color: COLORREF) u8 {
    return @intCast((color >> 16) & 0xFF);
}

pub const ColorScheme = enum(u8) {
    dark_blue = 0,
    purple = 1,
    green = 2,
    red = 3,
    orange = 4,
};

pub const ThemeColors = struct {
    accent: COLORREF,
    accent_light: COLORREF,
    accent_dark: COLORREF,
    taskbar_bg: COLORREF,
    start_screen_bg: COLORREF,
    start_btn_bg: COLORREF,
    start_btn_hover: COLORREF,
    titlebar_active: COLORREF,
    titlebar_inactive: COLORREF,
    titlebar_text_active: COLORREF,
    titlebar_text_inactive: COLORREF,
    window_border_active: COLORREF,
    window_border_inactive: COLORREF,
    window_background: COLORREF,
    desktop_background: COLORREF,
    tile_bg: COLORREF,
    tile_text: COLORREF,
    tile_hover: COLORREF,
    charms_bg: COLORREF,
    charms_text: COLORREF,
    charms_hover: COLORREF,
    app_bar_bg: COLORREF,
    app_bar_text: COLORREF,
    button_normal: COLORREF,
    button_hover: COLORREF,
    button_pressed: COLORREF,
    button_text: COLORREF,
    button_disabled: COLORREF,
    button_disabled_text: COLORREF,
    text_primary: COLORREF,
    text_secondary: COLORREF,
    text_disabled: COLORREF,
    textbox_bg: COLORREF,
    textbox_border: COLORREF,
    textbox_focus_border: COLORREF,
    selection_bg: COLORREF,
    selection_text: COLORREF,
    toggle_on: COLORREF,
    toggle_off: COLORREF,
    toggle_thumb: COLORREF,
    lock_screen_bg: COLORREF,
    lock_screen_text: COLORREF,
    login_panel_bg: COLORREF,
    login_text: COLORREF,
    tray_bg: COLORREF,
    clock_text: COLORREF,
    tooltip_bg: COLORREF,
    tooltip_text: COLORREF,
    close_btn_hover: COLORREF,
    close_btn_pressed: COLORREF,
    context_menu_bg: COLORREF,
    context_menu_text: COLORREF,
    context_menu_hover: COLORREF,
    separator: COLORREF,
};

pub const MODERN_DARK_BLUE = ThemeColors{
    .accent = RGB(0x25, 0x72, 0xEB),
    .accent_light = RGB(0x3E, 0x8E, 0xF7),
    .accent_dark = RGB(0x1A, 0x56, 0xBB),
    .taskbar_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_screen_bg = RGB(0x25, 0x72, 0xEB),
    .start_btn_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_btn_hover = RGB(0x25, 0x72, 0xEB),
    .titlebar_active = RGB(0x25, 0x72, 0xEB),
    .titlebar_inactive = RGB(0x2B, 0x2B, 0x2B),
    .titlebar_text_active = RGB(0xFF, 0xFF, 0xFF),
    .titlebar_text_inactive = RGB(0x99, 0x99, 0x99),
    .window_border_active = RGB(0x25, 0x72, 0xEB),
    .window_border_inactive = RGB(0x50, 0x50, 0x50),
    .window_background = RGB(0xFF, 0xFF, 0xFF),
    .desktop_background = RGB(0x00, 0x78, 0xD7),
    .tile_bg = RGB(0x25, 0x72, 0xEB),
    .tile_text = RGB(0xFF, 0xFF, 0xFF),
    .tile_hover = RGB(0x3E, 0x8E, 0xF7),
    .charms_bg = RGB(0x1D, 0x1D, 0x1D),
    .charms_text = RGB(0xFF, 0xFF, 0xFF),
    .charms_hover = RGB(0x3E, 0x3E, 0x3E),
    .app_bar_bg = RGB(0x1D, 0x1D, 0x1D),
    .app_bar_text = RGB(0xFF, 0xFF, 0xFF),
    .button_normal = RGB(0x25, 0x72, 0xEB),
    .button_hover = RGB(0x3E, 0x8E, 0xF7),
    .button_pressed = RGB(0x1A, 0x56, 0xBB),
    .button_text = RGB(0xFF, 0xFF, 0xFF),
    .button_disabled = RGB(0xCC, 0xCC, 0xCC),
    .button_disabled_text = RGB(0x7E, 0x7E, 0x7E),
    .text_primary = RGB(0x00, 0x00, 0x00),
    .text_secondary = RGB(0x66, 0x66, 0x66),
    .text_disabled = RGB(0xA0, 0xA0, 0xA0),
    .textbox_bg = RGB(0xFF, 0xFF, 0xFF),
    .textbox_border = RGB(0x99, 0x99, 0x99),
    .textbox_focus_border = RGB(0x25, 0x72, 0xEB),
    .selection_bg = RGB(0x25, 0x72, 0xEB),
    .selection_text = RGB(0xFF, 0xFF, 0xFF),
    .toggle_on = RGB(0x25, 0x72, 0xEB),
    .toggle_off = RGB(0x99, 0x99, 0x99),
    .toggle_thumb = RGB(0xFF, 0xFF, 0xFF),
    .lock_screen_bg = RGB(0x00, 0x78, 0xD7),
    .lock_screen_text = RGB(0xFF, 0xFF, 0xFF),
    .login_panel_bg = RGB(0x25, 0x72, 0xEB),
    .login_text = RGB(0xFF, 0xFF, 0xFF),
    .tray_bg = RGB(0x1D, 0x1D, 0x1D),
    .clock_text = RGB(0xFF, 0xFF, 0xFF),
    .tooltip_bg = RGB(0x1D, 0x1D, 0x1D),
    .tooltip_text = RGB(0xFF, 0xFF, 0xFF),
    .close_btn_hover = RGB(0xE8, 0x11, 0x23),
    .close_btn_pressed = RGB(0xF1, 0x70, 0x7A),
    .context_menu_bg = RGB(0xFF, 0xFF, 0xFF),
    .context_menu_text = RGB(0x00, 0x00, 0x00),
    .context_menu_hover = RGB(0xDE, 0xDE, 0xDE),
    .separator = RGB(0xCC, 0xCC, 0xCC),
};

pub const MODERN_PURPLE = ThemeColors{
    .accent = RGB(0x88, 0x17, 0xAA),
    .accent_light = RGB(0xA4, 0x37, 0xC6),
    .accent_dark = RGB(0x6B, 0x0F, 0x88),
    .taskbar_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_screen_bg = RGB(0x88, 0x17, 0xAA),
    .start_btn_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_btn_hover = RGB(0x88, 0x17, 0xAA),
    .titlebar_active = RGB(0x88, 0x17, 0xAA),
    .titlebar_inactive = RGB(0x2B, 0x2B, 0x2B),
    .titlebar_text_active = RGB(0xFF, 0xFF, 0xFF),
    .titlebar_text_inactive = RGB(0x99, 0x99, 0x99),
    .window_border_active = RGB(0x88, 0x17, 0xAA),
    .window_border_inactive = RGB(0x50, 0x50, 0x50),
    .window_background = RGB(0xFF, 0xFF, 0xFF),
    .desktop_background = RGB(0x68, 0x21, 0x7A),
    .tile_bg = RGB(0x88, 0x17, 0xAA),
    .tile_text = RGB(0xFF, 0xFF, 0xFF),
    .tile_hover = RGB(0xA4, 0x37, 0xC6),
    .charms_bg = RGB(0x1D, 0x1D, 0x1D),
    .charms_text = RGB(0xFF, 0xFF, 0xFF),
    .charms_hover = RGB(0x3E, 0x3E, 0x3E),
    .app_bar_bg = RGB(0x1D, 0x1D, 0x1D),
    .app_bar_text = RGB(0xFF, 0xFF, 0xFF),
    .button_normal = RGB(0x88, 0x17, 0xAA),
    .button_hover = RGB(0xA4, 0x37, 0xC6),
    .button_pressed = RGB(0x6B, 0x0F, 0x88),
    .button_text = RGB(0xFF, 0xFF, 0xFF),
    .button_disabled = RGB(0xCC, 0xCC, 0xCC),
    .button_disabled_text = RGB(0x7E, 0x7E, 0x7E),
    .text_primary = RGB(0x00, 0x00, 0x00),
    .text_secondary = RGB(0x66, 0x66, 0x66),
    .text_disabled = RGB(0xA0, 0xA0, 0xA0),
    .textbox_bg = RGB(0xFF, 0xFF, 0xFF),
    .textbox_border = RGB(0x99, 0x99, 0x99),
    .textbox_focus_border = RGB(0x88, 0x17, 0xAA),
    .selection_bg = RGB(0x88, 0x17, 0xAA),
    .selection_text = RGB(0xFF, 0xFF, 0xFF),
    .toggle_on = RGB(0x88, 0x17, 0xAA),
    .toggle_off = RGB(0x99, 0x99, 0x99),
    .toggle_thumb = RGB(0xFF, 0xFF, 0xFF),
    .lock_screen_bg = RGB(0x68, 0x21, 0x7A),
    .lock_screen_text = RGB(0xFF, 0xFF, 0xFF),
    .login_panel_bg = RGB(0x88, 0x17, 0xAA),
    .login_text = RGB(0xFF, 0xFF, 0xFF),
    .tray_bg = RGB(0x1D, 0x1D, 0x1D),
    .clock_text = RGB(0xFF, 0xFF, 0xFF),
    .tooltip_bg = RGB(0x1D, 0x1D, 0x1D),
    .tooltip_text = RGB(0xFF, 0xFF, 0xFF),
    .close_btn_hover = RGB(0xE8, 0x11, 0x23),
    .close_btn_pressed = RGB(0xF1, 0x70, 0x7A),
    .context_menu_bg = RGB(0xFF, 0xFF, 0xFF),
    .context_menu_text = RGB(0x00, 0x00, 0x00),
    .context_menu_hover = RGB(0xDE, 0xDE, 0xDE),
    .separator = RGB(0xCC, 0xCC, 0xCC),
};

pub const MODERN_GREEN = ThemeColors{
    .accent = RGB(0x00, 0x8A, 0x00),
    .accent_light = RGB(0x10, 0xA8, 0x10),
    .accent_dark = RGB(0x00, 0x6A, 0x00),
    .taskbar_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_screen_bg = RGB(0x00, 0x8A, 0x00),
    .start_btn_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_btn_hover = RGB(0x00, 0x8A, 0x00),
    .titlebar_active = RGB(0x00, 0x8A, 0x00),
    .titlebar_inactive = RGB(0x2B, 0x2B, 0x2B),
    .titlebar_text_active = RGB(0xFF, 0xFF, 0xFF),
    .titlebar_text_inactive = RGB(0x99, 0x99, 0x99),
    .window_border_active = RGB(0x00, 0x8A, 0x00),
    .window_border_inactive = RGB(0x50, 0x50, 0x50),
    .window_background = RGB(0xFF, 0xFF, 0xFF),
    .desktop_background = RGB(0x00, 0x6A, 0x00),
    .tile_bg = RGB(0x00, 0x8A, 0x00),
    .tile_text = RGB(0xFF, 0xFF, 0xFF),
    .tile_hover = RGB(0x10, 0xA8, 0x10),
    .charms_bg = RGB(0x1D, 0x1D, 0x1D),
    .charms_text = RGB(0xFF, 0xFF, 0xFF),
    .charms_hover = RGB(0x3E, 0x3E, 0x3E),
    .app_bar_bg = RGB(0x1D, 0x1D, 0x1D),
    .app_bar_text = RGB(0xFF, 0xFF, 0xFF),
    .button_normal = RGB(0x00, 0x8A, 0x00),
    .button_hover = RGB(0x10, 0xA8, 0x10),
    .button_pressed = RGB(0x00, 0x6A, 0x00),
    .button_text = RGB(0xFF, 0xFF, 0xFF),
    .button_disabled = RGB(0xCC, 0xCC, 0xCC),
    .button_disabled_text = RGB(0x7E, 0x7E, 0x7E),
    .text_primary = RGB(0x00, 0x00, 0x00),
    .text_secondary = RGB(0x66, 0x66, 0x66),
    .text_disabled = RGB(0xA0, 0xA0, 0xA0),
    .textbox_bg = RGB(0xFF, 0xFF, 0xFF),
    .textbox_border = RGB(0x99, 0x99, 0x99),
    .textbox_focus_border = RGB(0x00, 0x8A, 0x00),
    .selection_bg = RGB(0x00, 0x8A, 0x00),
    .selection_text = RGB(0xFF, 0xFF, 0xFF),
    .toggle_on = RGB(0x00, 0x8A, 0x00),
    .toggle_off = RGB(0x99, 0x99, 0x99),
    .toggle_thumb = RGB(0xFF, 0xFF, 0xFF),
    .lock_screen_bg = RGB(0x00, 0x6A, 0x00),
    .lock_screen_text = RGB(0xFF, 0xFF, 0xFF),
    .login_panel_bg = RGB(0x00, 0x8A, 0x00),
    .login_text = RGB(0xFF, 0xFF, 0xFF),
    .tray_bg = RGB(0x1D, 0x1D, 0x1D),
    .clock_text = RGB(0xFF, 0xFF, 0xFF),
    .tooltip_bg = RGB(0x1D, 0x1D, 0x1D),
    .tooltip_text = RGB(0xFF, 0xFF, 0xFF),
    .close_btn_hover = RGB(0xE8, 0x11, 0x23),
    .close_btn_pressed = RGB(0xF1, 0x70, 0x7A),
    .context_menu_bg = RGB(0xFF, 0xFF, 0xFF),
    .context_menu_text = RGB(0x00, 0x00, 0x00),
    .context_menu_hover = RGB(0xDE, 0xDE, 0xDE),
    .separator = RGB(0xCC, 0xCC, 0xCC),
};

pub const MODERN_RED = ThemeColors{
    .accent = RGB(0xE5, 0x14, 0x00),
    .accent_light = RGB(0xF4, 0x43, 0x36),
    .accent_dark = RGB(0xB7, 0x10, 0x00),
    .taskbar_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_screen_bg = RGB(0xE5, 0x14, 0x00),
    .start_btn_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_btn_hover = RGB(0xE5, 0x14, 0x00),
    .titlebar_active = RGB(0xE5, 0x14, 0x00),
    .titlebar_inactive = RGB(0x2B, 0x2B, 0x2B),
    .titlebar_text_active = RGB(0xFF, 0xFF, 0xFF),
    .titlebar_text_inactive = RGB(0x99, 0x99, 0x99),
    .window_border_active = RGB(0xE5, 0x14, 0x00),
    .window_border_inactive = RGB(0x50, 0x50, 0x50),
    .window_background = RGB(0xFF, 0xFF, 0xFF),
    .desktop_background = RGB(0x9B, 0x1C, 0x00),
    .tile_bg = RGB(0xE5, 0x14, 0x00),
    .tile_text = RGB(0xFF, 0xFF, 0xFF),
    .tile_hover = RGB(0xF4, 0x43, 0x36),
    .charms_bg = RGB(0x1D, 0x1D, 0x1D),
    .charms_text = RGB(0xFF, 0xFF, 0xFF),
    .charms_hover = RGB(0x3E, 0x3E, 0x3E),
    .app_bar_bg = RGB(0x1D, 0x1D, 0x1D),
    .app_bar_text = RGB(0xFF, 0xFF, 0xFF),
    .button_normal = RGB(0xE5, 0x14, 0x00),
    .button_hover = RGB(0xF4, 0x43, 0x36),
    .button_pressed = RGB(0xB7, 0x10, 0x00),
    .button_text = RGB(0xFF, 0xFF, 0xFF),
    .button_disabled = RGB(0xCC, 0xCC, 0xCC),
    .button_disabled_text = RGB(0x7E, 0x7E, 0x7E),
    .text_primary = RGB(0x00, 0x00, 0x00),
    .text_secondary = RGB(0x66, 0x66, 0x66),
    .text_disabled = RGB(0xA0, 0xA0, 0xA0),
    .textbox_bg = RGB(0xFF, 0xFF, 0xFF),
    .textbox_border = RGB(0x99, 0x99, 0x99),
    .textbox_focus_border = RGB(0xE5, 0x14, 0x00),
    .selection_bg = RGB(0xE5, 0x14, 0x00),
    .selection_text = RGB(0xFF, 0xFF, 0xFF),
    .toggle_on = RGB(0xE5, 0x14, 0x00),
    .toggle_off = RGB(0x99, 0x99, 0x99),
    .toggle_thumb = RGB(0xFF, 0xFF, 0xFF),
    .lock_screen_bg = RGB(0x9B, 0x1C, 0x00),
    .lock_screen_text = RGB(0xFF, 0xFF, 0xFF),
    .login_panel_bg = RGB(0xE5, 0x14, 0x00),
    .login_text = RGB(0xFF, 0xFF, 0xFF),
    .tray_bg = RGB(0x1D, 0x1D, 0x1D),
    .clock_text = RGB(0xFF, 0xFF, 0xFF),
    .tooltip_bg = RGB(0x1D, 0x1D, 0x1D),
    .tooltip_text = RGB(0xFF, 0xFF, 0xFF),
    .close_btn_hover = RGB(0xE8, 0x11, 0x23),
    .close_btn_pressed = RGB(0xF1, 0x70, 0x7A),
    .context_menu_bg = RGB(0xFF, 0xFF, 0xFF),
    .context_menu_text = RGB(0x00, 0x00, 0x00),
    .context_menu_hover = RGB(0xDE, 0xDE, 0xDE),
    .separator = RGB(0xCC, 0xCC, 0xCC),
};

pub const MODERN_ORANGE = ThemeColors{
    .accent = RGB(0xDA, 0x6C, 0x00),
    .accent_light = RGB(0xF0, 0x8C, 0x20),
    .accent_dark = RGB(0xAA, 0x52, 0x00),
    .taskbar_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_screen_bg = RGB(0xDA, 0x6C, 0x00),
    .start_btn_bg = RGB(0x1D, 0x1D, 0x1D),
    .start_btn_hover = RGB(0xDA, 0x6C, 0x00),
    .titlebar_active = RGB(0xDA, 0x6C, 0x00),
    .titlebar_inactive = RGB(0x2B, 0x2B, 0x2B),
    .titlebar_text_active = RGB(0xFF, 0xFF, 0xFF),
    .titlebar_text_inactive = RGB(0x99, 0x99, 0x99),
    .window_border_active = RGB(0xDA, 0x6C, 0x00),
    .window_border_inactive = RGB(0x50, 0x50, 0x50),
    .window_background = RGB(0xFF, 0xFF, 0xFF),
    .desktop_background = RGB(0xAA, 0x52, 0x00),
    .tile_bg = RGB(0xDA, 0x6C, 0x00),
    .tile_text = RGB(0xFF, 0xFF, 0xFF),
    .tile_hover = RGB(0xF0, 0x8C, 0x20),
    .charms_bg = RGB(0x1D, 0x1D, 0x1D),
    .charms_text = RGB(0xFF, 0xFF, 0xFF),
    .charms_hover = RGB(0x3E, 0x3E, 0x3E),
    .app_bar_bg = RGB(0x1D, 0x1D, 0x1D),
    .app_bar_text = RGB(0xFF, 0xFF, 0xFF),
    .button_normal = RGB(0xDA, 0x6C, 0x00),
    .button_hover = RGB(0xF0, 0x8C, 0x20),
    .button_pressed = RGB(0xAA, 0x52, 0x00),
    .button_text = RGB(0xFF, 0xFF, 0xFF),
    .button_disabled = RGB(0xCC, 0xCC, 0xCC),
    .button_disabled_text = RGB(0x7E, 0x7E, 0x7E),
    .text_primary = RGB(0x00, 0x00, 0x00),
    .text_secondary = RGB(0x66, 0x66, 0x66),
    .text_disabled = RGB(0xA0, 0xA0, 0xA0),
    .textbox_bg = RGB(0xFF, 0xFF, 0xFF),
    .textbox_border = RGB(0x99, 0x99, 0x99),
    .textbox_focus_border = RGB(0xDA, 0x6C, 0x00),
    .selection_bg = RGB(0xDA, 0x6C, 0x00),
    .selection_text = RGB(0xFF, 0xFF, 0xFF),
    .toggle_on = RGB(0xDA, 0x6C, 0x00),
    .toggle_off = RGB(0x99, 0x99, 0x99),
    .toggle_thumb = RGB(0xFF, 0xFF, 0xFF),
    .lock_screen_bg = RGB(0xAA, 0x52, 0x00),
    .lock_screen_text = RGB(0xFF, 0xFF, 0xFF),
    .login_panel_bg = RGB(0xDA, 0x6C, 0x00),
    .login_text = RGB(0xFF, 0xFF, 0xFF),
    .tray_bg = RGB(0x1D, 0x1D, 0x1D),
    .clock_text = RGB(0xFF, 0xFF, 0xFF),
    .tooltip_bg = RGB(0x1D, 0x1D, 0x1D),
    .tooltip_text = RGB(0xFF, 0xFF, 0xFF),
    .close_btn_hover = RGB(0xE8, 0x11, 0x23),
    .close_btn_pressed = RGB(0xF1, 0x70, 0x7A),
    .context_menu_bg = RGB(0xFF, 0xFF, 0xFF),
    .context_menu_text = RGB(0x00, 0x00, 0x00),
    .context_menu_hover = RGB(0xDE, 0xDE, 0xDE),
    .separator = RGB(0xCC, 0xCC, 0xCC),
};

// ── Dimension Constants ── (0 corner radius, flat everywhere)

pub const TITLEBAR_HEIGHT: i32 = 32;
pub const TITLEBAR_BUTTON_WIDTH: i32 = 46;
pub const TITLEBAR_BUTTON_HEIGHT: i32 = 32;
pub const TITLEBAR_ICON_SIZE: i32 = 16;
pub const TITLEBAR_ICON_MARGIN: i32 = 8;
pub const TITLEBAR_TEXT_OFFSET_X: i32 = 28;
pub const TITLEBAR_TEXT_OFFSET_Y: i32 = 8;
pub const TITLEBAR_CORNER_RADIUS: i32 = 0;

pub const WINDOW_BORDER_WIDTH: i32 = 1;
pub const WINDOW_RESIZE_BORDER: i32 = 4;
pub const WINDOW_SHADOW_SIZE: i32 = 0;
pub const WINDOW_MIN_WIDTH: i32 = 136;
pub const WINDOW_MIN_HEIGHT: i32 = 39;

pub const TASKBAR_HEIGHT: i32 = 40;
pub const TASKBAR_BUTTON_HEIGHT: i32 = 40;
pub const TASKBAR_CLOCK_WIDTH: i32 = 90;

pub const START_BTN_WIDTH: i32 = 48;
pub const START_BTN_HEIGHT: i32 = 40;

pub const CHARMS_BAR_WIDTH: i32 = 86;
pub const CHARMS_ITEM_HEIGHT: i32 = 64;
pub const CHARMS_ICON_SIZE: i32 = 24;

// ── Tile Sizes ──

pub const TILE_SMALL_W: i32 = 70;
pub const TILE_SMALL_H: i32 = 70;
pub const TILE_MEDIUM_W: i32 = 150;
pub const TILE_MEDIUM_H: i32 = 150;
pub const TILE_WIDE_W: i32 = 310;
pub const TILE_WIDE_H: i32 = 150;
pub const TILE_LARGE_W: i32 = 310;
pub const TILE_LARGE_H: i32 = 310;
pub const TILE_GAP: i32 = 4;
pub const TILE_GROUP_GAP: i32 = 56;
pub const TILE_GROUP_HEADER_HEIGHT: i32 = 32;

// ── Start Screen ── (full-screen layout)

pub const STARTSCREEN_APP_LIST_WIDTH: i32 = 280;
pub const STARTSCREEN_TILE_AREA_MARGIN: i32 = 120;
pub const STARTSCREEN_SEARCH_HEIGHT: i32 = 40;
pub const STARTSCREEN_USER_AVATAR_SIZE: i32 = 40;

// ── Desktop (minimal) ──

pub const DESKTOP_ICON_SIZE: i32 = 48;
pub const DESKTOP_ICON_SPACING_X: i32 = 90;
pub const DESKTOP_ICON_SPACING_Y: i32 = 90;
pub const DESKTOP_ICON_TEXT_WIDTH: i32 = 80;
pub const DESKTOP_ICON_MARGIN: i32 = 10;

// ── Login / Lock Screen ──

pub const LOGIN_AVATAR_SIZE: i32 = 96;
pub const LOGIN_INPUT_WIDTH: i32 = 240;
pub const LOGIN_INPUT_HEIGHT: i32 = 32;
pub const LOGIN_BUTTON_WIDTH: i32 = 40;
pub const LOGIN_BUTTON_HEIGHT: i32 = 32;
pub const LOCK_TIME_FONT_SIZE: i32 = 80;
pub const LOCK_DATE_FONT_SIZE: i32 = 20;

// ── Controls ── (flat, no rounded corners)

pub const BUTTON_HEIGHT: i32 = 32;
pub const BUTTON_MIN_WIDTH: i32 = 80;
pub const BUTTON_CORNER_RADIUS: i32 = 0;
pub const TEXTBOX_HEIGHT: i32 = 32;
pub const TOGGLE_WIDTH: i32 = 44;
pub const TOGGLE_HEIGHT: i32 = 20;
pub const APP_BAR_HEIGHT: i32 = 60;
pub const TOOLTIP_PADDING: i32 = 6;
pub const MENU_ITEM_HEIGHT: i32 = 32;
pub const SCROLLBAR_WIDTH: i32 = 6;

// ── Font Definitions ── (Segoe UI family)

pub const FONT_SYSTEM = "Segoe UI";
pub const FONT_SYSTEM_SIZE: i32 = 11;
pub const FONT_LIGHT = "Segoe UI Light";
pub const FONT_LIGHT_SIZE: i32 = 11;
pub const FONT_SEMILIGHT = "Segoe UI Semilight";
pub const FONT_SEMILIGHT_SIZE: i32 = 11;
pub const FONT_TITLEBAR = "Segoe UI";
pub const FONT_TITLEBAR_SIZE: i32 = 11;
pub const FONT_TILE_TITLE = "Segoe UI Semilight";
pub const FONT_TILE_TITLE_SIZE: i32 = 12;
pub const FONT_TILE_SUBTITLE = "Segoe UI";
pub const FONT_TILE_SUBTITLE_SIZE: i32 = 9;
pub const FONT_STARTSCREEN_HEADER = "Segoe UI Light";
pub const FONT_STARTSCREEN_HEADER_SIZE: i32 = 22;
pub const FONT_STARTSCREEN_GROUP = "Segoe UI Semilight";
pub const FONT_STARTSCREEN_GROUP_SIZE: i32 = 14;
pub const FONT_LOCK_TIME = "Segoe UI Light";
pub const FONT_LOCK_TIME_SIZE: i32 = 80;
pub const FONT_LOCK_DATE = "Segoe UI Semilight";
pub const FONT_LOCK_DATE_SIZE: i32 = 20;
pub const FONT_CHARMS = "Segoe UI";
pub const FONT_CHARMS_SIZE: i32 = 10;
pub const FONT_CLOCK = "Segoe UI";
pub const FONT_CLOCK_SIZE: i32 = 11;
pub const FONT_TOOLTIP = "Segoe UI";
pub const FONT_TOOLTIP_SIZE: i32 = 9;

// ── Theme State ──

var current_scheme: ColorScheme = .dark_blue;
var current_colors: *const ThemeColors = &MODERN_DARK_BLUE;

pub fn setColorScheme(scheme: ColorScheme) void {
    current_scheme = scheme;
    current_colors = switch (scheme) {
        .dark_blue => &MODERN_DARK_BLUE,
        .purple => &MODERN_PURPLE,
        .green => &MODERN_GREEN,
        .red => &MODERN_RED,
        .orange => &MODERN_ORANGE,
    };
}

pub fn getColorScheme() ColorScheme {
    return current_scheme;
}

pub fn getColors() *const ThemeColors {
    return current_colors;
}

pub fn getThemeName() []const u8 {
    return switch (current_scheme) {
        .dark_blue => "Modern Dark Blue",
        .purple => "Modern Purple",
        .green => "Modern Green",
        .red => "Modern Red",
        .orange => "Modern Orange",
    };
}

pub fn darkenColor(color: COLORREF, amount: u8) COLORREF {
    const r = getRValue(color);
    const g = getGValue(color);
    const b = getBValue(color);
    const a: u16 = amount;
    const nr: u8 = if (r > amount) r - @as(u8, @intCast(a)) else 0;
    const ng: u8 = if (g > amount) g - @as(u8, @intCast(a)) else 0;
    const nb: u8 = if (b > amount) b - @as(u8, @intCast(a)) else 0;
    return RGB(nr, ng, nb);
}

pub fn lightenColor(color: COLORREF, amount: u8) COLORREF {
    const r = getRValue(color);
    const g = getGValue(color);
    const b = getBValue(color);
    const a: u16 = amount;
    const nr: u8 = if (@as(u16, r) + a < 256) r + @as(u8, @intCast(a)) else 255;
    const ng: u8 = if (@as(u16, g) + a < 256) g + @as(u8, @intCast(a)) else 255;
    const nb: u8 = if (@as(u16, b) + a < 256) b + @as(u8, @intCast(a)) else 255;
    return RGB(nr, ng, nb);
}

pub fn interpolateColor(c1: COLORREF, c2: COLORREF, t_num: u32, t_den: u32) COLORREF {
    if (t_den == 0) return c1;
    const r1: i32 = @intCast(c1 & 0xFF);
    const g1: i32 = @intCast((c1 >> 8) & 0xFF);
    const b1: i32 = @intCast((c1 >> 16) & 0xFF);
    const r2: i32 = @intCast(c2 & 0xFF);
    const g2: i32 = @intCast((c2 >> 8) & 0xFF);
    const b2: i32 = @intCast((c2 >> 16) & 0xFF);

    const t_n: i32 = @intCast(t_num);
    const t_d: i32 = @intCast(t_den);

    const r: u32 = @intCast(clamp(r1 + @divTrunc((r2 - r1) * t_n, t_d), 0, 255));
    const g: u32 = @intCast(clamp(g1 + @divTrunc((g2 - g1) * t_n, t_d), 0, 255));
    const b: u32 = @intCast(clamp(b1 + @divTrunc((b2 - b1) * t_n, t_d), 0, 255));

    return r | (g << 8) | (b << 16);
}

pub fn alphaBlend(src: COLORREF, dst: COLORREF, alpha: u8) COLORREF {
    const a: u32 = alpha;
    const inv_a: u32 = 255 - a;
    const sr: u32 = src & 0xFF;
    const sg: u32 = (src >> 8) & 0xFF;
    const sb: u32 = (src >> 16) & 0xFF;
    const dr: u32 = dst & 0xFF;
    const dg: u32 = (dst >> 8) & 0xFF;
    const db: u32 = (dst >> 16) & 0xFF;

    const r = (sr * a + dr * inv_a) / 255;
    const g_val = (sg * a + dg * inv_a) / 255;
    const b_val = (sb * a + db * inv_a) / 255;
    return (r & 0xFF) | ((g_val & 0xFF) << 8) | ((b_val & 0xFF) << 16);
}

fn clamp(val: i32, min_val: i32, max_val: i32) i32 {
    if (val < min_val) return min_val;
    if (val > max_val) return max_val;
    return val;
}

pub fn init() void {
    current_scheme = .dark_blue;
    current_colors = &MODERN_DARK_BLUE;
}
