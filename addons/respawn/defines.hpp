

// Control types
#ifndef CT_STATIC
#define CT_STATIC           0
#endif
#ifndef CT_BUTTON
#define CT_BUTTON           1
#endif
#ifndef CT_EDIT
#define CT_EDIT             2
#endif
#ifndef CT_SLIDER
#define CT_SLIDER           3
#endif
#ifndef CT_COMBO
#define CT_COMBO            4
#endif
#ifndef CT_LISTBOX
#define CT_LISTBOX          5
#endif
#ifndef CT_TOOLBOX
#define CT_TOOLBOX          6
#endif
#ifndef CT_CHECKBOXES
#define CT_CHECKBOXES       7
#endif
#ifndef CT_PROGRESS
#define CT_PROGRESS         8
#endif
#ifndef CT_HTML
#define CT_HTML             9
#endif
#ifndef CT_STATIC_SKEW
#define CT_STATIC_SKEW      10
#endif
#ifndef CT_ACTIVETEXT
#define CT_ACTIVETEXT       11
#endif
#ifndef CT_TREE
#define CT_TREE             12
#endif
#ifndef CT_STRUCTURED_TEXT
#define CT_STRUCTURED_TEXT  13
#endif
#ifndef CT_CONTEXT_MENU
#define CT_CONTEXT_MENU     14
#endif
#ifndef CT_CONTROLS_GROUP
#define CT_CONTROLS_GROUP   15
#endif
#ifndef CT_SHORTCUTBUTTON
#define CT_SHORTCUTBUTTON   16
#endif
#ifndef CT_XKEYDESC
#define CT_XKEYDESC         40
#endif
#ifndef CT_XBUTTON
#define CT_XBUTTON          41
#endif
#ifndef CT_XLISTBOX
#define CT_XLISTBOX         42
#endif
#ifndef CT_XSLIDER
#define CT_XSLIDER          43
#endif
#ifndef CT_XCOMBO
#define CT_XCOMBO           44
#endif
#ifndef CT_ANIMATED_TEXTURE
#define CT_ANIMATED_TEXTURE 45
#endif
#ifndef CT_OBJECT
#define CT_OBJECT           80
#endif
#ifndef CT_OBJECT_ZOOM
#define CT_OBJECT_ZOOM      81
#endif
#ifndef CT_OBJECT_CONTAINER
#define CT_OBJECT_CONTAINER 82
#endif
#ifndef CT_OBJECT_CONT_ANIM
#define CT_OBJECT_CONT_ANIM 83
#endif
#ifndef CT_LINEBREAK
#define CT_LINEBREAK        98
#endif
#ifndef CT_USER
#define CT_USER             99
#endif
#ifndef CT_MAP
#define CT_MAP              100
#endif
#ifndef CT_MAP_MAIN
#define CT_MAP_MAIN         101
#endif
#ifndef CT_LISTNBOX
#define CT_LISTNBOX         102
#endif

// Static styles
#ifndef ST_POS
#define ST_POS            0x0F
#endif
#ifndef ST_HPOS
#define ST_HPOS           0x03
#endif
#ifndef ST_VPOS
#define ST_VPOS           0x0C
#endif
#ifndef ST_LEFT
#define ST_LEFT           0x00
#endif
#ifndef ST_RIGHT
#define ST_RIGHT          0x01
#endif
#ifndef ST_CENTER
#define ST_CENTER         0x02
#endif
#ifndef ST_DOWN
#define ST_DOWN           0x04
#endif
#ifndef ST_UP
#define ST_UP             0x08
#endif
#ifndef ST_VCENTER
#define ST_VCENTER        0x0C
#endif

#ifndef ST_TYPE
#define ST_TYPE           0xF0
#endif
#ifndef ST_SINGLE
#define ST_SINGLE         0x00
#endif
#ifndef ST_MULTI
#define ST_MULTI          0x10
#endif
#ifndef ST_TITLE_BAR
#define ST_TITLE_BAR      0x20
#endif
#ifndef ST_PICTURE
#define ST_PICTURE        0x30
#endif
#ifndef ST_FRAME
#define ST_FRAME          0x40
#endif
#ifndef ST_BACKGROUND
#define ST_BACKGROUND     0x50
#endif
#ifndef ST_HUD_BACKGROUND
#define ST_HUD_BACKGROUND 0x80
#endif
#ifndef ST_TILE_PICTURE
#define ST_TILE_PICTURE   0x90
#endif
#ifndef ST_WITH_RECT
#define ST_WITH_RECT      0xA0
#endif
#ifndef ST_LINE
#define ST_LINE           0xB0
#endif

