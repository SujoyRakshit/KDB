/Append one or more characters into mid of the string
append_mid:{[lst;appendVal;indx] (indx#lst),appendVal,(indx _ lst)};

/Format a number into comma separated string value
/eg. numFmt[500000]
/"5,00,000"
/numFmt["500000"]
/"5,00,000"
numIndFmt:{x:$[not 10=abs type x;string x;x];if[3>=count x;:x];l:-3$x; x:-3_ x;idx:count'[-1_{-2_x}\[x]];({append_mid[x;",";y]}/ [x;idx]),l};

/Not tested
/numWestFmt:{x:$[not 10=abs type x;string x;x];if[3>=count x;:x];l:-3$x; x:-3_ x;idx:count'[-1_{-3_x}\[x]];({append_mid[x;",";y]}/ [x;idx]),l};
