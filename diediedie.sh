#!/bin/zsh

#Author: Jeffrey DeYoung
#Last updated: 4 Oct 2016
#Safe version of pkill, but with -9
#For when you just want to kill a process; likely to be used in anger
# (Note for the internet: I am not an angry person; name was suggested by coworker)
#To use, add to your shells .zshrc or .bashrc file:
#  alias diediedie="~/path/to/diediedie.sh"


usage="$(basename "$0") [-h] [process-to-kill] -- program to (safely) kill processes with no doubt that they will die.

where:
    -h  show this help text
    process-to-kill  Process Name (or partial name) that you wish to consider killing; you will be prompted to confirm the name prior to execution."

if [ "$1" = "-h" ] || [ $# -eq 0 ]; then
  printf "Usage: $usage"
  exit 0
fi

to_kill=$*
echo "You are trying to kill: '$to_kill'"
this_pid=$$
#echo $this_pid
#ugly
processes=`ps -ef | grep "$to_kill" | grep -v "grep" | grep -v "diediedie" | grep -v "$this_pid"`
#echo $processes
process_count=`echo $processes | wc -l`
if [ $process_count -eq 1 ]; then
	echo "There is no process by that name."
	exit 1
fi

pids=()
#pNames=()
counter=1;
while read -r line ; do
	echo "$counter.) $line"
	((counter++))
	pid=`echo $line | awk '{print $2}'`
	pids+=($pid)
	#pName=`echo $line | awk '{print $8}'`
	#pNames+=($pName)	
	printf "\n"
done <<<$processes
#echo $pids
echo "Which process do you wish to kill? (1-$process_count) (ctrl + c to cancel)"
read index
echo "Killing process id: " $pids[$index]
kill -9 $pids[$index]
echo "Killed."
