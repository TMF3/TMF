class ctrlMenuStrip;
class ctrlControlsGroupNoScrollbars;
class ctrlCheckboxToolbar;
class Separator1;

class display3DEN
{
    class Controls
    {
        class MenuStrip : ctrlMenuStrip
        {
            class Items
            {
                items[] += {"TMF_Folder"};
                class TMF_Folder {
                    text = "TMF";
                    items[] = {"TMF_Documentation"};
                };
                class TMF_Documentation
                {
                    text = "TMF Wiki"; // engine adds ... to links
                    data = "HelpFeedback";
                    picture = "\a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa";
                    weblink = "http://teamonetactical.com/wiki/doku.php?id=tmf:start";
                    opensNewWindow = 1;
                };
            };
        };
        class Toolbar : ctrlControlsGroupNoScrollbars{
            class Controls {
                class Separator3: Separator1
                {
                    colorBackground[]={0,0,0,0.5};
                    x="33.5 *     (    5 * (pixelW * pixelGrid *     0.50))";
                    y="1 * (pixelH * pixelGrid *     0.50)";
                    w="pixelW";
                    h="(    5 * (pixelH * pixelGrid *     0.50))";
                };
                class TMF_Toolbar_Controls : ctrlControlsGroupNoScrollbars {
                    idc=-1;
                    x="34.5 * (5 * (pixelW * pixelGrid *     0.50))";
                    y="1 * (pixelH * pixelGrid *     0.50)";
                    w="5 *     (    5 * (pixelW * pixelGrid *     0.50))";
                    h="(    5 * (pixelH * pixelGrid *     0.50))";
                    class Controls
                    {
                        class Garrison: ctrlCheckboxToolbar
                        {
                            idc=-1;
                            onCheckedChanged=QUOTE(GVAR(Garrison) = !GVAR(Garrison));
                            onLoad="uiNamespace setVariable [""tmf_common_GarrisonControl"",_this select 0]; tmf_common_Garrison = false";
                            x="0 *     (    5 * (pixelW * pixelGrid *     0.50))";
                            y=0;
                            h="(    5 * (pixelH * pixelGrid *     0.50))";
                            w="(    5 * (pixelW * pixelGrid *     0.50))";
                            tooltip="TMF: Toggle garrison on dragging units";
                            textureChecked="\x\tmf\addons\common\UI\logo_tmf_small_toolbar_active_ca.paa";
                            textureUnchecked="\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
                            textureFocusedChecked="\x\tmf\addons\common\UI\logo_tmf_small_toolbar_active_ca.paa";
                            textureFocusedUnchecked="\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
                            textureHoverChecked="\x\tmf\addons\common\UI\logo_tmf_small_toolbar_active_ca.paa";
                            textureHoverUnchecked="\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
                            texturePressedChecked="\x\tmf\addons\common\UI\logo_tmf_small_toolbar_active_ca.paa";
                            texturePressedUnchecked="\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
                            textureDisabledChecked="\x\tmf\addons\common\UI\logo_tmf_small_toolbar_active_ca.paa";
                            textureDisabledUnchecked="\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
                        };
                    };
                };
            };
        };
    };
};
