#/bin/bash

LOOPS=${1:-100}
STRING=${2:-777}

get_time_cycles() {
  command=${1:-echo}
  loops=$LOOPS
  string=$STRING

  for _ in $(seq $loops)
  do
                                                #d echo $_
                                                #d echo "\time -al $command "$string" 2>&1"

    \time -al $command "$string" 2>&1 #| grep cycles
  done
}

get_time_cycles printf

