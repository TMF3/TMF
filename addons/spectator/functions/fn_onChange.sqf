#include "\x\tmf\addons\spectator\script_component.hpp"
params["_control","_path"];

_dat = _control tvData _path;
if(_dat != "") then
{
	 [ objectFromNetId _dat ] call FUNC(setTarget);
};