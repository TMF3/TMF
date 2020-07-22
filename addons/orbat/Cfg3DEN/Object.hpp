class Object
{
    // Categories collapsible in "Edit Attributes" window
    class AttributeCategories
    {
        // Category class, can be anything
        class TeamworkMarker
        {
            displayName = "TMF: Specialist Unit Marker"; // Category name visible in Edit Attributes window
            collapsed = 1; // When 1, the category is collapsed by default
            class Attributes
            {
                // Attribute class, can be anything
                class TMF_SpecialistMarker
                {
                    displayName = "Specialist unit icon"; // Name assigned to UI control class Title
                    tooltip = "Pick icon to use for this unit. It is recommended to not overly use markers on individual units."; // Tooltip assigned to UI control class Title
                    property = "TMF_SpecialistMarker"; // Unique config property name saved in SQM
                    control = "twUnitMarker"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                    unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                    condition = "objectBrain"; // Condition for attribute to appear (see the table below)
                    expression = "_this setVariable ['TMF_SpecialistMarker',_value,true];";
                    defaultValue = "["""",""""]";
                    wikiType = "[[String]]";
                };
                class TMF_OrbatParent
                {
                    property = "TMF_OrbatParent"; // Unique config property name saved in SQM
                    control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                    unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                    condition = "objectBrain"; // Condition for attribute to appear (see the table below)
                    expression = "_this setVariable ['TMF_OrbatParent',_value,true];";
                    defaultValue = "-1";
                };
            };
        };
        class TMF_orbat_vehicleCallsign
        {
            displayName = "TMF: Vehicle ORBAT";
            collapsed = 0;
            class Attributes
            {
                class TMF_orbat_vehicleCallsign
                {
                    property = "TMF_orbat_vehicleCallsign";
                    displayName = "Callsign";
                    tooltip = "Give vehicle a callsign to show on briefing screen.";
                    condition = "objectVehicle";
                    control = "Edit";
                    defaultValue = "''";
                    expression = "_this setVariable ['TMF_orbat_vehicleCallsign',_value,true];";
                    wikiType = "[[String]]";
                };
                class TMF_orbat_team
                {
                    property = "TMF_orbat_team";
                    displayName = "ORBAT Team";
                    tooltip = "Which team's ORBAT should this vehicle be apart of.";
                    condition = "objectVehicle";
                    control = "TMF_ORBAT_team";
                    expression = "_this setVariable ['TMF_orbat_team',_value,true];";
                    defaultValue = "''";
                    value = "''";
                    wikiType = "[[String]]";
                };
                class TMF_groupMarker
                {
                    property = "TMF_groupMarker"; // Unique config property name saved in SQM
                    control = "twGroupMarker"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                    unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                    condition = "objectVehicle"; // Condition for attribute to appear (see the table below)
                    expression = "_this setVariable ['TMF_groupMarker',_value,true];";//"[_this,['TMF_groupMarker',_value]] remoteExecCall ['setVariable',0,true];" //"_this setVariable ['TMF_groupMarker',_value,true];";
                    defaultValue = "'[]'";
                    wikiType = "[[String]]";
                };
                class TMF_OrbatParent
                {
                    property = "TMF_OrbatParent"; // Unique config property name saved in SQM
                    control = "None"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
                    unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                    condition = "objectVehicle"; // Condition for attribute to appear (see the table below)
                    expression = "_this setVariable ['TMF_OrbatParent',_value,true];";//"[_this,['TMF_OrbatParent',_value]] remoteExecCall ['setVariable',0,true];"; //_this setVariable ['TMF_OrbatParent',_value,true];";
                    defaultValue = "-1";
                };
            };
        };
    };
};
