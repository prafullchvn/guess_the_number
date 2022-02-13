source guess.sh

function main(){
		local first_number=$( generate_number_in_range 1 100 )
		local second_number=$( generate_number_in_range 1 100 )
		
		echo "The first number is ${first_number}"
		read -p "Guess HIGH or LOW ?  " user_choice
		
		convert_user_choice_to_number "$user_choice" 
		user_choice_num=$?
		
		verify_user_choice  $first_number $second_number $user_choice_num
		is_correct=$?
		is_correct_message=$(convert_correctness_to_message $is_correct )
		
		echo "You have guessed ${is_correct_message}. "
		echo -ne "The second number was ${second_number}\n"
}	

main
