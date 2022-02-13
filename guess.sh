HIGHER=0
LOWER=1
RIGHT=2
WRONG=3

function compare_number(){
	local first_number=$1
	local second_number=$2	

	if (( second_number > first_number ))
	then
		return $HIGHER
	fi	
	return $LOWER
}


function generate_number_in_range(){
	local range_start=$1
	local range_end=$2

	local guessed_number=$( seq $range_start $range_end | sort -R | head -1 )  
	echo $guessed_number
}


function verify_user_choice(){
	local first_random_number=$1
	local second_random_number=$2
	local user_choice=$3
	
	compare_number $first_random_number $second_random_number
	result_of_comparison=$?
	
	if (( $result_of_comparison == $user_choice ))
	then
		return $RIGHT
	fi
	
	return $WRONG
	
}

function convert_user_choice_to_number(){
	local user_choice=$1
	
	if [[ $user_choice == "HIGH" || $user_choice == "high" ]]
	then
		return $HIGHER
	fi
	
	return $LOWER
}

function convert_correctness_to_message(){
	local value=$1
	local return_value="WRONG"
	
	if (( $value == $RIGHT ))
	then
		return_value="RIGHT"
	fi
	
	echo "$return_value"
}
