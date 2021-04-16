/*
	Include this file in description.ext of your mission

	Optionally, you can set default value:
		#define DAYTIMEPERIOD_DEFAULT	18

	Example:
	class Params
	{
		#include "\a3\Functions_F\Params\paramDaytimePeriod.inc"
	};
*/

#ifndef DAYTIMEPERIOD_DEFAULT
	#define DAYTIMEPERIOD_DEFAULT	12
#endif

class Daytime
{
	title = $STR_A3_paramDaytimePeriod_title;
	values[] = {6,12,18,0};
	texts[] = {
		$STR_A3_paramDaytimePeriod_text1,
		$STR_A3_paramDaytimePeriod_text2,
		$STR_A3_paramDaytimePeriod_text3,
		$STR_A3_paramDaytimePeriod_text4
	};
	default = DAYTIMEPERIOD_DEFAULT;
	function = "BIS_fnc_paramDaytime";
};