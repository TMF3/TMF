class IGUIBack;
class RscPicture;
class RscText;
class RscTitles
{
	class GVAR(endSplash)
	{
		idd = 920528;
		duration = 99999999999;
        onLoad = "uiNamespace setVariable [""tmf_common_endSplash"", _this select 0]";
        class controls {
            class Background: IGUIBack
            {
                idc = TMF_ENDMISSION_BACK;
            	x = 0 * safezoneW + safezoneX;
            	y = 0 * safezoneH + safezoneY;
            	w = 1 * safezoneW;
            	h = 1 * safezoneH;
                colorBackground[] = {0,0,0,0.7};
            };
            class Picture: RscPicture
            {
            	idc = TMF_ENDMISSION_PICTURE;
            	text = "#(argb,8,8,3)color(1,1,1,0)";
            	x = 0.3 * safezoneW + safezoneX;
            	y = 0.2 * safezoneH + safezoneY;
            	w = 0.4 * safezoneW;
            	h = 0.4 * safezoneH;
            };
            class Header: RscText
            {
            	idc = TMF_ENDMISSION_HEADER;
            	text = "VICTORY"; //--- ToDo: Localize;
                style = ST_CENTER;
            	x = 0 * safezoneW + safezoneX;
            	y = 0 * safezoneH + safezoneY;
            	w = 1 * safezoneW;
            	h = 0.8 * safezoneH;
                color[] = {1,1,1,1};
            	sizeEx = 0.2 *safeZoneH;
                font = "PuristaBold";
                shadow = 0;
            };
            class Subtitle: RscText
            {
            	idc = TMF_ENDMISSION_SUBTILE;
                style = ST_MULTI + ST_NO_RECT + ST_CENTER;
            	text = "THE MASIF VALLEY REMAINS IN HEAD CONTROL"; //--- ToDo: Localize;
            	x = 0 * safezoneW + safezoneX;
            	y = 0.5 * safezoneH + safezoneY;
            	w = 1 * safezoneW;
            	h = 0.2 * safezoneH;
                color[] = {1,1,1,1};
                shadow = 0;
            	sizeEx = 0.025* safezoneH;
                font = "PuristaMedium";
            };
        };
	}
};
