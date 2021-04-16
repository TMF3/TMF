/*
	Include this file to description.ext of your mission

	Optionally, you can set default value:
		#define WEATHER_DEFAULT	0.8

	Example:
	class Params
	{
		#include "\a3\Functions_F\Params\paramWeather.inc"
	};
*/

#ifndef WEATHER_DEFAULT
	#define WEATHER_DEFAULT	25
#endif

class Weather
{
	title = $STR_A3_rscattributeovercast_title;
	values[] = {0,25,50,75,100};
	texts[] = {
		$STR_A3_rscattributeovercast_value000_tooltip,
		$STR_A3_rscattributeovercast_value025_tooltip,
		$STR_A3_rscattributeovercast_value050_tooltip,
		$STR_A3_rscattributeovercast_value075_tooltip,
		$STR_A3_rscattributeovercast_value100_tooltip
	};
	default = WEATHER_DEFAULT;
	function = "BIS_fnc_paramWeather";
};