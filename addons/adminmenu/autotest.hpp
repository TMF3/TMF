class DOUBLES(PREFIX,autotest) {
    class ADDON {
        code = QUOTE(                                                                                        \
            [ARR_2(                                                                                          \
                [ARR_2([1,'Admin log debriefing section not present'])],                                     \
                [ARR_2([-1,'Admin log debriefing section present'])]                                         \
            )] select (isClass (missionConfigFile >> 'CfgDebriefingSections' >> 'DOUBLES(PREFIX,adminlog)')) \
        );
    };
};
