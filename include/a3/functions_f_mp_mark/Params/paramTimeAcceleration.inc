/*
	Include this file to description.ext of your mission

	Optionally, you can set default value:
		#define TIMEACCELERATION_DEFAULT 1

	Example:
	class Params
	{
		#include "\a3\Functions_F_MP_Mark\Params\paramTimeAcceleration.inc"
	};
*/

#ifndef TIMEACCELERATION_DEFAULT
	#define TIMEACCELERATION_DEFAULT 1
#endif

class TimeAcceleration
{
	title = $STR_usract_time_inc;
	values[] = {1,2,5,10,20};
	texts[] = {
		"x1",
		"x2",
		"x5",
		"x10",
		"x20"
	};
	default = TIMEACCELERATION_DEFAULT;
	function = "BIS_fnc_paramTimeAcceleration";
};