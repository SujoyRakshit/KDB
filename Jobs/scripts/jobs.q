configDict:.Q.opt .z.x;
system"l ",first configDict[`jobsFunc];
system"l ",first configDict[`schema];
.jobs.jobsFromConfig::("S***T*B";enlist ",")0: first hsym`$configDict[`config];

/ end of day: save, clear, hdb reload
.u.end:{t:`jobs;t@:where `g=attr each t@\:`sym;.[`t;();0#];@[;`sym;`g#] each t};

/ init schema and sync up from log file
.u.rep:{(.[;();:;].)each x;if[null first y;:()];-11!y};

init:{
    .u.rep .(hopen `$"::",first configDict[`tpPort])"(.u.sub[`;`];`.u `i`L)";
    .jobs.jobScheduler'[.jobs.jobsFromConfig];
    `t set ([] sym:10?`2; bid:10?90.9; ask:10?89.9; loc:10?`HKH`LOH`NYK);
    .z.ts:{.jobs.jobRun[]};
    .z.pd:{n:abs system"s";$[n=count handles;handles;[hclose each handles;:handles::`u#hopen each 5004+til n]]};
    .z.pc:{handles::`u#handles except x;};
    handles::`u#`int$();
    if[not system"t";system"t 1000"];
    .jobs.jobRun[]
 };

init[];
