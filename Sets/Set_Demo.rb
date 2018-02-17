# Name: Brandon Siebert
# Course: CSC 415
# Semester: Fall 2017
# Instructor: Dr. Pulimood
# Project name: Assignment 1
# Description: Design a Set class which holds operates on a set of Subscriber objects.
# Filename: Set_Demo.rb
# Description: Houses the Set and Subscriber classes used for Assignment 1
# Last modified on: 9/27/2018

require_relative "Set_Subscriber.rb"

# String Constants
$welcome_message = "Welcome to the Set_Subscriber.rb demo. You will be presented with a set of \ncommands used to run and test all functionality of this module. \nPlease ensure your dataset files are properly formatted: \n<account_number> <whitespace> <name>\n<account_number> <whitespace> <name> ..."
$option0 = "[1]: Create a new empty Set"
$option1 = "[2]: Load dataset from file."
$option2 = "[3]: Print loaded dataset."
$option3 = "[4]: Add a new Subscriber to a dataset."
$option4 = "[5]: Find the union between two datasets."
$option5 = "[6]: Find the intersection between two datasets."
$option6 = "[7]: Find the Cartesian Product between two datasets."
$option7 = "[8][Q][q]: Quit"
# String Constants End

$loaded_datasets = Array.new(0)

def print_datasets
	index = 1
	puts '-List of loaded datasets-'
	$loaded_datasets.each do |set, name|
	puts '[' + index.to_s + ']: ' + name + ' (' + set.count.to_s + ' items)'
	index += 1
	end
	puts ''
	puts '-------------------------'
end

