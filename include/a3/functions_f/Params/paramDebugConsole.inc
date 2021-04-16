/*
	Include this file to description.ext of your mission

	Optionally, you can set default value:
		#define DEBUGCONSOLE_DEFAULT	1

	Example:
	class Params
	{
		#include "\a3\Functions_F\Params\paramDebugConsole.inc"
	};
*/

#ifndef DEBUGCONSOLE_DEFAULT
	#define DEBUGCONSOLE_DEFAULT	0
#endif

class DebugConsole
{
	title = $STR_A3_paramDebugConsole_title;
	values[] = {0,1};
	texts[] = {$STR_DISABLED,$STR_ENABLED};
	default = DEBUGCONSOLE_DEFAULT;
};