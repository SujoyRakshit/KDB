# Name
JOBS - Scheduling Tool

# Description
Auto scheduling tool, based on jobsConfig.
This module is designed to work on Unix OS. 

# File Structure
Files expected to be in below structure:
jobs/
    config/
        jobConfig.csv
    scripts/
        tick.q
        jobsFunc.q
        jobs.q
    tick/
        u.q
        feed.q
        sym.q (jobs table used in tick schema)
    schema/
        jobsSchema.q

# Q Scripts

  1. Standard tick.q is used to get data from feed.q into the Table jobs. 
     q script/tick.q sym . -p 5001 -t 1
      
  2. Execute the function genData[n]. Where n is the number of records you want to generate
     The data is divided into chunks and sent to TP
     q tick/feed.q -p 5002
    
  3. Start Slave processes, Currently marked to 2, can be scaled further
     q script/jobsFunc.q -p 5004
  
  4. q script/jobsFunc.q -p 5005

  Please see the attached file jobsFunc.q for details on each function

  5. q script/jobs.q -config config/jobConfig.csv 
   - schema schema/jobSchema.q -jobsFunc script/jobsFunc.q -tpPort 5001 -p 5003 -t 100 -s -2
   - config -> Defines the config file, which defines the functions, schedule, query, runTime.
   - schema -> Loads the schema file for jobStats, jobsConfig

# TABLES:
  jobStats -> Shows completed jobs, which there Success(1) or Failed(0) status
  jobsConfig -> Stores each and every configuration for jobs
  jobsResult -> Stores result for each configuration ran
  jobsFunc -> Loads the functions file used to process various jobs
   - tpPort -> Port on which TP is running.
   - t -> Timer set to 100ms
   - s -> Slaves used as multi-processes

# Shell  Script
  start.sh -> Loads bash profile and triggers the jobs in sequence.


# API

  q)h:hopen`::5003
  
  q)h".jobs.getJobConfig[`computeSum]"
  | jobId      |  jobQuery                                    | jobDescription                  | jobParams | jobTime     | jobDays | active |
  | ---------- | -------------------------------------------- | -------------------------------- | --------- | -------------- | ---------- | -------- |
  | getHKData  |  "?[`t;enlist (=;`loc;enlist `HKH);0b;();10]" | "Gets Hong Kong Data"           |  ""      |  01:00:00.000 | 4      | 1     |
  | getHKData  |  "?[`t;enlist (=;`loc;enlist `HKH);0b;();10]" | "Gets Hong Kong Data"           | ""       | 01:00:00.000  | 5       | 1     |
  | getHKData  |  "?[`t;enlist (=;`loc;enlist `HKH);0b;();10]" | "Gets Hong Kong Data"           | ""       | 01:00:00.000  | 6       | 1     |
  | computeSum |  "sum"                                        | "Calculates sum of 2 parameters" | "(3;4)" |  02:00:00.000 | 4      | 1     |
  | computeSum |  "sum"                                        | "Calculates sum of 2 parameters" | "(3;4)" |  02:00:00.000 | 5      | 1     |
  | computeSum |  "sum"                                        | "Calculates sum of 2 parameters" | "(3;4)" |  02:00:00.000 | 6      | 1     |
  | getTradeData | "?[`t;();0b;()]"                            | "Gets Trade Data"                | ""      |  08:00:00.000 | 6    |   1 |

  q)h"get`jobStats"
  | rundate  |  jobDays | jobTime   |   startTime      |               endTime      |           jobId   |   jobStatus |
  | -------- | --------- | --------- | ------------------ | ----------------------- | ----------------- | -----|
  | 2021.04.14 | 4   | 01:00:00.000 | 2021.04.14D06:55:33.755244000 | 2021.04.14D06:55:33.755326000 | getHKData | 1  |      
  | 2021.04.14 | 4   | 02:00:00.000 | 2021.04.14D06:55:33.755257000 | 2021.04.14D06:55:33.755271000 | computeSum | 1 |       
  
  q)h"get`jobResult"
  | jobId      | jobTime      | result |                                                                                         
  | ---------- | ------------ | --------------------------------------------------------------------------------------------- |
  | getHKData  | 01:00:00.000 | +`sym`bid`ask`loc!(`in`nm`ce;57.69165 87.9221 35.59126;52.00897 7.541584 42.32386;`HKH`HKH`HKH) |
  | computeSum | 02:00:00.000 | 7 |                                                               


# NYI
Monitoring
The main process (jobs.q) should send the status for jobs to a monitoring TP, which can be useful by Ops to identify job statuses.