def run_demo
	puts $welcome_message
	while true
		puts ' '
		puts '/`--------------------- Main Menu ---------------------`\\'
		puts '| ' + $option0 + '					|'
		puts '| ' + $option1 + '				|' 
		puts '| ' + $option2 + '				|'
		puts '| ' + $option3 + '		|'
		puts '| ' + $option4 + '		|' 
		puts '| ' + $option5 + '	|'
		puts '| ' + $option6 + '	|'
		puts '| ' + $option7 + '					|'
		puts '|,-----------------------------------------------------,|'
		puts '\\.-----------------------------------------------------./'
		puts ' '
		print 'Please choose which command to execute: '
		menu_choice = gets.chomp
		puts ''
		case 

		# Menu choice for creating a new empty dataset
		when menu_choice == "1" || menu_choice == "[1]"
			puts 'Executing ' + $option0
			$loaded_datasets.push([Set.new, "NewSet"])
			puts 'Created a new Set!'

		# Menu choice for loading datasets from files
		when menu_choice == "2" || menu_choice == "[2]"
			puts 'Executing ' + $option1
			while true
				print '[1] Please enter a relative file url to load from (Enter [Q] or [q] to return to the Main Menu): '
				filename = gets.chomp
				case 
				when filename == "Q" || filename == "[Q]" || filename == "q" || filename == "[q]"
					puts 'Returning to the Main Menu'
					break
				else
					if (!filename.nil?)
						begin
							$loaded_datasets.push([Set.new(filename), filename])
							puts 'File ' + filename + ' has successfully been loaded!'
							break
						rescue
							puts 'Unable to load file. Make sure your path is relative to this script\'s directory.'
						end
					else
						puts 'Invalid filename! Try again.'
					end
				end
			end

		# Menu choice for printing datasets
		when menu_choice == "3" || menu_choice == "[3]"
			puts 'Executing ' + $option2
			if $loaded_datasets.count == 0
				puts '<No Datasets Loaded>'
				puts 'Returning to the Main Menu'
				next
			else
				print_datasets
			end
			while true
				print 'Select the number of a loaded dataset to print (Enter [Q] or [q] to return to the Main Menu): '
				menu_choice = gets.chomp
				case 
				when menu_choice == "Q" || menu_choice == "[Q]" || menu_choice == "q" || menu_choice == "[q]"
					puts 'Returning...'
					break
				else
					index_choice = menu_choice.to_i
					if (index_choice != 0)
						case
						when index_choice <= $loaded_datasets.count && index_choice >= 1
							printing_set = $loaded_datasets[index_choice - 1]
							puts "Printing Set: " + printing_set[1] + "\n"
							puts printing_set[0].to_s
							puts ''
							break
						else
							puts 'Invalid dataset number!'
						end
					else
						puts 'Invalid input!'
					end
				end
			end
			puts 'Returning to the Main Menu'

		# Menu choice for adding a new subscriber
		when menu_choice == "4" || menu_choice == "[4]"
			puts 'Executing ' + $option3
			# Choose Dataset
			# Enter Account Number
			# Enter Name
			# Print Success or Failure
			valid_set = false
			valid_account_number = false
			valid_name = false
			print_datasets
			while true
				print 'Select a dataset number to add a Subscriber to (Enter [Q] or [q] to return to the Main Menu): '
				menu_choice = gets.chomp
				puts ''
				case
				when menu_choice == "Q" || menu_choice == "[Q]" || menu_choice == "q" || menu_choice == "[q]"
					break
				else
					index_choice = menu_choice.to_i
					if (index_choice != 0)
						case
						when index_choice <= $loaded_datasets.count && index_choice >= 1
							set1 = $loaded_datasets[index_choice - 1]
							valid_set = true
							break
						else
							puts 'Invalid dataset number! Please enter a dataset number'
						end
					else
						puts 'Invalid input! Please enter a dataset number.'
					end
				end
			end
			if valid_set
				while true
					print 'Please enter an account number. Cannot be "0" (Enter [Q] or [q] to  return to the Main Menu): '
					new_account_number = gets.chomp
					puts ''
	                       	 	case
	                       	 	when new_account_number == "Q" || new_account_number == "[Q]" || new_account_number == "q" || new_account_number == "[q]"
	                                	break
		                        else
						if new_account_number.nil? || new_account_number.empty? || new_account_number.to_i == 0
							puts 'Invalid account number. Please try again.'
						else
							valid_account_number = true
							break
						end
		                        end
				end
			end
			if valid_set && valid_account_number
	                        while true
					print 'Please enter an account name (Enter [Q] or [q] to return to the Main Menu): '
	                        	new_name = gets.chomp
	                        	puts ''
	                                case
	                                when new_name == "Q" || new_name == "[Q]" || new_name == "q" || new_name == "[q]"
	                                        break
	                                else
	                                        if new_name.nil? || new_name.empty?
	                                                puts 'Invalid name. Please try again.'
	                                        else
	                                                valid_name = true
	                                                break
	                                        end
	                                end
	                        end
	
			end
			if valid_set && valid_account_number && valid_name
				add_element_return_code = set1[0].add_element(Subscriber.new(new_account_number.to_i, new_name))
				if add_element_return_code
					puts 'Subscriber has been added to ' + set1[1] + '!'
				else
					puts 'Duplicate detected! The Subscriber was not added!'
				end
			end
			puts 'Returning to the Main Menu'
		
		# Menu choice for union
		when menu_choice == "5" || menu_choice == "[5]"
			puts 'Executing ' + $option5
			# Choose Dataset 1
			# Choose Dataset 2
			# Execute Union
			# Ask to Store
			valid_set1 = false
			valid_set2 = false
			print_datasets
			while true
				print '1. Select a dataset number for the first set (Enter [Q] or [q] to return to the Main Menu): '
				menu_choice = gets.chomp
				puts ''
				case
				when menu_choice == "Q" || menu_choice == "[Q]" || menu_choice == "q" || menu_choice == "[q]"
					break
				else
					index_choice = menu_choice.to_i
					if (index_choice != 0)
						case
						when index_choice <= $loaded_datasets.count && index_choice >= 1
							set1 = $loaded_datasets[index_choice - 1]
							valid_set1 = true
							break
						else
							puts 'Invalid dataset number! Please enter a dataset number'
						end
					else
						puts 'Invalid input! Please enter a dataset number.'
					end
				end
			end
			if valid_set1
				while true
					print '2. Select a dataset number to add a Subscriber to (Enter [Q] or [q] to return to the Main Menu): '
					menu_choice = gets.chomp
					puts ''
					case
					when menu_choice == "Q" || menu_choice == "[Q]" || menu_choice == "q" || menu_choice == "[q]"
						break
					else
						index_choice = menu_choice.to_i
						if (index_choice != 0)
							case
								when index_choice <= $loaded_datasets.count && index_choice >= 1
									set2 = $loaded_datasets[index_choice - 1]
								valid_set2 = true
								break
							else
								puts 'Invalid dataset number! Please enter a dataset number'
							end
						else
							puts 'Invalid input! Please enter a dataset number.'
						end
					end
				end
			end
			if valid_set1 && valid_set2
				result_set = Set.union(set1[0], set2[0])
				if result_set.nil?
					puts 'Error. One or more of the Sets were invalid.'
					next
				end
				puts 'The result of the operation has ' + result_set.count.to_s + ' items.'
				print 'Would you like to print these to the screen? (yes/no): '
				is_printing = gets.chomp
				puts ''
				case
				when is_printing == "yes" || is_printing == "y"
					puts result_set.to_s
				end
				puts ''
				print 'Would you like to save this result into the loaded dataset? (yes/no): '
				is_saving = gets.chomp
				puts ''
				case
				when is_saving == "yes" || is_saving == "y"
					$loaded_datasets.push([result_set, "UnionResult"])
					puts 'Result Saved!'
				end
			end
			puts 'Returning to the Main Menu'

		# Menu choice for intersect
		when menu_choice == "6" || menu_choice == "[6]"
			puts 'Executing ' + $option6
			# Choose Dataset 1
			# Choose Dataset 2
			# Execute Intersect
			# Ask to Store
			valid_set1 = false
			valid_set2 = false
			print_datasets
			while true
				print '1. Select a dataset number for the first set (Enter [Q] or [q] to return to the Main Menu): '
				menu_choice = gets.chomp
				puts ''
				case
				when menu_choice == "Q" || menu_choice == "[Q]" || menu_choice == "q" || menu_choice == "[q]"
					break
				else
					index_choice = menu_choice.to_i
					if (index_choice != 0)
						case
						when index_choice <= $loaded_datasets.count && index_choice >= 1
							set1 = $loaded_datasets[index_choice - 1]
							valid_set1 = true
							break
						else
							puts 'Invalid dataset number! Please enter a dataset number'
						end
					else
						puts 'Invalid input! Please enter a dataset number.'
					end
				end
			end
			if valid_set1
				while true
					print '2. Select a dataset number to add a Subscriber to (Enter [Q] or [q] to return to the Main Menu): '
					menu_choice = gets.chomp
					puts ''
					case
					when menu_choice == "Q" || menu_choice == "[Q]" || menu_choice == "q" || menu_choice == "[q]"
						break
					else
						index_choice = menu_choice.to_i
						if (index_choice != 0)
							case
								when index_choice <= $loaded_datasets.count && index_choice >= 1
									set2 = $loaded_datasets[index_choice - 1]
								valid_set2 = true
								break
							else
								puts 'Invalid dataset number! Please enter a dataset number'
							end
						else
							puts 'Invalid input! Please enter a dataset number.'
						end
					end
				end
			end
			if valid_set1 && valid_set2
				result_set = Set.intersect(set1[0], set2[0])
				if result_set.nil?
					puts 'Error. One or more of the Sets were invalid.'
					next
				end
				puts 'The result of the operation has ' + result_set.count.to_s + ' items.'
				print 'Would you like to print these to the screen? (yes/no): '
				is_printing = gets.chomp
				puts ''
				case
				when is_printing == "yes" || is_printing == "y"
					puts result_set.to_s
				end
				puts ''
				print 'Would you like to save this result into the loaded dataset? (yes/no): '
				is_saving = gets.chomp
				puts ''
				case
				when is_saving == "yes" || is_saving == "y"
					$loaded_datasets.push([result_set, "IntersectResult"])
					puts 'Result Saved!'
				end
			end
			puts 'Returning to the Main Menu'

		# Menu choice for cartesian product
		when menu_choice == "7" || menu_choice == "[7]"
			puts 'Executing ' + $option7
			# Choose Dataset 1
			# Choose Dataset 2
			# Execute product
			# Print Count
			# Ask to print full result
			valid_set1 = false
			valid_set2 = false
			print_datasets
			while true
				print '1. Select a dataset number for the first set (Enter [Q] or [q] to return to the Main Menu): '
				menu_choice = gets.chomp
				puts ''
				case
				when menu_choice == "Q" || menu_choice == "[Q]" || menu_choice == "q" || menu_choice == "[q]"
					break
				else
					index_choice = menu_choice.to_i
					if (index_choice != 0)
						case
						when index_choice <= $loaded_datasets.count && index_choice >= 1
							set1 = $loaded_datasets[index_choice - 1]
							valid_set1 = true
							break
						else
							puts 'Invalid dataset number! Please enter a dataset number'
						end
					else
						puts 'Invalid input! Please enter a dataset number.'
					end
				end
			end
			if valid_set1
				while true
					print '2. Select a dataset number for the second set (Enter [Q] or [q] to return to the Main Menu): '
					menu_choice = gets.chomp
					puts ''
					case
					when menu_choice == "Q" || menu_choice == "[Q]" || menu_choice == "q" || menu_choice == "[q]"
						break
					else
						index_choice = menu_choice.to_i
						if (index_choice != 0)
							case
								when index_choice <= $loaded_datasets.count && index_choice >= 1
									set2 = $loaded_datasets[index_choice - 1]
								valid_set2 = true
								break
							else
								puts 'Invalid dataset number! Please enter a dataset number'
							end
						else
							puts 'Invalid input! Please enter a dataset number.'
						end
					end
				end
			end
			if valid_set1 && valid_set2
				result_array = Set.cartesian_product(set1[0], set2[0])
				if result_array.nil?
					puts 'Error. One or more of the Sets were invalid.'
					next
				end
				puts 'The result of the operation has ' + result_array.count.to_s + ' pairs.'
				print 'Would you like to print these to the screen? (yes/no): '
				is_printing = gets.chomp
				puts ''
				case
				when is_printing == "yes" || is_printing == "y"
					puts Set.print_pairs(result_array)
				end
				puts ''
			end
			puts 'Returning to the Main Menu'

		
		when menu_choice == '8' || menu_choice == '[8]' || menu_choice == 'Q' || menu_choice == '[Q]' || menu_choice == 'q' || menu_choice == '[q]'
			puts "Thank you for trying out this demo!"
			break
		else
			puts "{#{menu_choice}} is not a valid command. Please refer to the prompt and enter the number corresponding to a valid command."
		end
	end
	puts "Exiting..."
end

# Begin Demo
run_demo
