class CalculationsController < ApplicationController

  # Part I methods

    def flex_square
        # The incoming parameters for this action look like {"number"=>"5"}
        # Rails stores that hash in a variable called params
    
      @user_number = params["number"].to_i
      
      @squared_number = @user_number**2
        
      render("calculations/flexible_square_template.html.erb")
    
    end
    
    def flex_square_root
        # The incoming parameters for this action look like {"number"=>"5"}
        # Rails stores that hash in a variable called params
    
      @user_number = params["number"].to_i
      
      @square_root_of_number = @user_number**0.5
        
      render("calculations/flexible_square_root_template.html.erb")
    
    end

    def flex_payment
      @apr = params["basis_points"].to_f / 10000
      @years = params["number_of_years"].to_i
      @principal = params["present_value"].to_f
    
      monthly_rate = @apr / 12 
      number_of_payments = @years * 12
      @monthly_payment = @principal * monthly_rate * (1 + monthly_rate)**number_of_payments / (((1+monthly_rate)**number_of_payments)-1)
    
      render("calculations/flexible_payment_template.html.erb")
    end
    
    def flex_random
      first_number = params["first_value"].to_i
      second_number = params["second_value"].to_i

      if first_number <= second_number
        @minimum = first_number
        @maximum = second_number
      else
        @minimum = second_number
        @maximum = first_number
      end

      @random_number = rand(@minimum..@maximum)
      
      render("calculations/flexible_random_template.html.erb")
    end
    
  # Part II methods
    
    # Form version of Square 
    
    def form_square
    
      render("calculations/form_square_new_template.html.erb")
    end
    
    def form_square_result
      @user_number = params["user_number"].to_f
      
      @squared_number = @user_number**2
        
      render("calculations/form_square_result_template.html.erb")
    end
    
    # Form version of Square Root
    
    def form_square_root
    
      render("calculations/form_square_root_new_template.html.erb")
    end
    
    def form_square_root_result
      @user_number = params["user_number"].to_f
      
      @square_root = @user_number**0.5
        
      render("calculations/form_square_root_result_template.html.erb")
    end
    
    # Form version of Payment
    
    def form_payment
      render("calculations/form_payment_new_template.html.erb")
    end
    
    def form_payment_result

      @apr = params["apr"].to_f / 100
      @years = params["number_of_years"].to_f
      @principal = params["principal"].to_f
    
      monthly_rate = @apr / 12 
      number_of_payments = @years * 12
      @monthly_payment = @principal * monthly_rate * (1 + monthly_rate)**number_of_payments / (((1+monthly_rate)**number_of_payments)-1)

      render("calculations/form_payment_result_template.html.erb")
    end
    
    # Form version of Random
    
    def form_random
      render("calculations/form_random_new_template.html.erb")
    end
    
    def form_random_result
      first_number = params["minimum"].to_f
      second_number = params["maximum"].to_f

      if first_number <= second_number
        @minimum = first_number
        @maximum = second_number
      else
        @minimum = second_number
        @maximum = first_number
      end

      @random_number = rand(@minimum..@maximum)
 
      render("calculations/form_random_result_template.html.erb")
    end
  
  # Part III methods
  
    # Word Count
    
    def form_word_count
    
      render("calculations/form_word_count_new_template.html.erb")
    end
    
    def form_word_count_result
      @text = params[:user_text]
      @special_word = params[:user_word]
  
      @word_count = @text.split.count
  
      @character_count_with_spaces = @text.length
  
      @character_count_without_spaces = @text.gsub(" ","").length
      
      occurred = 0
    
      @text.split.each do |word|
        if word.downcase.gsub(/[^a-z0-9\s]/i, "") == @special_word.downcase
          occurred = occurred + 1
        end
      end
      
      @occurrences = occurred
    
      render("calculations/form_word_count_result_template.html.erb")
    end
    
    # Description Stats
    def form_descriptive_stats
    
      render("calculations/form_descriptive_stats_new_template.html.erb")
    end
    
    def form_descriptive_stats_result

      @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)
  

      @sorted_numbers = @numbers.sort
      
      @count = @sorted_numbers.count
  
      @minimum = @sorted_numbers[0]
      
      @maximum = @sorted_numbers[@count-1]
  
      @range = @maximum - @minimum
  
      if @count.odd?
        @median = @sorted_numbers[@count/2]
        elsif
        @median = (@sorted_numbers[@count/2-1] + @sorted_numbers[@count/2])/2
      end
      
      sum = 0
  
      @sorted_numbers.each do |number|
        sum = sum + number
      end
      
      @sum = sum
  
      @mean = sum/@count
  
      x_bar_squared = 0
      x_bar_squared_sum = 0
  
      @sorted_numbers.each do |number|
        x_bar_squared = (number - @mean)**2
        x_bar_squared_sum += x_bar_squared
      end
      
      @variance = x_bar_squared_sum / (@count)
  
      @standard_deviation = @variance**0.5
  
  
      #count the number of occurrences of each number    
      mode_array = []
      loop_count = 0
      prev_number = 0
      
      @sorted_numbers.each do |number|
        if loop_count == 0
          number_hash = { :value => number, :count => 1 }
          mode_array.push(number_hash)
          prev_number = number
        elsif number == prev_number
            mode_array.last[:count] += 1
        else
          number_hash = { :value => number, :count => 1 }
          mode_array.push(number_hash)
          prev_number = number
        end
      
        loop_count += 1
      end
  
      #determine the maximum number of occurrences of any value
      maximum_count = 0
  
      mode_array.each do |contender|
        if contender[:count] > maximum_count
          maximum_count = contender[:count]
        end
      end 
      
      # Figure out how many values have the maximum count. if there's only one, it
      # is the mode. Otherwise, any value with the maximum count is a mode.
      
      modes = []
      
      mode_array.each do |contender|
        if contender[:count] == maximum_count
          modes.push(contender[:value])
        end
      end
    
      if modes.count == 1
        @mode = modes.first
      else
        @mode = modes
      end

    
      render("calculations/form_descriptive_stats_result_template.html.erb")
    end
    
end