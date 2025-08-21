/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }
/* appearance */
static const int sloppyfocus = 1; /* focus follows mouse */
static const int bypass_surface_visibility = 0; /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible  */
static const int smartgaps = 0; /* 1 means no outer gaps when there is only one window */
static const int monoclegaps = 1; /* 1 means outer gaps in monocle layout */
static const unsigned int borderpx = 4; /* border pixel of windows */
static const unsigned int gappih = 10; /* horizontal inner gap between windows */
static const unsigned int gappiv = 10; /* vertical inner gap between windows */
static const unsigned int gappoh = 10; /* horizontal outer gap between windows and screen edge */
static const unsigned int gappov = 10; /* vertical outer gap between windows and screen edge */
static const float rootcolor[] = COLOR(0x222222ff);
static const float bordercolor[] = COLOR(0x504945ff);
static const float focuscolor[] = COLOR(0xebdbb2ff);
static const float urgentcolor[] = COLOR(0xcc241dff);
/* This conforms to the xdg-protocol. Set the alpha to zero to restore the old behavior */
static const float fullscreen_bg[] = {0.1f, 0.1f, 0.1f, 1.0f}; /* You can also use glsl colors */

/* Autostart */
static const char *const autostart[] = {
    /* "dbus-update-activation-environment", "--systemd", "DISPLAY", "WAYLAND_DISPLAY", "XDG_CURRENT_DESKTOP", "XDG_SESSION_ID", NULL, */
    /* "systemctl", "--user", "import-environment", "{,WAYLAND_}DISPLAY", NULL, */
    /* "systemctl", "--user", "start", "dwl-session.target", NULL, */
    "/home/joppe/repos/configs/scripts/waybar/dwl-modules.sh", NULL,
    "/home/joppe/repos/configs/scripts/autostart/common-autostart.sh", NULL,
    "/home/joppe/repos/configs/scripts/autostart/workstation-autostart.sh", NULL,
    NULL /* terminate */
};

/* tagging - TAGCOUNT must be no greater than 31 */
#define TAGCOUNT (8)

/* logging */
static int log_level = WLR_ERROR;

/* NOTE: ALWAYS keep a rule declared even if you don't use rules (e.g leave at
 * least one example) */
static const Rule rules[] = {
    /* app_id             title       tags mask     isfloating   monitor */
    /* examples: */
    {"Gimp_EXAMPLE",      NULL,       0,            1,           -1}, /* Start on currently visible tags floating, not tiled */
    {"firefox_EXAMPLE",   NULL,       1 << 8,       0,           -1}, /* Start on ONLY tag "9" */
};

