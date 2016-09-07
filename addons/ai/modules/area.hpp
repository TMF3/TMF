class GVAR(area) : Module_F
{
    scope = 2;
    displayName = "TMF Area";
    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    function = QFUNC(emptyFunction);
    // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isGlobal = 0;
    isTriggerActivated = 1;
    isDisposable = 0; // broken in EDEN;
    canSetArea = 1;
    class Attributes // Entity attributes have no categories, they are all defined directly in class Attributes
    {
    /*    class Shape
        {
            displayName = "Shape"; // Name assigned to UI control class Title
            tooltip = "Shape"; // Tooltip assigned to UI control class Title
            property = "IsRectangle"; // Unique config property name saved in SQM
            control = "ShapeTrigger"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

            // Expression called when applying the attribute in Eden and at the scenario start
            // The expression is called twice - first for data validation, and second for actual saving
            // Entity is passed as _this, value is passed as _value
            // %s is replaced by attribute config name. It can be used only once in the expression
            // In MP scenario, the expression is called only on server.
            expression = "_this setVariable ['%s',_value];";

            // Expression called when custom property is undefined yet (i.e., when setting the attribute for the first time)
            // Entity is passed as _this
            // Returned value is the default value
            // Used when no value is returned, or when it's of other type than NUMBER, STRING or ARRAY
            // Custom attributes of logic entities (e.g., modules) are saved always, even when they have default value
            defaultValue = "false";

            //--- Optional properties
            unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
            validate = "none"; // Validate the value before saving. Can be "none", "expression", "condition", "number" or "variable"
            condition = "logicModule"; // Condition for attribute to appear (see the table below)
            typeName = "BOOL"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
        };*/
    };
    class AttributeValues {
        size3[] = {500,500,-1};
    };
};
class GVAR(area_rectangle) : GVAR(area)
{
    displayName = "TMF Area (Rectangle)";
    class AttributeValues {
        isRectangle = 1;
        size3[] = {500,500,-1}; // you can give the area a height but the area scaling tool wont work and it will be reset to -1 every time.
    };
};
