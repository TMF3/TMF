class ctrlMenuStrip;
class display3DEN
{
    class Controls
    {
        class MenuStrip : ctrlMenuStrip
        {
            class Items
            {
                class GVARMAIN(Folder) {
                    items[] += {ADDON};
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
