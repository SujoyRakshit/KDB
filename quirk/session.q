session:([] id:1 2 1 2 2 3; sid:1 1 2 2 3 1; st:`time$01:00 01:00 01:30 01:45 01:30 02:00; et:`time$02:00 02:00 02:00 02:00 03:00 03:00);

// Update unique start times and end time 
getTimes:{
  a:(`startTime`endTime)!((?;(null;`startTime);(min;`st);`startTime);(?;(null;`endTime);(max;`et);`endTime));
  b:{x!x} enlist `id; 
  c:enlist (&;(>=;`st;y`st);(<=;`et;y`et));
  ![x;c;b;a]
 };

genUniqTime:{
  data:?[x;enlist (=;`id;y);0b;()];
  if[1=count data;:select id,startTime:st,endTime:et from data];
  ?[;();0b;{x!x} `id`startTime`endTime] ?[;();{x!x} `id`startTime`endTime;()] getTimes/ [update startTime:0Nt,endTime:0Nt from data;data]
 };

getSessionTime:{
  data:raze genUniqTime[x] peach distinct x`id;
  select timeTaken:sum endTime-startTime by id from data
 };

/
getSessionTime session
id| timeTaken   
--| ------------
1 | 01:00:00.000
2 | 02:30:00.000
3 | 01:00:00.000
q)insert[`session;(4;1;02:15:45.000;02:18:00.000)]
q)insert[`session;(2;4;02:15:45.000;02:18:00.000)]
getSessionTime session