#ifndef ST_SHADOW
#define ST_SHADOW         0x100
#endif
#ifndef ST_NO_RECT
#define ST_NO_RECT        0x200
#endif
#ifndef ST_KEEP_ASPECT_RATIO
#define ST_KEEP_ASPECT_RATIO  0x800
#endif

#ifndef ST_TITLE
#define ST_TITLE          ST_TITLE_BAR + ST_CENTER
#endif

// Slider styles
#ifndef SL_DIR
#define SL_DIR            0x400
#endif
#ifndef SL_VERT
#define SL_VERT           0
#endif
#ifndef SL_HORZ
#define SL_HORZ           0x400
#endif

#ifndef SL_TEXTURES
#define SL_TEXTURES       0x10
#endif

// progress bar
#ifndef ST_VERTICAL
#define ST_VERTICAL       0x01
#endif
#ifndef ST_HORIZONTAL
#define ST_HORIZONTAL     0
#endif

// Listbox styles
#ifndef LB_TEXTURES
#define LB_TEXTURES       0x10
#endif
#ifndef LB_MULTI
#define LB_MULTI          0x20
#endif

// Tree styles
#ifndef TR_SHOWROOT
#define TR_SHOWROOT       1
#endif
#ifndef TR_AUTOCOLLAPSE
#define TR_AUTOCOLLAPSE   2
#endif

// MessageBox styles
#ifndef MB_BUTTON_OK
#define MB_BUTTON_OK      1
#endif
#ifndef MB_BUTTON_CANCEL
#define MB_BUTTON_CANCEL  2
#endif
#ifndef MB_BUTTON_USER
#define MB_BUTTON_USER    4
#endif


////////////////
//Base Classes//
////////////////

class respawnMenu_RscText
{
    idc = -1;
    type = 0; //%CT_STATIC
    style = 0;//ST_MULTI;
    linespacing = 1;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    text = "";
    shadow = 0;
    font = "PuristaLight";
    SizeEx = 1.5*0.02300;
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
};

class respawnMenu_RscCheckBox
{
    idc = -1;
    type = 77;
    style = 0;//ST_MULTI;
    linespacing = 1;
    color[] = {1,1,1,0.7};
    colorBackground[] = {0,0,0,0};
    colorBackgroundDisabled[] = {0,0,0,0};
    colorBackgroundFocused[] = {0,0,0,0};
    colorBackgroundHover[] = {0,0,0,0};
    colorBackgroundPressed[] = {0,0,0,0};
    colorDisabled[] = {1,1,1,0.2};
    colorFocused[] = {1,1,1,1};
    colorHover[] = {1,1,1,1};
    colorPressed[] = {1,1,1,1};
    colorText[] = {1,1,1,1};
    text = "";
    shadow = 0;
    font = "PuristaLight";
    SizeEx = 0.02300;
    fixedWidth = 0;
    soundClick[] = {"",0.1,1};
    soundEnter[] = {"",0.1,1};
    soundEscape[] = {"",0.1,1};
    soundPush[] = {"",0.1,1};
    textureChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
    textureDisabledChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
    textureDisabledUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
    textureFocusedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
    textureFocusedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
    textureHoverChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
    textureHoverUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
    texturePressedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
    texturePressedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
    textureUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
    tooltipColorBox[] = {1,1,1,1};
    tooltipColorShade[] = {0,0,0,0.65};
    tooltipColorText[] = {1,1,1,1};
    x = 0;
    y = 0;
    h = 0;
    w = 0;
};

class respawnMenu_RscCombo
{
    idc = -1;
    type = 4; //%CT_STATIC
    style = 0;//ST_MULTI;
    linespacing = 1;
    text = "";
    shadow = 0;
    font = "PuristaLight";
    sizeEx = "(            (            (            ((safeZoneW / safeZoneH) min 1.2) / 1.2) / 50) * 2)";
    fixedWidth = 0;
    arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
    arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
    x = 0;
    y = 0;
    h = 0;
    w = 0;
    colorActive[] = {1,0,0,1};
    colorBackground[] = {0,0,0,0.5};
    colorDisabled[] = {1,1,1,0.25};
    colorPicture[] = {1,1,1,1};
    colorPictureDisabled[] = {1,1,1,1};
    colorPictureSelected[] = {1,1,1,1};
    colorScrollbar[] = {1,0,0,1};
    colorSelect[] = {0,0,0,1};
    colorSelectBackground[] = {1,1,1,0.7};
    colorText[] = {1,1,1,1};

    soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
    soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
    soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};

    tooltipColorBox[] = {1,1,1,1};
    tooltipColorShade[] = {0,0,0,0.65};
    tooltipColorText[] = {1,1,1,1};
    wholeHeight = 0.45;
    maxHistoryDelay = 1;
    deletable = 0;
    fade = 0;
    class ComboScrollBar {
        color[] = {1, 1, 1, 0.6};
        colorActive[] = {1, 1, 1, 1};
        colorDisabled[] = {1, 1, 1, 0.3};
        shadow = 0;
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
};

class respawnMenu_RscPicture
{
    idc = -1;
    type = CT_STATIC;
    style = ST_PICTURE;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "PuristaLight";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;
};

class respawnMenu_RscButton
{
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,.9};
    colorDisabled[] = {0.4,0.4,0.4,0};
    colorBackground[] = {0,0,0,0.3};
    colorBackgroundDisabled[] = {0,0.0,0};
    colorBackgroundActive[] = {0,0,0,0.3};
    colorFocused[] = {0.75,0.75,0.75,.5};
    colorShadow[] = {0.023529,0,0.0313725,0.1};
    colorBorder[] = {0.023529,0,0.0313725,0.1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 2;
    font = "PuristaLight";
    sizeEx = 0.03921;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};

class respawnMenu_RscFrame
{
    type = CT_STATIC;
    idc = -1;
    style =  ST_BACKGROUND;//ST_FRAME;
    shadow = 2;
    colorBackground[] = {0,0,0,0.5};
    colorText[] = {1,1,1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
    text = "";
};

class respawnMenu_Box
{
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 2;
    colorBackground[] = { 0.2,0.9,0.5, 0.9};
    colorText[] = {1,1,1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
    text = "";
};

class respawnMenu_RscListBox {
    type = 5;
    w = 0.4;
    h = 0.4;
    rowHeight = 0;
    rowWidth = 0;
    colorText[] = {1, 1, 1, 1};
    colorScrollbar[] = {1, 0, 0, 0};
    colorSelect[] = {0, 0, 0, 1};
    colorSelect2[] = {0, 0, 0, 1};
    colorSelectBackground[] = {0.95, 0.95, 0.95, 0.6};
    colorSelectBackground2[] = {1, 1, 1, 0.5};
    colorBackground[] = {0, 0, 0, 0.2};
    soundSelect[] = {"", 0.1, 1};
    arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
    arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
    class ListScrollBar {
        color[] = {1, 1, 1, 0.6};
        colorActive[] = {1, 1, 1, 1};
        colorDisabled[] = {1, 1, 1, 0.3};
        shadow = 0;
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
    style = 528;
    font = "PuristaMedium";
    sizeEx = "(            (            (            ((safeZoneW / safeZoneH) min 1.2) / 1.2) / 50) * 2.1)";
    //sizeEx = 1;
    shadow = 0;
    colorShadow[] = {0, 0, 0, 0.5};
    color[] = {1, 1, 1, 0.1};
    colorDisabled[] = {1, 1, 1, 0.25};
    period = 1.2;
    maxHistoryDelay = 1;
    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
};

class respawnMenu_RscEdit
{
     type = CT_EDIT;
     style = ST_LEFT+ST_FRAME;
     x = 0;
     y = 0;
     h = 0.04;
     w = 0.2;
     colorBackground[] = {0,0,0,0};
     colorText[] = {1,1,1,1};
     colorSelection[] = {1,1,1,0.25};
     colorDisabled[] = {1, 1, 1, 0.25};
     font = "TahomaB";
     //sizeEx = 0.04;
     sizeEx = "(            (            (            ((safeZoneW / safeZoneH) min 1.2) / 1.2) / 50) * 1.6)";
     autocomplete = "";
     text = "";
     size = 0.2;
     shadow = 0;
};
