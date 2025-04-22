#/bin/bash


get_time_cycles() {
  for i in {1..10}
  do
    \time -l echo "i see you" 2>&1 | grep cycles
  done
}

get_time_cycles
