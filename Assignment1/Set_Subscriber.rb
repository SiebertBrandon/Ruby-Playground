# Name: Brandon Siebert
# Course: CSC 415
# Semester: Fall 2017
# Instructor: Dr. Pulimood 
# Project name: Assignment 1
# Description: Design a Set class which holds operates on a set of Subscriber objects. 
# Filename: Set_Subscriber.rb 
# Description: Houses the Set and Subscriber classes used for Assignment 1
# Last modified on: 9/26/2018

require 'csv'
$log_level = 1
class Subscriber
	attr_accessor :name
	attr_accessor :account_number
	def initialize(account_number, name)
		raise "Bad Subscriber Initialization Data!" if !account_number.instance_of?(Fixnum) || !name.instance_of?(String)
		@account_number = account_number.to_i
		@name = name
	end

	#-----------------------------------------------------------------------------------------
	#  Function: to_s
	#
	#	Parameters:    
	#	output [String]: The string representation of this subscriber
	#    
	#	Pre-condition: Subscriber is initialized and holds valid parameters.
	#-----------------------------------------------------------------------------------------
	def to_s
		return "<#{@account_number}, \t#{@name}>"
	end
end
class Set
	attr_accessor :dup_count
	attr_accessor :level
	attr_accessor :dataset
	def initialize(filename = nil)
		@dup_count = 0
		@dataset = Hash.new
		@dataset.default = nil
		if !filename.nil?
			CSV.foreach(filename, 'r') do |row|
				row_array = row[0].split(" ")
				account_number = row_array[0]
				name = ""
				row_array.drop(1).each {|token| name << token + " "}
				name.chomp!(" ")
				self.add_element(Subscriber.new(account_number.to_i, name))
			end
		end
	end

	#-----------------------------------------------------------------------------------------
	#  Function: add_element
	#
	#	Parameters:
	#		input [Subscriber]: Subscriber object being added into this Set
	#
	#	Pre-condition: Both the Subscriber object and this Object must be initialized
	#	Post-condition: Object possibly gains another element. Object will no longer return
	#			true when "empty?" is called.
	#-----------------------------------------------------------------------------------------
	def add_element(subscriber)
		# Ensure that subscriber is a valid Subscriber object
		if defined?(subscriber.name) && defined?(subscriber.account_number) && subscriber.instance_of?(Subscriber)
			tmp_entry = @dataset["#{subscriber.account_number}#{subscriber.name}".to_sym]
			if tmp_entry.nil?
				@dataset["#{subscriber.account_number}#{subscriber.name}".to_sym] = subscriber
			elsif tmp_entry.account_number != subscriber.account_number || tmp_entry.name != subscriber.name
				@dataset["#{subscriber.account_number}#{subscriber.name}".to_sym] = subscriber
			else
				@dup_count += 1
				puts "[WRN] add_element: Duplicate entry (#{subscriber.account_number}, #{subscriber.name} vs " + @dataset["#{subscriber.account_number}#{subscriber.name}".to_sym].to_s + "). Skipping." if $log_level >= 2
			end
		else
			puts "[ERR] add_element: Invalid subscriber object." if $log_level >= 1
		end
	end

	#-----------------------------------------------------------------------------------------
	#  Function: empty?
	#	 
	#	Parameters:
	#	output [Boolean]: True if this Set's dataset has any non-nil entries. False if it does not.
	#
	#	Pre-condition: This Set is initialized
	#-----------------------------------------------------------------------------------------
	def empty?
		return !@dataset.any?
	end

	#-----------------------------------------------------------------------------------------
        #  Function: to_s
        #
        #       Parameters:
        #       output [String]: The string representation of this set.
        #
        #       Pre-condition: Set is initialized and holds valid parameters.
        #-----------------------------------------------------------------------------------------
	def to_s
		tmp_ary = @dataset.values
		string = ""
		tmp_ary.each {|subscriber| string << subscriber.to_s + ", \n"}
		string.chomp!(", \n") if (string)
		return "{" + string + "}\n"
	end

	#-----------------------------------------------------------------------------------------
        #  Function: count
        #
        #       Parameters:
        #       output [Fixnum]: The number of objects contained in this Set's dataset.
        #
        #       Pre-condition: Set is initialized and holds valid parameters.
        #-----------------------------------------------------------------------------------------
	def count
		return @dataset.count
	end
	# Set.class Methods Begin
	class << self

		#-----------------------------------------------------------------------------------------
        	#  Function: union
        	#
        	#       Parameters:
		#	input1 [Set]: First set to perform a union set operation on.
		#	input2 [Set]: Second set to perform a union set operation on.
        	#       output [Set]: A third set as a result of the union operation.
        	#
        	#       Pre-condition: input1 and input2 need to be initialized Set objects.
		#
		#	Post-condition: Creates a third set which contains all of the unique entries of input1 and input2.
        	#-----------------------------------------------------------------------------------------
		def union(set1, set2)
			if !set1.instance_of?(Set) || !set2.instance_of?(Set)
				puts '[ERR] Set.union: One or more input arguments are not of type Set'
				return nil
			end
			set3 = Set.new
			set1.dataset.each do |account_number, subscriber|
				set3.add_element(subscriber)
			end
			set2.dataset.each do |account_number, subscriber|
				set3.add_element(subscriber)
			end
			return set3
		end
		
		#-----------------------------------------------------------------------------------------
                #  Function: intersect
                #
                #       Parameters:
                #       input1 [Set]: First set to perform an intersect set operation on.
                #       input2 [Set]: Second set to perform an intersect set operation on.
                #       output [Set]: A third set as a result of the intersect operation.
                #
                #       Pre-condition: input1 and input2 need to be initialized Set objects.
		#
		#	Post-condition: Creates a third set which contains only the common entries of input1 and input2.
                #-----------------------------------------------------------------------------------------
		def intersect(set1, set2)
			if !set1.instance_of?(Set) || !set2.instance_of?(Set)
                                puts '[ERR] Set.union: One or more input arguments are not of type Set'
                                return nil
                        end
			set3 = Set.new
			set1.dataset.each do |account_number, subscriber|
				set3.add_element(subscriber) if set2.dataset.key?("#{subscriber.account_number}#{subscriber.name}".to_sym)
			end
			return set3
		end

		#-----------------------------------------------------------------------------------------
                #  Function: cartesian_product
                #
                #       Parameters:
                #       input1 [Set]: First set to perform a cartesian product operation on.
                #       input2 [Set]: Second set to perform a cartesian product operation on.
                #       output [Array<Array<Subscriber, Subscriber>...>]: Returns an array of subscriber pairs.
                #
                #       Pre-condition: input1 and input2 need to be initialized Set objects.
		#
		#	Post-condition: Computes pairs of entries between all elements of input1 and all elements of input2.
                #-----------------------------------------------------------------------------------------
		def cartesian_product(set1, set2)
			if !set1.instance_of?(Set) || !set2.instance_of?(Set)
                                puts '[ERR] Set.union: One or more input arguments are not of type Set'
                                return nil
                        end
			output_array = Array.new(0)
			set1.dataset.values.each do |sub1|
				set2.dataset.values.each do |sub2|
					output_array.push([sub1, sub2])
				end
			end
			return output_array
		end
		
		#-----------------------------------------------------------------------------------------
                #  Function: print_pairs
                #
                #       Parameters:
                #       input [Array<Array<Subscriber, Subscriber>...>]: A Subscriber pair array created from the cartesian_product function.
		#	output [String]: Human-readable string representing the input.
                #
                #       Pre-condition: input must be formatted correctly and contain all valid subscriber objects.
		#
		#	Post-condition: Returns a the string representation of the post-cartesian_product datastructure.
                #-----------------------------------------------------------------------------------------
		def print_pairs(pairs)
			if !pairs.instance_of?(Array)
				puts '[ERR] Set.print_pairs: Argument needs to be of type Array[Array[Subscriber, Subscriber]...]'
				return nil
			end
			string = ""
			string << "{"
			pairs.each do |pair|
				string << "("
				pair.each {|subscriber| string << subscriber.to_s + ",\t\t"}
				string.chomp!(",\t\t")
				string << "), \n"
			end
			string.chomp!(", \n")
			string << "}"
			return string
		end
	end
	# Set.class Methods End
end

