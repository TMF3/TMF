/*
	Include this file to description.ext of your mission

	Optionally, you can set default value:
		#define GUERFRIENDLY_DEFAULT	1

	Example:
	class Params
	{
		#include "\a3\Functions_F\Params\paramGuerFriendly.inc"
	};
*/

#ifndef GUERFRIENDLY_DEFAULT
	#define GUERFRIENDLY_DEFAULT	-1
#endif

class GuerFriendly
{
	title = $STR_DISP_INTEL_EDIT_GUERILLA;
	values[] = {-1,1,0,2};
	texts[] = {
		$STR_DISP_INTEL_NONE_FRIENDLY,
		$STR_DISP_INTEL_WEST_FRIENDLY,
		$STR_DISP_INTEL_EAST_FRIENDLY,
		$STR_DISP_INTEL_BOTH_FRIENDLY
	};
	default = GUERFRIENDLY_DEFAULT;
	function = "BIS_fnc_paramGuerFriendly";
};