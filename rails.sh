#!/usr/bin/env bash

function alloc_dump {
    PID=$1
    rbtrace -p $PID -e 'Thread.new{GC.start;require "objspace";io=File.open("/tmp/ruby-heap.dump", "w"); ObjectSpace.dump_all(output: io); io.close}'
}

function alloc_start {
    PID=$1
    rbtrace -p $PID -e 'Thread.new{GC.start;require "objspace";ObjectSpace.trace_allocations_start}'
}

function puma_restart {
    PID=$1
    sudo kill -USR2 $PID
}

function puma_pid {
    ps ax|grep  puma| head -1| awk '{ print $1 }'
}

function puma_reduce {
    PID=$1
    sudo kill -TTOU $PID
}

function puma_worker_pid {
    ps ax|grep  puma| grep 'cluster worker' | head -1| awk '{ print $1 }'
}

function rbtools_install {
    sudo gem install rbtrace heapy
}

function rbtrace {
    sudo /usr/local/rvm/gems/ruby-2.?.?/wrappers/rbtrace "$@"
}

function heapy {
    sudo /usr/local/rvm/gems/ruby-2.?.?/wrappers/heapy "$@"
}
