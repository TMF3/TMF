class GVAR(Rearm) : Module_F
{
    scope = 2;
    displayName = "Rearm Area";
    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    function = QFUNC(rearmInit);
    // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isGlobal = 2;
    isTriggerActivated = 1;
    isDisposable = 0; // broken in EDEN;
    canSetArea = 1;
    class Attributes // Entity attributes have no categories, they are all defined directly in class Attributes
    {
    };
    class AttributeValues {
        size3[] = {10,10,-1};
        isRectangle = 1;
    };
};
