[
	QGVAR(isJIPAllowed),
	"LIST",
	["JIP allowed", "If disallowed JIP players are placed in spectator. Only affects TMF spectator."],
	["TMF", "Spectator"],
	[[0,1,2],["Disallow", "Allow", "During Safestart"],2],
	1
] call CBA_fnc_addSetting;
