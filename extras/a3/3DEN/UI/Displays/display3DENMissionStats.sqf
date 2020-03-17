#include "\a3\3DEN\UI\resincl.inc"

params ["_mode","_params"];

if (_mode == "onLoad") exitwith {
	_params params ["_display"];
	_ctrlStats = _display displayctrl IDC_DISPLAY3DENMISSIONSTATS_STATS;

	all3denentities params ["_objects","_groups","_triggers","_logics","_waypoints","_markers","_layers","_comments"];

	{
		_x params ["_text","_expression","_indent"];
		_value = count call compile _expression;
		for "_i" from 1 to _indent do {_text = "    " + _text;};
		_id = _ctrlStats lbadd _text;
		_ctrlStats lbsetdata [_id,_expression];
		_ctrlStats lbsettextright [_id,str _value];
		if (_value == 0) then {
			_ctrlStats lbsetcolor [_id,[1,1,1,0.25]];
			_ctrlStats lbsetcolorright [_id,[1,1,1,0.25]];
		};
	} foreach [
		[
			localize "str_3den_object_textPlural",
			"_objects",
			0
		],
			[
				localize "str_team_switch_ai",
				"_objects select {!isnull group _x}",
				1
			],
			[
				localize "STR_3DEN_Object_Attribute_ControlMP_displayName",
				"_objects select {(_x get3denattribute 'ControlSP') # 0 || (_x get3denattribute 'ControlMP') # 0}",
				1
			],
			[
				localize "str_dn_vehicle",
				"_objects select {isnull group _x && _x iskindof 'AllVehicles'}",
				1
			],
			[
				localize "str_3den_object_attribute_simpleobject_displayName",
				"_objects select {(_x get3denattribute 'objectIsSimple') # 0}",
				1
			],
		[
			localize "STR_A3_RscDisplayCurator_modeGroups_tooltip",//localize "str_3den_group_textPlural",
			"_groups",
			0
		],
		[
			localize "str_3den_trigger_textPlural",
			"_triggers",
			0
		],
		[
			localize "str_3den_logic_textPlural",
			"_logics",
			0
		],
			[
				localize "STR_3DEN_Logic_Mode_Module",
				"_logics select {_x iskindof 'Module'}",
				1
			],
		[
			localize "str_3den_waypoint_textPlural",
			"_waypoints",
			0
		],
		[
			localize "str_3den_marker_textPlural",
			"_markers",
			0
		],
		[
			localize "str_3den_layer_textPlural",
			"_layers",
			0
		],
		[
			localize "str_3den_comment_textPlural",
			"_comments",
			0
		]
	];
	_ctrlStats lbsetcursel 0;
};

if (_mode == "select") exitwith {
	_params params ["_ctrlButton"];
	_display = ctrlparent _ctrlButton;
	_ctrlStats = _display displayctrl IDC_DISPLAY3DENMISSIONSTATS_STATS;

	all3denentities params ["_objects","_groups","_triggers","_logics","_waypoints","_markers","_layers","_comments"];
	set3denselected call compile (_ctrlStats lbdata lbcursel _ctrlStats);
	_display closedisplay 2;
};