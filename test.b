#/bin/bash

# this is a comment
#this is a comment

LOOPS=${1:-100}
TEXT=${2:-777}

get_time_cycles() {
  command=${1:-echo}
  loops=$LOOPS
  text=$TEXT

  cycles_text_table=$(

    for _ in $(seq $loops)
    do
      \time -al $command "$text" 2>&1 \
        | grep cycles \
        | awk '{print $1}'
    done

  )

  echo $cycles_text_table
  return $?
}

add_up_cycles() {
  cycles_text=${1:-""}

  echo ${myarray[@]} | xargs  -n1 -I{} echo -n {}+ ;echo 0



}

get_time_cycles printf

