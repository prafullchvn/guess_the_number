source guess.sh

function verify_test_result(){
	local expected=$1
	local actual=$2
	local inputs=$3
	
	local test_result="FAIL"
	if (( $actual == $expected ))
	then
		test_result="PASS"
	fi
	
	echo "${test_result} - ${inputs} Actual: ${actual} Expected: ${expected}"
}

function test_compare_number(){
	local first_number=$1
	local second_number=$2
	local expected_result=$3

	compare_number $first_number $second_number
	local actual_result=$?
	
	local inputs="first number: ${first_number} second number: ${second_number}"
	verify_test_result $expected_result $actual_result "$inputs"	
}

function test_generate_number_in_range(){
	local range_start=$1
	local range_end=$2
	
	guessed_number=$(generate_number_in_range $range_start $range_end )
	
	local test_result="FAIL"
	if (( $guessed_number >= $range_start && $guessed_number <= $range_end ))
	then
		test_result="PASS"
	fi
	
	local range="Range Start: ${range_start}, Range End: ${range_end}"
	echo "${test_result} - ${range} Guessed Number: ${guessed_number}"
	
}


function test_verify_user_choice(){
	local first_random_number=$1
	local second_random_number=$2
	local user_choice=$3
	local expected_correctness=$4
	
	verify_user_choice $first_random_number $second_random_number $user_choice
	local actual_correctness=$?
	
	local numbers_generated="First Number: $first_random_number Second Number: $second_random_number"
	local inputs="${numbers_generated}, User Choice: $user_choice"
	
	verify_test_result $expected_correctness $actual_correctness "$inputs"
}

function test_convert_user_choice_to_number(){
	local user_choice=$1
	local expected_value=$2
	
	convert_user_choice_to_number "$user_choice"
	result=$?
	
	local inputs="User Choice: $user_choice "
	verify_test_result 	$expected_value $result "$inputs"
}

function test_convert_correctness_to_message(){
	local value=$1
	local expected_message=$2
	
	actual_message=$( convert_correctness_to_message $value )
	
	local inputs="Value is $value"
	verify_test_result "$expected_message" "$actual_message" "$inputs"
}

function compare_number_test_cases(){
	echo "Testing compare number:-"
	echo -e "\nWhen first number is higher than second number"
	test_compare_number 6 3 $LOWER
	echo -e "\nWhen first number is lower than second number"
	test_compare_number 4 5 $HIGHER

}

function generate_number_test_cases(){
	echo -e "\n\nTesting generate_number_in_range:- "
	echo -e "\nGuessing a random number in range"
	test_generate_number_in_range 1 100	
	echo -e "\nGuessing a random number in when start and end of range are same"
	test_generate_number_in_range 4 4
}

function verify_user_choice_test_cases(){
	echo -e "\n\nTesting verify_user_guess:- "
	echo -e "\nWhen user guessed correctly"
	test_verify_user_choice 45 30 $LOWER $RIGHT	
	echo -e "\nWhen user guessed incorrectly"
	test_verify_user_choice 59 30 $HIGHER $WRONG
}

function convert_user_choice_to_number_test_cases(){
	echo -e "\n\nTesting convert_user_choice_to number:- "
	echo -e "\nWhen user choice is \"HIGH\""
	test_convert_user_choice_to_number "HIGH" $HIGHER
	echo -e "\nWhen user choice is \"high\""
	test_convert_user_choice_to_number "high" $HIGHER
	echo -e "\nWhen user choice is \"LOW\""
	test_convert_user_choice_to_number "LOW" $LOWER
	echo -e "\nWhen user choice is \"low\""
	test_convert_user_choice_to_number "low" $LOWER
}

function convert_correctness_to_text_test_cases(){
	echo -e "\n\nTesting convert_correctness_to_text:- "
	echo -e "\nWhen value is \$RIGHT"
	test_convert_correctness_to_message $RIGHT "RIGHT"	
	echo -e "\nWhen value is \$WRONG"
	test_convert_correctness_to_message $WRONG "WRONG"
}



function run_test_cases(){
	compare_number_test_cases
	generate_number_test_cases	
	verify_user_choice_test_cases	
	convert_user_choice_to_number_test_cases
	convert_correctness_to_text_test_cases	
}


function print_status(){
	
	local test_result=`run_test_cases`
	local no_of_pass_cases=`echo "$test_result" | grep -ci "^pass" `
	local no_of_fail_cases=`echo "$test_result" | grep -ci "^fail" `

	echo -e  "Total no of pass test cases is ${no_of_pass_cases} \nTotal no of fail test cases is ${no_of_fail_cases}"
}

run_test_cases
echo -e "\n#############\n"
print_status

