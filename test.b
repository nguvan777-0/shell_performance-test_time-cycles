#/bin/bash

get_time_cycles() {
  loops=${1:-10}

  for _ in $(seq $loops)
  do
    \time -al echo "i see you" 2>&1 | grep cycles
  done
}

get_time_cycles
