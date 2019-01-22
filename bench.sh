#!/bin/bash

prime(){
	n=$1
	if [[ $n -lt 2 ]]; then return 1; fi
	if [[ $n -eq 3 ]]; then return 0; fi
	if [[ $n -eq 4 ]]; then return 1; fi
	let e=$n-2
	for i in `seq 3 2 $e`; do
		let c=$n%$i
		if [[ c -eq 0 ]]; then return 1; fi
	done
	return 0
}
primes(){
	j=1
	buf=()
	while [[ i -lt $1 ]]; do
		if prime j; then
			let i=$i+1
			echo "Found prime $j"
			buf[i]=$j
		fi
		let j=j+2
	done
	len=${#buf[@]}
	for (( i=0; i<$len; i++ )); do
		echo ${buf[i]}
	done
}
primes 10
