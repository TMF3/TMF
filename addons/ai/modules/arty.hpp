
class GVAR(artillery) : Module_F
{
    scope = 2;
    displayName = "Artillery";
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
            property = "Debug";
            control = "Checkbox";
            defaultValue = false;
            expression = "_this setVariable ['%s',_value];";
            typeName = "BOOL";
        };
        class TimeBetweenShots
        {
            displayName = "Time between shots";
            tooltip = "The time between each series of firing";
            control = "Edit";
            property = "TimeBetweenShots";
            defaultValue = 5;
            expression = "_this setVariable ['%s',_value];";
            typeName = "NUMBER";
        };
        class Salvos
        {
            displayName = "Total salvos";
            tooltip = "The amount of times the units will shoot";
            control = "Edit";
            property = "Salvos";
            defaultValue = 5;
            expression = "_this setVariable ['%s',_value];";
            typeName = "NUMBER";
        };
        class RoundsPerSalvo
        {
            displayName = "Rounds per salvo";
            tooltip = "";
            control = "Edit";
            defaultValue = 1;
            property = "RoundsPerSalvo";
            expression = "_this setVariable ['%s',_value];";
            typeName = "NUMBER";
        };
        class Round
        {
            displayName = "Magazine";
            tooltip = "If empty will use the loaded ammo.";
            control = "Edit";
            property = "Round";
            defaultValue = 'default';
            expression = "_this setVariable ['%s',_value];";
            typeName = "STRING";
            validate = "none";
        };
    };
};
