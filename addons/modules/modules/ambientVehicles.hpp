class GVAR(ambientVehicles): Module_F
{
    scope = 2;
    scopeCurator = 0;
    displayName = "Ambient Vehicles";
    icon = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\car_ca.paa";
    category = "Teamwork";

    function = QFUNC(ambientVehicleInit);
    functionPriority = 10;
    isGlobal = 0;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 1;

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
            defaultValue = 0;
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
            control = "EditCodeMulti5";
        };

        class ModuleDescription: ModuleDescription{};
    };

    class ModuleDescription: ModuleDescription
    {
        description = "Populates roads with parked vehicles and objects.<br/>To use sync vehicles/objects and a TMF Area module.<br/>When used with a repeatable trigger, vehicles will be despawned if they are more than 500 meters from any player when the trigger is deactivated.";
        sync[] = {"AnyVehicle", QEGVAR(ai,area)};

        class EGVAR(ai,area)
        {
            description[] = {
                "Area in which vehicles will be spawned"
            };
            position = 1; // Position is taken into effect
            direction = 1; // Direction is taken into effect
            optional = 0; // Synced entity is optional
            duplicate = 0; // Multiple entities of this type can be synced
            synced[] = {}; // Pre-define entities like "AnyBrain" can be used. See the list below
        };
        class AnyVehicle
        {
            description[] = {
                "Vehicles that will be spawned in the area"
            };
            position = 0; // Position is taken into effect
            direction = 0; // Direction is taken into effect
            optional = 0; // Synced entity is optional
            duplicate = 1; // Multiple entities of this type can be synced
            synced[] = {}; // Pre-define entities like "AnyBrain" can be used. See the list below
        };
    };
};
