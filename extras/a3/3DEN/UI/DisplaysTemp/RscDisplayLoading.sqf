#include "\A3\ui_f\hpp\defineResincl.inc"
#include "\A3\ui_f\hpp\defineResinclDesign.inc"

disableserialization;

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		_display = _params select 0;
		RscDisplayLoading_display = _display;

		//--- Initial loading - maintain visual style of RscDisplayStart
		if !(uinamespace getvariable ["BIS_initGame",false]) exitwith {};

		///////////////////////////////////////////////////////////////////////////////////////////

		//--- Hide start loading screen
		_ctrlLoadingStart = _display displayctrl IDC_LOADINGSTART_LOADINGSTART;
		_ctrlLoadingStart ctrlsetfade 1;
		_ctrlLoadingStart ctrlcommit 0;
		_pictureShot = "";

		//--- Map
		if (worldname != "") then {
			_ctrlMap = _display displayctrl IDC_LOADING_MAP;
			_ctrlMapName = _display displayctrl IDC_LOADING_MAPNAME;
			_ctrlMapAuthor = _display displayctrl IDC_LOADING_MAPAUTHOR;
			_ctrlMapDescription = _display displayctrl IDC_LOADING_MAPDESCRIPTION;

			_cfgWorld = configfile >> "cfgworlds" >> worldname;
			_worldName = gettext (_cfgWorld >> "description");
			_pictureMap = gettext (_cfgWorld >> "pictureMap");
			if (_pictureMap == "") then {_pictureMap = "#(argb,8,8,3)color(1,1,1,0.2)";};
			_pictureShot = gettext (_cfgWorld >> "pictureShot");
			_loadingTexts = getarray (_cfgWorld >> "loadingTexts");
			_loadingText = if (count _loadingTexts > 0) then {
				_loadingTexts select floor (((diag_ticktime / 10) % (count _loadingTexts)));
			} else {
				""
			};

			//--- Randomized map Y coordinate
			_worldType = uinamespace getvariable ["RscDisplayLoading_worldType",""];
			_ran = uinamespace getvariable ["RscDisplayLoading_ran",random 1];
			if (worldname != _worldType) then {
				_ran = random 1;
				uinamespace setvariable ["RscDisplayLoading_ran",_ran];
				uinamespace setvariable ["RscDisplayLoading_worldType",worldname];
			};
			_ctrlMapPos = ctrlposition _ctrlMap;
			_ctrlMapPos set [1,linearconversion [0,1,_ran,(safezoneY + safezoneH - (_ctrlMapPos select 3)),safezoneY,true]];
			_ctrlMap ctrlsetposition _ctrlMapPos;
			_ctrlMap ctrlcommit 0;

			//--- Set texts
			_ctrlMap ctrlsettext _pictureMap;
			_ctrlMapName ctrlsettext toupper _worldName;
			_ctrlMapAuthor ctrlsettext _author;
			_ctrlMapDescription ctrlsetstructuredtext parsetext _loadingText;

			[_cfgWorld,_ctrlMapAuthor] call bis_fnc_overviewauthor;
		};

		//--- Mission
		_fnc_loadMission = {

			disableserialization;
			_display = _this select 0;
			_isMultiplayer = servertime > 0;

			_ctrlMissionType = _display displayctrl IDC_LOADING_MISSIONGAMETYPE;
			_ctrlMissionName = _display displayctrl IDC_LOADING_MISSIONNAME;
			_ctrlMissionAuthor = _display displayctrl IDC_LOADING_MISSIONAUTHOR;
			_ctrlMissionPicture = _display displayctrl IDC_LOAD_MISSION_PICTURE;
			_ctrlMissionProgress = _display displayctrl IDC_PROGRESS_TIME;
			_ctrlMissionDescription = _display displayctrl IDC_LOADING_MISSIONDESCRIPTION;
			_ctrlMissionDescriptionEngine = _display displayctrl IDC_LOAD_MISSION_NAME;

			//--- Picture
			_loadingPicture = getmissionconfigvalue ["loadScreen",""];//gettext (missionconfigfile >> "loadScreen");
			if (_loadingPicture == "") then {_loadingPicture = getmissionconfigvalue ["overviewPicture",""]};//gettext (missionconfigfile >> "overviewPicture");}; //--- Use overview data

			//--- Mission name
			_loadingName = getmissionconfigvalue ["onLoadName",""];//gettext (missionconfigfile >> "onLoadName");
			if (_loadingName == "") then {
				_loadingName = if (briefingname != missionname) then {briefingname} else {""};
			};

			//--- Description
			//_loadingTextConfig = if (false) then {gettext (missionconfigfile >> "onLoadIntro")} else {gettext (missionconfigfile >> "onLoadMission")};
			_loadingTextConfig = getmissionconfigvalue ["onLoadMission",""];
			_loadingText = ctrltext _ctrlMissionDescriptionEngine;
			if (_loadingText == "") then {_loadingText = _loadingTextConfig;}; //--- Use overview data
			if (_loadingText in ["",localize "str_load_world"]) then {_loadingText = getmissionconfigvalue ["overviewText",""];};//gettext (missionconfigfile >> "overviewText");};

			//--- MP type
			_gameType = gettext (getMissionConfig "Header" >> "gameType");//gettext (missionconfigfile >> "Header" >> "gameType");
			_gameTypeName = gettext (configfile >> "CfgMPGameTypes" >> _gameType >> "name");
			if (_gameTypeName == "") then {_gameTypeName = gettext (configfile >> "CfgMPGameTypes" >> "Unknown" >> "name");};

			//_showMission = if (false) then {missionconfigfile >> "onLoadIntroTime"} else {missionconfigfile >> "onLoadMissionTime"};
			//_showMission = if (isnumber _showMission) then {getnumber _showMission > 0} else {true};
			//if (_showMission && (_loadingText != "" || _loadingPicture != "")) then {

			//--- When loading a different terrain, current mission is sometimes still available. Check if it belongs to the terrain.
			_last = uinamespace getvariable ["RscDisplayLoading_last",[worldname,missionname]];
			_lastWorld = _last select 0;
			_lastMission = _last select 1;
			_showMission = if (missionname == _lastMission) then {worldname == _lastWorld} else {true};
			uinamespace setvariable ["RscDisplayLoading_last",[worldname,missionname]];

			//--- Get loading bars
			_progressMap = _display displayctrl IDC_PROGRESS_PROGRESS;
			if (isnull _progressMap) then {_display displayctrl IDC_CLIENT_PROGRESS};
			_progressMission = _display displayctrl IDC_LOADING_PROGRESSMISSION;
			RscDisplayLoading_progress = _progressMap;

			//if (str missionconfigfile != "" && _showMission) then {
			if (_loadingText != "" || {_loadingPicture != ""}) then {
				_loadingName = _loadingName call (uinamespace getvariable "bis_fnc_localize");
				_loadingText = _loadingText call (uinamespace getvariable "bis_fnc_localize");

				if (_loadingName == "") then {_loadingName = localize "STR_a3_rscdisplay_loading_noname";};
				if (_loadingPicture == "") then {_loadingPicture = _pictureShot;};

				if (_gameTypeName != "" && _isMultiplayer) then {
					_ctrlMissionType ctrlsettext toupper _gameTypeName;
				} else {
					_ctrlMissionType ctrlshow false;
				};
				_ctrlMissionName ctrlsettext toupper _loadingName;
				_ctrlMissionPicture ctrlsettext _loadingPicture;
				_ctrlMissionDescription ctrlsetstructuredtext parsetext _loadingText;

				//--- Set height based on text
				_ctrlMissionDescriptionPos = ctrlposition _ctrlMissionDescription;
				_ctrlMissionDescriptionPos set [3,ctrltextheight _ctrlMissionDescription + 0.01];
				if (_loadingText == "") then {_ctrlMissionDescriptionPos set [3,0];};
				_ctrlMissionDescription ctrlsetposition _ctrlMissionDescriptionPos;
				_ctrlMissionDescription ctrlcommit 0;

				_ctrlMissionPos = ctrlposition _ctrlMission;
				_ctrlMissionPos set [3,(_ctrlMissionDescriptionPos select 1) + ((_ctrlMissionDescriptionPos select 3) min ((ctrlposition _ctrlMissionPicture select 3)))];
				_ctrlMission ctrlsetposition _ctrlMissionPos;
				_ctrlMission ctrlcommit 0;

				[missionconfigfile,_ctrlMissionAuthor] call bis_fnc_overviewauthor;


				//DLC notification--------------------------------------------------------------------

				//DLC asset was found in mission.sqm, DLC is available and unowned => show DLC loading screen.
				//Info is selected randomly among the non-owned DLCs + DLC Bundle
				_missionDLCs = [];
				{
					_appId = getNumber(configfile >> "CfgMods" >> _x >> "appId");
					_missionDLCs = _missionDLCs + [_appId];
				} foreach (getMissionDlcs); //Take all not owned DLCs and check whether they were released already. If yes, count them as not owned

				_notOwnedDLCs = [];
				_showDLCLoading = false;

				{
					if((isDlcAvailable _x) && (_x in _missionDLCs)) then
					{
						_notOwnedDLCs = _notOwnedDLCs + [_x];
						_showDLCLoading = true;
					};
				} foreach (getDlcs 2); //Take all not owned DLCs and check whether they were released already. If yes, count them as not owned

				if(_showDLCLoading) then
				{
					_selectedDLCAppId = uinamespace getvariable ['BIS_RscDisplayLoading_SelectedDLCAppId', 0];

					if(_selectedDLCAppId == 0) then
					{
						//_notOwnedDLCs is non-empty => add DLC Bundle
						//Bundles were meanwhile retired as products
						//_notOwnedDLCs = _notOwnedDLCs + [getNumber(configfile >> "CfgMods" >> "DLCBundle" >> "appId")];
						//Randomly select one of the non-owned DLCs and read info from it
						_selectedDLC = floor(random (count _notOwnedDLCs));
						_selectedDLCAppId = _notOwnedDLCs select _selectedDLC;
						uinamespace setvariable ["BIS_RscDisplayLoading_SelectedDLCAppId", _selectedDLCAppId];
					};

					{ //For each class from cfgMods
						if(getNumber(_x >> "appId") == _selectedDLCAppId) then
						{
							_dlcColor = getArray(_x >> "dlcColor");

							if(count _dlcColor != 4) then
							{
								_dlcColor = [
									(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77]),
									(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51]),
									(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08]),
									1];
							};

							//name
							_ctrl = _display displayctrl IDC_LOADING_DLCNAME;
							_ctrl ctrlSetText getText(_x >> "name");
							_ctrl ctrlSetTextColor _dlcColor;
							//author
							_ctrl = _display displayctrl IDC_LOADING_DLCAUTHOR;
							_ctrl ctrlSetText (format [localize "STR_FORMAT_AUTHOR_SCRIPTED", getText(_x >> "author")]);
							_ctrl ctrlSetTextColor _dlcColor;
							//stripe
							_ctrl = _display displayctrl IDC_LOADING_DLCSTRIPE;
							_ctrl ctrlSetTextColor _dlcColor;
							//logo
							_ctrl = _display displayctrl IDC_LOADING_DLCICON;
							_ctrl ctrlSetText getText(_x >> "logo");
							//picture background
							_ctrl = _display displayctrl IDC_LOADING_DLCPICTUREBACK;
							_ctrl ctrlSetBackgroundColor _dlcColor;
							//picture
							_ctrl = _display displayctrl IDC_LOADING_DLCPICTURE;
							_ctrl ctrlSetText getText(_x >> "overviewPicture");
							//description
							_ctrl = _display displayctrl IDC_LOADING_DLCDESCRIPTION;
							_ctrl ctrlSetStructuredText (parseText getText(_x >> "overviewText"));
						};
					} foreach ((configfile >> "CfgMods") call bis_fnc_returnChildren);
				};

				//--- Set height of description based on text
				_ctrlDLCDescription = _display displayctrl IDC_LOADING_DLCDESCRIPTION;
				_ctrlDLCDescriptionPos = ctrlposition _ctrlDLCDescription;
				_ctrlDLCDescriptionPos set [3, (ctrltextheight _ctrlDLCDescription) + 0.01]; //TODO-add proper grid
				_ctrlDLCDescription ctrlsetposition _ctrlDLCDescriptionPos;
				_ctrlDLCDescription ctrlcommit 0;

				//Show/hide DLC part of loading screen
				{
					(_display displayctrl _x) ctrlshow _showDLCLoading;
				}
				forEach
				[
					IDC_LOADING_DLCPICTUREBACK,
					IDC_LOADING_DLCPICTURE,
					IDC_LOADING_DLCDESCRIPTION,
					IDC_LOADING_DLCNAME,
					IDC_LOADING_DLCAUTHOR,
					IDC_LOADING_DLCSTRIPE,
					IDC_LOADING_DLCICON
				];

				//DLC notification--------------------------------------------------------------------


				//--- Mission loading bar
				_progressMapPos = ctrlposition _progressMap;
				_progressMissionPos = ctrlposition _progressMission;
				if (missionnamespace getvariable ["RscDisplayLoading_progressMission",false]) then {

					//--- Mission loading - make the terrain bar full and animate only the mission bar
					_progressMap ctrlsetposition _progressMissionPos;
					_progressMap ctrlcommit 0;
					_progressMission ctrlsetposition _progressMapPos;
					_progressMission ctrlcommit 0;
					_progressMission progresssetposition 1;
				} else {

					//--- When loading a different map, a rogue loading screen without progress bar appears. Move the progress bar by script.
					_limit = [1,2] select _isMultiplayer;
					if (count (uinamespace getvariable "loading_displays") > _limit) then {
						_progressMap ctrlshow false;
						_progressMission ctrlsetposition _progressMapPos;
						_progressMission ctrlcommit 0;
						_progressMission progresssetposition 0.33;
					} else {
						_progressMission ctrlshow false;
					};
				};
			} else {
				_ctrlMission ctrlsetfade 1;
				_ctrlMission ctrlcommit 0;
			};
		};

		_ctrlMission = _display displayctrl IDC_LOADING_MISSION;
		if (!(isnull _ctrlMission)) then {
			[_display,0] call _fnc_loadMission;
			//[_display,1] spawn _fnc_loadMission; //--- Spawn it for detecting text passed to the scripted loading, not used in the engine loading
		};

		//--- Disclaimer - Moved here to prevent showing Lite Disclaimer when starting/shutting down the game
		if (getnumber (configfile >> "CfgMods" >> "gamma") == 1) then
		{
			_ctrlDisclaimer = _display displayctrl IDC_LOADING_DISCLAIMER;
			_ctrlDisclaimerName = _display displayctrl IDC_LOADING_DISCLAIMERNAME;
			_ctrlDisclaimerDescription = _display displayctrl IDC_LOADING_DISCLAIMERDESCRIPTION;
			_productVersionArray = productversion;
			_versionNr = ctrltext ((finddisplay 0) displayctrl 118);

			if (_productVersionArray select 4 == "Development") then
			{
				_disclaimerName = format ["%1 - %2", localize "STR_A3_RSCDISPLAY_LOADING_DEV", _versionNr];

				if(_productVersionArray select 5) then
				{
					//Modded dev
					_disclaimerName = _disclaimerName + "<img image='A3\Ui_f\data\GUI\RscCommon\RscTrafficLight\TrafficLight_ca.paa'/>";
				};

				_ctrlDisclaimerName ctrlSetStructuredText parseText _disclaimerName;
				_ctrlDisclaimerDescription ctrlsetstructuredtext parsetext localize "STR_A3_RSCDISPLAY_LOADING_DEVINFO";
				_ctrlDisclaimerDescription ctrlsettextcolor [1,1,1,1];
				[_ctrlDisclaimerDescription,0.01] call bis_fnc_ctrlFitToTextHeight;
				_ctrlDisclaimer ctrlshow true;
			}
			else
			{
				if(_productVersionArray select 5) then
				{
					//Modded stable
					_ctrlDisclaimerName ctrlSetStructuredText parseText format ["%1 - %2%3", localize "STR_A3_RSCDISPLAY_LOADING_STABLE",
														  _versionNr,
														  "<img image='A3\Ui_f\data\GUI\RscCommon\RscTrafficLight\TrafficLight_ca.paa'/>"];

					_ctrlDisclaimerDescription ctrlsetstructuredtext parsetext localize "STR_A3_RSCDISPLAY_LOADING_MODDEDINFO";
					_ctrlDisclaimerDescription ctrlsettextcolor [1,1,1,1];
					[_ctrlDisclaimerDescription,0.01] call bis_fnc_ctrlFitToTextHeight;
					_ctrlDisclaimer ctrlshow true;
				}
				else
				{
					_ctrlDisclaimer ctrlshow false;
				};
			};
		};

		//--- Track mission time
/*
		if (str _display == "Display #101") then {
			[] call bis_fnc_trackMissionTime;
		};
*/
	};
};