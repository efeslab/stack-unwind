# stack-unwind
Stack unwinding Project repo for EECS 582 Fall 2020 


## Getting Consistent Results

We highly recommend following [this](https://easyperf.net/blog/2019/08/02/Perf-measurement-environment-on-Linux) blog post to help make your testing results more accurate.

## Removing the `.eh_frame` and `.eh_frame_hdr` sections from your binary

```bash
sudo objcopy --remove-section .eh_frame --remove-section .eh_frame_hdr [binary]
```

## YCSB

For benchmarking with YCSB, please check out [ycsb.md](/ycsb.md).


## Specific Program Notes

### Redis

* The `redis-server` binary is the program to run Redis. When measuring executable sizes, this is the binary.
* The `redis-cli` program can be used as a command-line client.
* Compile flags should be changed in `src/Makefile`.

### Memcached

* Use `./configure` to add compile flags
* `echo "flush_all" | nc localhost 11211` should work as your 'clear' command in the YCSB script.

### MongoDB

* `mongo ycsb --eval "db.dropDatabase()"` should drop the YCSB database for use in the YCSB script.
* I just used the `install-mongod` and `install-mongo` targets to get the server and CLI client, respectively; you shouldn't need to build any other targets.

### Clang

* Follow [this guide](https://clang.llvm.org/get_started.html) to build clang properly.

### GCC

* Refer to Tanvir's "[C++ systems and their benchmarks of performance evaluation](https://docs.google.com/document/d/1ZPYYSQDf_syft2VQtuxxrqCUNiB0f13dusvcjo6KAoc/edit?ts=5f53dda7)" on how to build GCC from source.
* Before running `./configure`, modify it to add the compile flags you need.

### RocksDB

* Follow [this guide](https://github.com/facebook/rocksdb/blob/master/INSTALL.md) to compile RocksDB
* Edit the compile flags by editing `./Makefile`, and use the `PREFIX` to mark the installation directory.
* Build only the static library via `make static_lib`, as other `make` commands install other, unnecessary tools.
* To better compare stack-unwinding performance impacts on RocksDB against other NoSQL database applications, we recommend using the YCSB benchmark for RocksDB as opposed to its own benchmarking program.

### FFmpeg

* Download and unzip [vbench](http://arcade.cs.columbia.edu/vbench/). 
* In the top directory, run `export VBENCH_ROOT=$(pwd)`
* Run `./install-reference-ffmpeg.sh` for vbench to download all the repositories necessary to build FFmpeg.
* For each new build of FFmpeg, delete or rename the existing `./bin/ffmpeg`, modify `./ffmpeg_sources/ffmpeg/configure` to add compile flags, and then re-run `./install-reference-ffmpeg.sh`
* To create a benchmark, modify the "perform transcoding" section of `./code/reference.py` to include a for-loop and a filter for whichever video files (found in `./crf0` and `./crf18`) you would like to transcode.
* Then, run the benchmark script with `python code/reference.py scenario` where `scenario` can be any of the following: `live`, `upload`, `platform`, `popular`, or `vod`