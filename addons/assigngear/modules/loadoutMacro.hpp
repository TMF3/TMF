class GVAR(moduleLoadoutMacro) : Module_F
{
    // Standard object definitions
    scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
    displayName = "AI Loadout Macro"; // Name displayed in the menu

    category = "Teamwork";
    icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";
    // Name of function triggered once conditions are met
    function = FUNC(moduleAIMacro);
    // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
    functionPriority = 0;
    // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isGlobal = 0;
    // 1 to run init function in Eden Editor as well
    is3DEN = 1;

    class Attributes : AttributesBase
    {
        class TMF_subcategory
        {
            control = "SubCategoryNoHeader2";
            data = "AttributeSystemSubcategory";
            description = "Module assigns gear to all AI of a side according to a macro specified in the faction. See wiki for details."; //TODO: Wiki
            displayName = "";
            tooltip = "";
        };
        class TMF_aiGear_side : Combo
        {
            property = "TMF_aiGear_side";
            defaultValue = "0";
            displayName = "Side";
            tooltip = "Affected Side";
            typeName = "NUMBER";
            class Values
            {
                class EAST
                {
                    name = "Opfor";
                    value = 0;
                };
                class WEST
                {
                    name = "Blufor";
                    value = 1;
                };
                class RESISTANCE
                {
                    name = "Independent";
                    value = 2;
                };
                class CIVILIAN
                {
                    name = "Civilian";
                    value = 3;
                };
            };
        };

        class TMF_assignGear_side : Combo
        {
            /* assignGear_side was traditionally used as an attribute for storing the side in the old assign gear spec. It is now a dummy for the category.*/
            //if (!([[1,0,1]] call EFUNC(common,checkTMFVersion))) exitWith {};
            // getMissionConfigValue ["tmf_version",-1]
            property = "TMF_assignGear_side";
            displayName = "Category";
            tooltip = "Select a faction category.";
            condition = "logicModule";
            control = "TMF_Side";
            //expression = "_this setVariable ['TMF_aiGear_category',_value,true];";
            defaultValue = "-1"; /* (side _this) call BIS_fnc_sideID;*/
            wikiType = "[[Number]]";
        };
        class TMF_assignGear_faction : Combo
        {
            property = "TMF_assignGear_faction";
            displayName = "Faction";
            tooltip = "Select a faction.";
            condition = "logicModule";
            control = "TMF_Faction";
            //expression = "_this setVariable ['TMF_aiGear_faction',_value,true];";
            defaultValue = "toLower(faction _this)";
            wikiType = "[[String]]";
        };
        class TMF_aiGear_useTracer : Checkbox
        {
            displayName = "Use Tracer Ammo";
            property = "TMF_aiGear_useTracer";
            condition = "logicModule";
            tooltip = "When assigning ammo, tracer magazines will be prioritized.";
            defaultValue = "false";
            wikiType = "[[Bool]]";
        };
        class TMF_aiGear_addMedical : Checkbox
        {
            displayName = "Add Medical Supplies";
            property = "TMF_aiGear_addMedical";
            condition = "logicModule";
            tooltip = "Whether or not to add medical supplies to units.";
            defaultValue = "true";
            wikiType = "[[Bool]]";
        };
        class TMF_aiGear_addHMD : Checkbox
        {
            displayName = "Add HMD";
            property = "TMF_aiGear_addHMD";
            condition = "logicModule";
            tooltip = "Whether or not to add HMDs specified in the macro.";
            defaultValue = "true";
            wikiType = "[[Bool]]";
        };
        class TMF_aiGear_addFlashlight : Checkbox
        {
            displayName = "Add Flashlights";
            property = "TMF_aiGear_addFlashlight";
            condition = "logicModule";
            tooltip = "Whether or not to add flashlights to units if available.";
            defaultValue = "false";
            wikiType = "[[Bool]]";
        };
        class TMF_aiGear_forceFlashlight : Checkbox
        {
            displayName = "Force enable flashlights";
            property = "TMF_aiGear_forceFlashlight";
            condition = "logicModule";
            tooltip = "Whether or not to force flashlights to be enabled.";
            defaultValue = "false";
            wikiType = "[[Bool]]";
        };
        class TMF_aiGear_code
        {
            displayName = "Code On Unit Created";
            property = "TMF_aiGear_code";
            condition = "logicModule";
            control = "EditCodeMulti5";
            expression = "_this setVariable ['TMF_aiGear_code',compile _value]";
            tooltip = "Code executed on each affected unit. Unit is referenced in this code as _this.";
            defaultValue = "''";
            validate = "string";
            wikiType = "[[Code]]";
        };
        class TMF_aiGear_skill
        {
            displayName = "Skill Level";
            property = "TMF_aiGear_skill";
            condition = "logicModule";
            control = "Skill";
            expression = "_this setVariable ['TMF_aiGear_skill', _value]";
            tooltip = "Overall AI Skill level.";
            defaultValue = "0.5";
            wikiType = "[[Number]]";
        };
        class ModuleDescription: ModuleDescription {};


        class TMF_assignGear_role // Dummy
        {
            property = "TMF_assignGear_role";
            displayName = "Role";
            tooltip = "Select a role.";
            condition = "logicModule";
            control = "None";
            //expression = "_this setVariable ['TMF_assignGear_role',_value,true];";
            defaultValue = "'AI'";
            value = "''";
            wikiType = "[[String]]";
        };
        class TMF_assignGear_full // Dummy
        {
            property = "TMF_assignGear_full";
            condition = "logicModule";
            control = "None";
            expression = "_this setVariable ['TMF_aiGear_full',_value,true];"; //tmf_assignGear_fnc_helper
            defaultValue = "['AI','blu_f',false]";
        };
        class TMF_assignGear_enabled // Dummy
        {
            property = "TMF_assignGear_enabled";
            condition = "logicModule";
            control = "None";
            //expression = "_this setVariable ['TMF_assignGear_enabled',_value,true];";
            defaultValue = "true";
            wikiType = "[[Bool]]";
        };
    };

    class ModuleDescription: ModuleDescription {};
};
