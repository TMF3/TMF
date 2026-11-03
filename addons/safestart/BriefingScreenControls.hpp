class GVAR(safeStartText) : RscText
{
    idc = -1;
    text = ""; //--- ToDo: Localize;
    x = QUOTE((0.50-0.5/2) * safeZoneW + safeZoneX);
    y = QUOTE(safeZoneY);
    w = QUOTE(0.5 * safeZoneW);
    h = QUOTE(0.05 * safeZoneH);
    style = 0x02;
    SizeEx = "(((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 2)";
    colorText[] = {1,1,1,1};
    shadow = 2;
    font = "PuristaBold";

    onLoad = QUOTE(_this call FUNC(briefingText));
};
