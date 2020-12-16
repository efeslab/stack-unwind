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
