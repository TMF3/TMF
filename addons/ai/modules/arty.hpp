
class GVAR(artillery) : Module_F
{
    scope = 2;
    displayName = "artillery";
    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    function = QFUNC(arty);
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
        class TimeBetweenShots
        {
            displayName = "Time between shots";
            tooltip = "The time between each series of firing";
            control = "Edit";
            validate = "number";
            property = "TimeBetweenShots";
            defaultValue = 5;
            typeName = "NUMBER"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
        };
        class Salvos
        {
            displayName = "Total salvos";
            tooltip = "The amount of times the units will shoot";
            control = "Edit";
            validate = "number";
            property = "Salvos";
            defaultValue = 5;
            typeName = "NUMBER"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
        };
        class RoundsPerSalvo
        {
            displayName = "Rounds per salvo";
            tooltip = "";
            control = "Edit";
            validate = "number";
            defaultValue = 1;
            property = "RoundsPerSalvo";
            typeName = "NUMBER"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
        };
        class Magazine
        {
            displayName = "Magazine";
            tooltip = "If empty will use the loaded ammo.";
            control = "Edit";
            validate = "string";
            defaultValue = "";
            property = "Magazine";
            typeName = "STRING"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
        };
    };
};
