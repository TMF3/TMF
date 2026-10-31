class RscDisplayArsenal
{
   class controls
   {
       class TMFexport : RscButtonMenu {
           x ="0.425079 * safeZoneW + safeZoneX";
           y = "0.951298 * safeZoneH + safeZoneY";
           w = "0.123399 * safeZoneW";
           h ="0.0188041 * safeZoneH";
           text = "Export as TMF Role";
           action = "[player,'test'] call tmf_assigngear_fnc_saveRole";
       };
   };
};
