class CfgNonAIVehicles {
    class EmptyDetector;
    class GVAR(emptyDetector): EmptyDetector {
        displayName = "Trigger (TMF Safestart)";
        class AttributeValues
        {
            size2[] = {0,0};
            size3[] = {0,0,-1};
            condition = QUOTE(time > 0 && not call FUNC(isActive));
            isServerOnly = true;
        };
    };
};
