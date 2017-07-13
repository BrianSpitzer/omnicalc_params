class CalculationsController < ApplicationController
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
    
    def form_square
    
      render("calculations/form_square_template.html.erb")
    end
    
    def form_square_result
      @user_number = params["user_number"].to_i
      
      @squared_number = @user_number**2
        

      render("calculations/form_square_result_template.html.erb")
    end
    
end