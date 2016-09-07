
class GVAR(garrison) : Module_F
{
    scope = 2;
    displayName = "Garrison";
    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    function = QFUNC(garrison);
    // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isGlobal = 0;
    isTriggerActivated = 1;
    isDisposable = 0; // broken in EDEN;
    class Attributes
    {
        class Debug
        {
            displayName = "Debug mode";
            tooltip = "Shows units";
            property = "debug";
            control = "Checkbox";
            defaultValue = false;
            expression = "_this setVariable ['%s',_value];";
        };
        class Hold
        {
            displayName = "Hold position";
            tooltip = "Forces units to stay put and never move.";
            property = "holdPos";
            control = "Checkbox";
            defaultValue = false;
            expression = "_this setVariable ['%s',_value];";
        };
        class unitRatio
        {
            displayName = "Unit ratio";
            tooltip = "Decides on how many to put in each house..";
            property = "unitRatio";
            control = "Slider";
            defaultValue = 0.7;
            expression = "_this setVariable ['%s',_value];";
        };
        class houseRatio
        {
            displayName = "House ratio";
            tooltip = "How many house to put units in..";
            property = "unitHouse";
            control = "Slider";
            defaultValue = 0.7;
            expression = "_this setVariable ['%s',_value];";
        };
    };
};
