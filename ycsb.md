# Benchmarking a program many times using YCSB

## Modifying and running `ycsbHarness.sh`

Check out the comments in the script for more details on modifying this script. In short, though, you must comment out the top few lines, replace the variables on lines 18 and 19 with the accurate values for the program you are benchmarking, and then invoke the script with the number of runs that you would like the script to do.

## Collecting memory usage information of the program

This script pauses after running all 6 workloads once for you to collect memory usage information for that run of the benchmark, if you're collecting that information. If you are not collecting memory usage information of the program, you can simply hit any key to continue benchmarking.

You can use [`run_memory_usage.sh`](https://github.com/efeslab/huron/blob/master/run_memory_usage.sh) from [`efeslab/huron`](https://github.com/efeslab/huron). Invoke 
whatever server program you're benchmarking with the script first:

```bash
$ ./run_memory_usage.sh ./redis-server
```

Then, in order to not terminate the script but the program itself, you can kill the program using the `kill` command:

```bash
$ ps -af # this command will let you find the PID for the program
$ kill [PID] # kill the process running with that PID
```

The script will output the memory usage data, which you should record somewhere. Then, restart the program and continue the script.

## Extracting runtimes into the clipboard to paste into spreadsheets

After running the YCSB benchmark how ever many times you choose, you will see that the output of each YCSB workload is spit into subfolders for each run of all 6 workloads. Within each folder will be 8 text files for each run of the benchmark, in the order they happened.

If you're inside one of these folders, you can extract just the raw run time of all of them onto your clipboard (they will be in the order of the files, each on newlines):

```bash
$ head -n 1 * | grep -oE '[0-9]{2,}' | clip.exe ## Windows WSL
$ head -n 1 * | grep -oE '[0-9]{2,}' | pbcopy ## OSX
$ head -n 1 * | grep -oE '[0-9]{2,}' | xclip ## Linux, to your X clipboard
```

If you have a spreadsheet, with the following rows:
| Workload      | Run 1 |
| -----------   | ----------- |
| Load A        |        |
| Run A         |        |
| Run B         |        |
| Run C         |        |
| Run F         |        |
| Run D         |        |
| Load E        |        |
| Run E         |        |

you should be able to highlight the "Load A" row in the column you'd like to paste in, and use Ctrl/CMD + V to paste all of the values into the spreadsheet.