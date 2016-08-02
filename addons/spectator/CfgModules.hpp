

class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class ArgumentsBaseUnits
		{
			class Units;
		};
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class GVAR(module) : Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Spectator: Show Objective"; // Name displayed in the menu

		category = "Teamwork";
        icon = "\x\tmf\addons\common\UI\logo_tmf_small_ca.paa";

		// Name of function triggered once conditions are met
		function = QFUNC(objectiveModule);
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 0;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 2;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 1;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 0; // broken in EDEN;

		// Menu displayed when the module is placed or double-clicked on by Zeus


		// Module arguments
		class Arguments: ArgumentsBaseUnits
		{
			// Module specific arguments
			class Icon
				{
				displayName = "Icon (.paa)"; // Argument label
				description = "Path to ICON"; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
			};
			class Text
				{
				displayName = "Text"; // Argument label
				description = ""; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "Objective Alpha";
			};
			class Color
				{
				displayName = "Color"; // Argument label
				description = "[Red,Green,Blue,Alpha]"; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "[1,0,0,1]";
			};
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Short module description"; // Short description, will be formatted as structured text
			sync[] = {"Men"}; // Array of synced entities (can contain base classes)
			class unit
			{
				description = "Any unit";
				displayName = "Any unit"; // Custom name
				icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
				side = 1; // Custom side (will determine icon color)
			};
		};
	};
};
