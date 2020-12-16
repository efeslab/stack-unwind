# Made by Eashwar Mohan (eashwar@umich.edu), 2020
# COMMENT OUT THE NEXT TWO LINES ONCE YOU HAVE MADE THE CORRECT MODIFICATIONS
echo "You must modify this script before using it. Look in the comments."
exit 1
## Welcome to the YCSB benchmark helper script.
## In order to use this program, you need two things:
## 1. Some command to clear the data from the program you're using.
##    Most database programs will also ship with a CLI client which 
##    you can use in this case.
## 2. From the YCSB repository's docs, the program name + configuration
##    for the datastore that you're using, with the quotes removed.
##    for example: 'redis -p redis.host=127.0.0.1 -p redis.port=6379'
##    is the application name + configuration that YCSB needs for Redis.
## Finally, make sure you run this script with the data program running,
## either in the background or in another terminal window.
## Then, you can invoke the script with the number of runs you would like 
## the program to complete.
CLEARDATA='../redis/src/redis-cli flushall'
YCSBCONFIG='redis -p redis.host=127.0.0.1 -p redis.port=6379'
for i in $(seq $1)
do
    mkdir ycsbBenchmarkRun$i
    echo "clear datastore"
    eval $CLEARDATA
    echo "load a"
    ./bin/ycsb load $YCSBCONFIG \
               -s -P workloads/workloada > ycsbBenchmarkRun$i/0_loadA.txt
    echo "run a"
    ./bin/ycsb run $YCSBCONFIG \
               -s -P workloads/workloada  > ycsbBenchmarkRun$i/1_runA.txt	
    echo "run b"
    ./bin/ycsb run $YCSBCONFIG \
               -s -P workloads/workloadb  > ycsbBenchmarkRun$i/2_runB.txt	
    echo "run c"
    ./bin/ycsb run $YCSBCONFIG \
               -s -P workloads/workloadc  > ycsbBenchmarkRun$i/3_runC.txt	
    echo "run f"
    ./bin/ycsb run $YCSBCONFIG \
               -s -P workloads/workloadf  > ycsbBenchmarkRun$i/4_runF.txt	
    echo "run d"
    ./bin/ycsb run $YCSBCONFIG \
               -s -P workloads/workloadd  > ycsbBenchmarkRun$i/5_runD.txt
    echo "clear datastore"
    eval $CLEARDATA
    echo "load e"
    ./bin/ycsb load $YCSBCONFIG \
               -s -P workloads/workloade  > ycsbBenchmarkRun$i/6_loadE.txt
    echo "run e"
    ./bin/ycsb run $YCSBCONFIG \
               -s -P workloads/workloade  > ycsbBenchmarkRun$i/7_runE.txt	
    read -n 1 -s -r -p "If you need to restart the database program to collect memory usage information, do so now and restart the program. Then, press any key to continue."
done