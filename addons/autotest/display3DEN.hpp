class ctrlMenuStrip;
class Display3DEN
{
    class Controls
    {
        class MenuStrip : ctrlMenuStrip
        {
            class Items
            {
                class GVARMAIN(Folder) {
                    items[] += {QUOTE(ADDON)};
                };
                class ADDON
                {
                    text = "TMF Autotest";
                    action = QUOTE(edit3DENMissionAttributes QQGVAR(Attributes););
                    //picture = "\x\tmf\addons\common\UI\icon_gear_ca";
                };
            };
        };
    };
};
