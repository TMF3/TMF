class GVAR(ambientVehicles): Module_F
{
    scope = 2;
    scopeCurator = 0;
    displayName = "Ambient Vehicles";
    icon = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\car_ca.paa";
    category = "Teamwork";

    function = QFUNC(ambientVehicleInit);
    functionPriority = 1;
    isGlobal = false;
    isTriggerActivated = true;
    isDisposable = true;
    is3DEN = true;

    class Attributes: AttributesBase {
        class GVAR(vehicleNumber): Default {
            displayName = "Vehicle number";
            tooltip = "How many vehicles will be created.";
            property = QGVAR(DOUBLES(ambientVehicles,vehicleNumber));
            control = "EditShort";
            typeName = "NUMBER";
            expression = "_this setVariable ['%s', _value call BIS_fnc_parseNumberSafe, true];";
            defaultValue = """10""";
        };
        class GVAR(spacing): Default {
            displayName = "Vehicle spacing";
            tooltip = "How many road segments will between each vehicle.";
            property = QGVAR(DOUBLES(ambientVehicles,spacing));
            control = "EditShort";
            typeName = "NUMBER";
            expression = "_this setVariable ['%s', _value call BIS_fnc_parseNumberSafe, true];";
            defaultValue = """3""";
        };
        class GVAR(emptyCargo): Checkbox {
            property = QGVAR(DOUBLES(ambientVehicles,emptyCargo));
            displayName = "Empty vehicle cargo";
            tooltip = "Whether vehicles should spawn with empty cargo.";
            typeName = "BOOL";
            defaultValue = false;
        };
        class GVAR(lockedRate): Default {
            property = QGVAR(DOUBLES(ambientVehicles,lockedRate));
            displayName = "Vehicles locked";
            tooltip = "Percentage of spawned vehicles that will be locked.";
            control = "Slider";
            typeName = "NUMBER";
            expression = "_this setVariable ['%s', _value call BIS_fnc_parseNumberSafe, true];";
            defaultValue = 0;
        };
        class GVAR(code): Default {
            property = QGVAR(DOUBLES(ambientVehicles,code));
            displayName = "Vehicle init";
            tooltip = "Code executed on every vehicle created";
            defaultValue = "'params [""_vehicle""];'";
            expression = "_this setVariable ['%s',compile _value,true];";
            control = "cba_common_EditCodeMulti5";
        };

        class ModuleDescription: ModuleDescription{};
    };

    class ModuleDescription: ModuleDescription
    {
        description = "Populates roads with parked vehicles.<br/>To use sync vehicles and a TMF Area module.";
        sync[] = {"AnyVehicle", QEGVAR(ai,area)};

        class EGVAR(ai,area)
        {
            description[] = {
                "Area in which vehicles will be spawned"
            };
            position = true; // Position is taken into effect
            direction = true; // Direction is taken into effect
            optional = false; // Synced entity is optional
            duplicate = false; // Multiple entities of this type can be synced
            synced[] = {}; // Pre-define entities like "AnyBrain" can be used. See the list below
        };
        class AnyVehicle
        {
            description[] = {
                "Vehicles that will be spawned in the area"
            };
            position = false; // Position is taken into effect
            direction = false; // Direction is taken into effect
            optional = false; // Synced entity is optional
            duplicate = true; // Multiple entities of this type can be synced
            synced[] = {}; // Pre-define entities like "AnyBrain" can be used. See the list below
        };
    };
};
