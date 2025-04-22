#!/bin/bash

LOOPS=${1:-12}
TEXT=${2:-777}
shift 2
COMMANDS_TO_TEST=${*:-pass echo printf true false}

run_perf() {
  command=${1:-pass}
  loops=$LOOPS
  text=$TEXT

  for _ in $(seq $loops)
  do
    timeit=$(\time -al $command "$text" 2>&1)
    echo -n $?,
    echo "$timeit" | grep -m1 cycles | awk '{print $1}'
  done

  return $?
}

sum_perf_results() {
  perf_results=${1:-1,0}
  exit_code_mathexpn=0
  cycles_mathexpn=0

  for result in $perf_results
  do
    exit_code_mathexpn=$exit_code_mathexpn+${result/,*/}
    cycles_mathexpn=$cycles_mathexpn+${result/*,/}
  done

  echo -n $((exit_code_mathexpn))" "
  echo $((cycles_mathexpn))

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
We will start a performance test for these
commands in order

$COMMANDS_TO_TEST

For each command
time its printing of \"$TEXT\"
for $LOOPS loops
then report sum of exit codes and sum of cycles
##############################"
echo "$test_intro"
echoecho 1

main() {
  echo COMMAND LOOPS SUM_EXIT_CODES SUM_CYCLES
  for command in $COMMANDS_TO_TEST
  do
    _cycles=$(run_perf $command)
    echo -n "$command $LOOPS "
    sum_perf_results "$_cycles"
  done
}
main
