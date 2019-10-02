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
    functionPriority = 1;
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
        class TMF_assignGear_role //Dummy
        {
            property = "TMF_assignGear_role";
            displayName = "Role";
            tooltip = "Select a role.";
            condition = "logicModule";
            control = "None";
            //expression = "_this setVariable ['TMF_assignGear_role',_value,true];";
            defaultValue = "'r'";
            value = "''";
            wikiType = "[[String]]";
        };
        class TMF_assignGear_full
        {
            property = "TMF_assignGear_full";
            condition = "logicModule";
            control = "None";
            expression = "_this setVariable ['TMF_assignGear_role',_value,true];"; //tmf_assignGear_fnc_helper
            defaultValue = "['r','',false]";
        };
        class TMF_assignGear_enabled
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