/* layout(s) */
static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile},
    {"><>", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* monitors */
/* (x=-1, y=-1) is reserved as an "autoconfigure" monitor position indicator
 * WARNING: negative values other than (-1, -1) cause problems with Xwayland
 * clients https://gitlab.freedesktop.org/xorg/xserver/-/issues/899
 */
/* NOTE: ALWAYS add a fallback rule, even if you are completely sure it won't be
 * used */
static const MonitorRule monrules[] = {
    /* name       mfact  nmaster scale layout       rotate/reflect x    y */
    /* example of a HiDPI laptop monitor:
    { "eDP-1",    0.5f,  1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,
    -1,  -1 },
    */
    /* defaults */
    {NULL, 0.5f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1},
};

/* keyboard */
static const struct xkb_rule_names xkb_rules = {
    /* can specify fields: rules, model, layout, variant, options */
    /* example:
    .options = "ctrl:nocaps",
    */
    .options = NULL,
};

static const int repeat_rate = 50;
static const int repeat_delay = 300;

/* Trackpad */
static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 0;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 0;
/* You can choose between:
LIBINPUT_CONFIG_SCROLL_NO_SCROLL
LIBINPUT_CONFIG_SCROLL_2FG
LIBINPUT_CONFIG_SCROLL_EDGE
LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN
*/
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;

/* You can choose between:
LIBINPUT_CONFIG_CLICK_METHOD_NONE
LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS
LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER
*/
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;

/* You can choose between:
LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE
*/
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;

/* You can choose between:
LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT
LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE
*/
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
static const double accel_speed = 0.0;

/* You can choose between:
LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
*/
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

/* If you want to use the windows key for MODKEY, use WLR_MODIFIER_LOGO */
#define MODKEY WLR_MODIFIER_LOGO

#define TAGKEYS(KEY, SKEY, TAG) \                                               
  {MODKEY,                       KEY,                     view,         {.ui = 1 << TAG} }, \
  {MODKEY | WLR_MODIFIER_CTRL,   KEY,                     toggleview,   {.ui = 1 << TAG} }, \
  {MODKEY | WLR_MODIFIER_SHIFT,  SKEY,                    tag,          {.ui = 1 << TAG} }, \
  {MODKEY | WLR_MODIFIER_CTRL | WLR_MODIFIER_SHIFT, SKEY, toggletag,    {.ui = 1 << TAG} }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *term[] = { "foot", NULL };
static const char *file_manager[] = { "foot", "-e", "yazi", NULL };
static const char *webbrowser[] = { "librewolf", NULL };
static const char *pavucontrol[] = { "pavucontrol", NULL };
static const char *launcher[] = { "fuzzel", NULL };
static const char *mako_restore[] = { "makoctl", "restore", NULL };
static const char *mako_close[] = { "makoctl", "dismiss", "--all", NULL };
static const char *audio_play_pause[] = { "playerctl", "play-pause", NULL };
static const char *audio_next[] = { "playerctl", "next", NULL };
static const char *audio_previous[] = { "playerctl", "previous", NULL };
static const char *kanshi_gaming[] = { "kanshictl", "switch", "gaming", NULL };
static const char *kanshi_desktop[] = { "kanshictl", "switch", "desktop", NULL };
static const char *xrandr[] = { "xrandr", "--output", "DP-1", "--primary", NULL };

/* keybinds */
static const Key keys[] = {
    /* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
    /* modifier                  			key                     function         argument */
    /* open a terminal */
    {MODKEY,                          XKB_KEY_t,              spawn,           {.v = term} },

    /* open file manager */
    {MODKEY,                          XKB_KEY_f,              spawn,           {.v = file_manager} },

    /* open a webbrowser */
    {MODKEY,                          XKB_KEY_w,              spawn,           {.v = webbrowser} },

    /* open pavucontrol */
    {MODKEY,                          XKB_KEY_a,              spawn,           {.v = pavucontrol} },

    /* open application launcher */
    {MODKEY,                          XKB_KEY_space,          spawn,           {.v = launcher} },

    /* open LLM launcher */
    {MODKEY,                          XKB_KEY_l,              spawn,           SHCMD("~/repos/configs/scripts/dmenu/llm-launcher.sh") },

    /* open theme switcher */
    {MODKEY | WLR_MODIFIER_SHIFT,     XKB_KEY_T,              spawn,           SHCMD("~/repos/configs/scripts/dmenu/theme-switcher.sh") },

    /* open compositor switcher */
    {MODKEY | WLR_MODIFIER_SHIFT,     XKB_KEY_C,              spawn,           SHCMD("~/repos/configs/scripts/dmenu/compositor-switcher.sh") },

    /* open powermenu */
    {MODKEY,                          XKB_KEY_Escape,         spawn,           SHCMD("~/repos/configs/scripts/dmenu/powermenu.sh") },

    /* Toggle hide/show Waybar */
    {MODKEY,                          XKB_KEY_b,              spawn,           SHCMD("~/repos/configs/scripts/waybar/toggle-bar.sh") },

    /* Mako notification history and close all notifications */
    {MODKEY,                          XKB_KEY_n,              spawn,           {.v = mako_restore} },
    {MODKEY,                          XKB_KEY_c,              spawn,           {.v = mako_close} },

    /* play/pause/previous/next keyboard controls */
    {0,                               XKB_KEY_XF86AudioPlay,  spawn,           {.v = audio_play_pause} },
    {0,                               XKB_KEY_XF86AudioNext,  spawn,           {.v = audio_next} },
    {0,                               XKB_KEY_XF86AudioPrev,  spawn,           {.v = audio_previous} },

    /* exit dwl */
    {MODKEY | WLR_MODIFIER_SHIFT,     XKB_KEY_Q,              quit,            {0} },

    /* close the focused window */
    {MODKEY,                          XKB_KEY_q,              killclient,      {0} },

    /* focus the next/previous window in the stack */
    {MODKEY,                          XKB_KEY_Right,          focusstack,      {.i = +1} },
    {MODKEY,                          XKB_KEY_Left,           focusstack,      {.i = -1} },

    /* move the focused window to the master position */
    {MODKEY,                          XKB_KEY_Return,         zoom,            {0} },

    /* decrease/increase the master/stack ratio */
    {MODKEY,                          XKB_KEY_KP_Subtract,    setmfact,        {.f = -0.05f} },
    {MODKEY,                          XKB_KEY_KP_Add,         setmfact,        {.f = +0.05f} },

    /* toggle float */
    {MODKEY | WLR_MODIFIER_SHIFT,     XKB_KEY_space,          togglefloating,  {0} },

    /* toggle fullscreen */
    {MODKEY | WLR_MODIFIER_SHIFT,     XKB_KEY_F,              togglefullscreen,{0} },

    /* focus workspace/move window to workspace */
    TAGKEYS(XKB_KEY_1,                XKB_KEY_exclam,         0),
    TAGKEYS(XKB_KEY_2,                XKB_KEY_at,             1),
    TAGKEYS(XKB_KEY_3,                XKB_KEY_numbersign,     2),
    TAGKEYS(XKB_KEY_4,                XKB_KEY_dollar,         3),
    TAGKEYS(XKB_KEY_5,                XKB_KEY_percent,        4),
    TAGKEYS(XKB_KEY_6,                XKB_KEY_asciicircum,    5),
    TAGKEYS(XKB_KEY_7,                XKB_KEY_ampersand,      6),
    TAGKEYS(XKB_KEY_8,                XKB_KEY_asterisk,       7),

    /* focus workspace/move window to workspace with numpad */
    TAGKEYS(XKB_KEY_KP_End,           XKB_KEY_KP_End,         0),
    TAGKEYS(XKB_KEY_KP_Down,          XKB_KEY_KP_Down,        1),
    TAGKEYS(XKB_KEY_KP_Next,          XKB_KEY_KP_Next,        2),
    TAGKEYS(XKB_KEY_KP_Left,          XKB_KEY_KP_Left,        3),
    TAGKEYS(XKB_KEY_KP_Begin,         XKB_KEY_KP_Begin,       4),
    TAGKEYS(XKB_KEY_KP_Right,         XKB_KEY_KP_Right,       5),
    TAGKEYS(XKB_KEY_KP_Home,          XKB_KEY_KP_Home,        6),
    TAGKEYS(XKB_KEY_KP_Up,            XKB_KEY_KP_Up,          7),

    /* move focus between outputs */
    {MODKEY | WLR_MODIFIER_CTRL,      XKB_KEY_Up,             focusmon,        {.i = WLR_DIRECTION_UP} },
    {MODKEY | WLR_MODIFIER_CTRL,      XKB_KEY_Down,           focusmon,        {.i = WLR_DIRECTION_DOWN} },

    /* send the focused window to the next/previous output */
    {MODKEY | WLR_MODIFIER_CTRL | WLR_MODIFIER_SHIFT, XKB_KEY_Up, tagmon,      {.i = WLR_DIRECTION_UP} },
    {MODKEY | WLR_MODIFIER_CTRL | WLR_MODIFIER_SHIFT, XKB_KEY_Down, tagmon,    {.i = WLR_DIRECTION_DOWN} },

    /* enable/disable adaptive sync */
    {MODKEY | WLR_MODIFIER_CTRL,      XKB_KEY_a,              spawn,           {.v = kanshi_gaming} },
    {MODKEY | WLR_MODIFIER_CTRL,      XKB_KEY_v,              spawn,           {.v = kanshi_desktop} },

    /* set primary xwayland display */
    {MODKEY | WLR_MODIFIER_CTRL,      XKB_KEY_x,              spawn,           {.v = xrandr} },

    /* open RGB light color switcher */
    {MODKEY | WLR_MODIFIER_SHIFT,     XKB_KEY_O,              spawn,           SHCMD("~/repos/configs/scripts/dmenu/rgb-switcher.sh") },

    /* toggle between workspaces? */
    {MODKEY,                          XKB_KEY_Tab,            view,            {0} },
    {MODKEY,                          XKB_KEY_0,              view,            {.ui = ~0} },
    {MODKEY | WLR_MODIFIER_SHIFT,     XKB_KEY_parenright,     tag,             {.ui = ~0} },

    /* leftover keybinds (i don't know what these are for yet or if i want to use them lol) */
    {MODKEY,                          XKB_KEY_i,              incnmaster,      {.i = +1} },
    {MODKEY,                          XKB_KEY_d,              incnmaster,      {.i = -1} },

    /* scratchpad keybinds ( can't get the patch to work right now, might try again later) */
    /* { MODKEY|WLR_MODIFIER_SHIFT, 	XKB_KEY_Z,              addscratchpad,   {0} }, */
    /* { MODKEY|WLR_MODIFIER_CTRL,  	XKB_KEY_z,              togglescratchpad,{0} }, */
    /* { MODKEY,                    	XKB_KEY_z,              removescratchpad,{0} }, */

    /* Ctrl-Alt-Backspace and Ctrl-Alt-Fx used to be handled by X server */
    {WLR_MODIFIER_CTRL | WLR_MODIFIER_ALT, XKB_KEY_Terminate_Server, quit, {0} },
/* Ctrl-Alt-Fx is used to switch to another VT, if you don't know what a VT is
 * do not remove them.
 */
#define CHVT(n) { WLR_MODIFIER_CTRL | WLR_MODIFIER_ALT, XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
    CHVT(1),
    CHVT(2),
    CHVT(3),
    CHVT(4),
    CHVT(5),
    CHVT(6),
    CHVT(7),
    CHVT(8),
    CHVT(9),
    CHVT(10),
    CHVT(11),
    CHVT(12),
};

static const Button buttons[] = {
  {MODKEY, BTN_LEFT, moveresize, {.ui = CurMove}},
  {MODKEY, BTN_MIDDLE, togglefloating, {0}},
  {MODKEY, BTN_RIGHT, moveresize, {.ui = CurResize}},
};
