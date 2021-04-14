source ~/.bashrc

q script/tick.q sym . -p 5001 -t 1 </dev/null 2>&1 &
q tick/feed.q -p 5002 &
q script/jobsFunc.q -p 5004 &
q script/jobsFunc.q -p 5005 &
q script/jobs.q -config config/jobConfig.csv -schema schema/jobSchema.q -jobsFunc script/jobsFunc.q -tpPort 5001 -p 5003 -t 100 -s -2 &