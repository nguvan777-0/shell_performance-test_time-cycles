#/bin/bash

# this is a comment
#this is a comment

LOOPS=${1:-12}
TEXT=${2:-777}
COMPARE_APPS="echo printf"

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
  #d echo $cycles_text

  math="$(
  echo $cycles_text | \
    xargs -n1 -I{} echo -n {}+ \
    && echo 0
  )"
  echo $((math))
}

echo;echo;echo
test_intro="we will start a performance test comparing
these commands

[$COMPARE_APPS]"
echo "$test_intro"
echo;echo;echo

echo COMMAND LOOPS SUM_CYCLES
for command in $COMPARE_APPS
do
  _cycles=$(get_time_cycles $command)
  echo -n "$command $LOOPS "
  add_up_cycles "$_cycles"
done

