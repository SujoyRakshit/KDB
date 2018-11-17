/To use to create bucket times as xbar runs from floor value
/ eg. select sum size by timeBkt timeBkt bin time from tabName
/ 10 Bucket will be used as 0D00:00:10
/ 1D11:01:03 will be used as 1D11:01:03
/ timeBkt[10;.z.p-0D01:00:00;.z.p]

timeBkt:{[bkt;fstTime;lstTime] bkt:$[(abs type bkt) within 16 19;"n"$bkt;(abs type bkt) within 6 7;"n"$"v"$bkt;:"Bucket not supported"]; {x+y}[;bkt]\ [{x<y}[;lstTime];fstTime]};
