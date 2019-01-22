#!/bin/bash

benches=10

results_dir="results"
name="last"
if [ $# -gt 0 ]; then name=$1; fi

benchmark() {
	amount=2500
	if [ $# -gt 0 ]; then amount=$1; fi
	for i in $(seq 1 $benches); do
		echo "On trial $i"
		j="$results_dir/bench.$amount.$name.$i"
		./run_all.sh $amount > "$j"
		echo "Trial $i success with"
		cat $j
	done
}

benchmark 2500
benchmark 10000
