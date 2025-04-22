#/bin/bash

LOOPS=${1:-12}
TEXT=${2:-777}
COMPARE_APPS="pass echo printf"

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

  add_math="$(
  echo $cycles_text | \
    xargs -n1 -I{} echo -n {}+ \
    && echo 0
  )"

  echo $((add_math))
  return $?
}

echoecho() {
  echos=${1:-2}

  for _ in $(seq $echos)
  do
    echo
  done
}

test_intro="##############################
we will start a performance test
comparing these stdout builtins

$COMPARE_APPS

with these options
$LOOPS loops
\"$TEXT\" text to be printed
##############################"
echo "$test_intro"
echoecho 1

echo COMMAND LOOPS SUM_CYCLES
for command in $COMPARE_APPS
do
  _cycles=$(get_time_cycles $command)
  echo -n "$command $LOOPS "
  add_up_cycles "$_cycles"
done

