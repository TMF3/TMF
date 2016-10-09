class ctrlMenuStrip;
class display3DEN
{
    class Controls
    {
        class MenuStrip : ctrlMenuStrip
        {
            class Items
            {
                class TMF_Folder {
                    items[] += {"TMF_Orbat_Settings"};
                };
                class TMF_Orbat_Settings
                {
                    text = "TMF ORBAT Settings";
                    action = "edit3DENMissionAttributes 'TMF_ORBAT_Settings';";
                    picture = "\x\tmf\addons\common\UI\icon_gear_ca";
                };
            };
        };
    };
};