# shell_performance-test_time-cycles

check test.b

then run

bash test.b

```
./test.b 10 somestringtoprint echo printf pass echo true printf pass echo
##############################
We will start a performance test for these
commands in order

echo printf pass echo true printf pass echo

For each command
time its printing of "somestringtoprint"
for 10 loops
then report sum of exit codes and sum of cycles
##############################

COMMAND LOOPS SUM_EXIT_CODES SUM_CYCLES
echo 10 0 35625802
printf 10 0 39729663
pass 10 1270 14545003
echo 10 0 35214401
true 10 0 33562351
printf 10 0 39530204
pass 10 1270 14627849
echo 10 0 34749723
```
