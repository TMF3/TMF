class ctrlMenuStrip;
class Display3DEN
{
    class Controls
    {
        class MenuStrip : ctrlMenuStrip
        {
            class Items
            {
                class TMF_Folder {
                    items[] += {"TMF_Spectator_Settings"};
                };
                class TMF_Spectator_Settings
                {
                    text = "TMF Spectator Settings";
                    action = "[findDisplay 313] call CBA_settings_fnc_openSettingsMenu;"; // Spectator settings are CBA settings (TMF > Spectator)
                    picture = "\x\tmf\addons\common\UI\icon_gear_ca";
                };
            };
        };
    };
};
