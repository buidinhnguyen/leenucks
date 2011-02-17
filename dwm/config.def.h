/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "Dina 8";
#define NUMCOLORS 3                     // need at least 3
static const char colors[NUMCOLORS][ColLast][8] = {
	// border   foreground  background
	{ "#202020", "#757575", "#f0f0f0" }, // 0 = normal
	{ "#202020", "#f0f0f0", "#6d2857" }, // 1 = selected
	{ "#202020", "#ff3b77", "#ff0000" }, // 2 = urgent/warning
};
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */
static const Bool focusonclick      = True;     /* Change focus only on click */

/* tagging */
static const char *tags[] = { "1/main", "2/web", "3/gimp", "4/foo" };

static const Rule rules[] = {
	/* class            instance    title          tags mask     isfloating   monitor */
  { "luakit",         NULL,       NULL,          1 << 1,       False,       -1 },
  { "Minefield",      NULL,       NULL,          1 << 1,       False,       -1 },
  { "Namoroka",       NULL,       NULL,          1 << 1,       False,       -1 },
  { NULL,             "Browser",  NULL,          1 << 1,       True,        -1 },
  { "Chromium",       NULL,       NULL,          1 << 1,       False,       -1 },
  { "Gimp",           NULL,       NULL,          1 << 2,       True,        -1 },
  { "zathura",        NULL,       NULL,          1 << 3,       True,        -1 },
  { "mediathek-Main", NULL,       NULL,          1 << 3,       True,        -1 },
  { "Pokerth",        NULL,       NULL,          1 << 3,       True,        -1 },
  { "Qemulator",      NULL,       NULL,          1 << 3,       True,        -1 },
  { "Gajim.py",       NULL,       NULL,          1 << 3,       True,        -1 },
  { NULL,             NULL,       "LibreOffice", 1 << 3,       False,       -1 },
  { "feh",            NULL,       NULL,          0,            True,        -1 },
  { "MPlayer",        NULL,       NULL,          0,            True,        -1 },
  { NULL,             NULL,       "Save file",   0,            True,        -1 },
  { "XFontSel",       NULL,       NULL,          0,            True,        -1 },
};

/* layout(s) */
static const float mfact      = 0.50; /* factor of master area size [0.05..0.95] */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG], "-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
static const char *termcmd[] = { "urxvtc", NULL };
static const char scratchpadname[] = "scratchy";
static const char *scratchpadcmd[] = { "urxvtc", "-name", scratchpadname, "-geometry", "80x20", NULL };
static const char *mostusedcmd[] = { "mostused.sh", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
  { MODKEY,                       XK_x,      togglescratch,  {.v = scratchpadcmd} },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_v,      spawn,          {.v = mostusedcmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

