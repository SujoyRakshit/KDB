/Functions

/Temporary Table to run jobs
`t set ([] sym:10?`2; bid:10?90.9; ask:10?89.9; loc:10?`HKH`LOH`NYK);

\d .jobs
/Get completion status of the jobs
getJobStatus:{[job]
 select from get`jobStats where jobId=job
 };

/Get Configuration of the job
getJobConfig:{[job]
 select from get`jobsConfig where jobId=job
 };

/Uses the config file table jobsFromConfig, to set scheduler
jobScheduler:{
  dts:value x`jobDays;
  {
  if[y>=.z.d mod 7;
    `jobsConfig insert (x`jobId;x`jobQuery;x`jobDescription;x`jobParams;x`jobTime;y;x`active);
  ]}[x;] each dts;
  };

/Triggers the jobs from configuration passed
jobRunner_:{[job]
    st:.z.p;
    res:.Q.trp[value;(job[`jobQuery],job[`jobParams]);{2@"error: ",x,"\nbacktrace:\n",.Q.sbt y;-1}];
    jobStatus:?[-1~res;0b;1b];
    :([] rundate:.z.d;jobDays:job[`jobDays];jobTime:job[`jobTime];startTime:st;endTime:.z.p;jobId:job[`jobId];jobStatus:jobStatus;result:enlist res)
 }

/Runs on the main process, and stores results
jobRunner:{
    if[0<count x;
        res:raze jobRunner_':[x];
        `jobResult set z,select jobId,jobTime,result from res;
        `jobStats set y,delete result from res
        ]
    };

jobRunData:{[jc;js] select from jc where jobTime<.z.t,active=1b,(.z.d mod 7)=jobDays,not ([] jobId;jobDays;jobTime) in select jobId,jobDays,jobTime from js};

/We can give multiple processes, using -s -n
/ Runs the job and returns the result to the main process
/ which will maintain the results and scheduling
jobRun:{jobRunner[jobRunData[get`jobsConfig;get`jobStats];get`jobStats;get`jobResult]};

\d .

/ Ticker plant can send the data to this service
/ Jobs sent will be checked with configuration present.
/ If missing the job will not be scheduled.

upd:{
        x insert y;
        .jobs.jobScheduler'[.jobs.jobsFromConfig ij 1!update string jobDays from select jobId:sym,jobTime,jobDays:.z.d mod 7 from get`jobs]
 };
