/*
	Author: Karel Moricky

	Set mission countdown (in seconds)
	You can optionally set minimum and maximum time (default is 600 and 3600):
		#define COUNTDOWN_MIN	300
		#define COUNTDOWN_MAX	1800

	Optionally, you can set default value:
		#define COUNTDOWN_DEFAULT	450

	Include this file in description.ext of your mission

	Example:
	class Params
	{
		#include "\a3\Functions_F\Params\paramCountdown.inc"
	};
*/

#ifndef COUNTDOWN_MIN
	#define COUNTDOWN_MIN	600
#endif
#ifndef COUNTDOWN_MAX
	#define COUNTDOWN_MAX	3600
#endif
#ifndef COUNTDOWN_DEFAULT
	#define COUNTDOWN_DEFAULT	-1
#endif

__EXEC(_countdownStep = COUNTDOWN_MAX * 0.1 - COUNTDOWN_MIN * 0.1;)
__EXEC(_countdown0 = COUNTDOWN_MIN + 0 * _countdownStep;)
__EXEC(_countdown1 = COUNTDOWN_MIN + 1 * _countdownStep;)
__EXEC(_countdown2 = COUNTDOWN_MIN + 2 * _countdownStep;)
__EXEC(_countdown3 = COUNTDOWN_MIN + 3 * _countdownStep;)
__EXEC(_countdown4 = COUNTDOWN_MIN + 4 * _countdownStep;)
__EXEC(_countdown5 = COUNTDOWN_MIN + 5 * _countdownStep;)
__EXEC(_countdown6 = COUNTDOWN_MIN + 6 * _countdownStep;)
__EXEC(_countdown7 = COUNTDOWN_MIN + 7 * _countdownStep;)
__EXEC(_countdown8 = COUNTDOWN_MIN + 8 * _countdownStep;)
__EXEC(_countdown9 = COUNTDOWN_MIN + 9 * _countdownStep;)
__EXEC(_countdown10 = COUNTDOWN_MIN + 10 * _countdownStep;)
__EXEC(_countdownFunction = uinamespace getvariable "bis_fnc_timeToString";)

class Countdown
{
	title = $STR_A3_paramCountdown_title;
	values[] = {
		-1,
		__EVAL(_countdown0),
		__EVAL(_countdown1),
		__EVAL(_countdown2),
		__EVAL(_countdown3),
		__EVAL(_countdown4),
		__EVAL(_countdown5),
		__EVAL(_countdown6),
		__EVAL(_countdown7),
		__EVAL(_countdown8),
		__EVAL(_countdown9),
		__EVAL(_countdown10)
	};
	texts[] = {
		$STR_DISABLED,
		__EVAL([_countdown0 / 3600] call _countdownFunction),
		__EVAL([_countdown1 / 3600] call _countdownFunction),
		__EVAL([_countdown2 / 3600] call _countdownFunction),
		__EVAL([_countdown3 / 3600] call _countdownFunction),
		__EVAL([_countdown4 / 3600] call _countdownFunction),
		__EVAL([_countdown5 / 3600] call _countdownFunction),
		__EVAL([_countdown6 / 3600] call _countdownFunction),
		__EVAL([_countdown7 / 3600] call _countdownFunction),
		__EVAL([_countdown8 / 3600] call _countdownFunction),
		__EVAL([_countdown9 / 3600] call _countdownFunction),
		__EVAL([_countdown10 / 3600] call _countdownFunction)
	};
	default = COUNTDOWN_DEFAULT;
	function = "BIS_fnc_paramCountdown";
};