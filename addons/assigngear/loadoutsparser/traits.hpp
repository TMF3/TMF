code = "{ \
    if ((_x # 0) in ['audibleCoef','camouflageCoef ','loadCoef ','engineer','explosiveSpecialist','medic','UAVHacker']) then { \
        _this setUnitTrait _x;\
    } else { \
        _this setUnitTrait (_x + [true]) \
    }; \
} forEach %1;";
