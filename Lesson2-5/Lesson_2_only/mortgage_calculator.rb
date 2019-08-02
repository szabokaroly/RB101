=begin
    Understand the problem
Build a mortgage calculator
Necessary pieces of information:
  the loan amount
  the Annual Percentage Rate (APR)
  the loan duration
Based on these three pieces of information, calculate:
  monthly interest rate
  loan duration in months

Formula: m = p * (j / (1 - (1 + j)**(-n)))
where
m = monthly payment
p = loan amount
j = monthly interest rate
n = loan duration in months

    Exceptions
p = $2,000,000 APR = 18%, loan duration in years  = 2
p = $750,000 APR = 26%, loan duration in years = 10
p = $58,500 APR = 7%,loan duration in years = 3

    Data structure
number(we are going to work with mathematical operations.)

    Algorithm
Save messages in a yaml file
Create methods to validate for integers and floats
Create three loops for the three inputs (loan amount, annual interest rate
and duration in years)
Prompt the user for 3 inputs and save the inputs in separate variables
Things that I need to calculate:
loan duration in months: loan duration in years * 12
monthly payment: loan_amount * (monthly interest rate / (1-
                      (1 + monthly interest rate)**(-loan duration in months)))
calculate:
  annual interest rate (annual interest rate to floats / 100)
  monthly interest rate (annual interest rate / 12)
Go back and calculate monthly
Output the duration in month and the monthly payment.

=end

require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def prompt(message)
  Kernel.puts "-- #{message}"
end

def integer?(number)
  number.to_i.to_s == number
end

def number?(number)
  number.to_i.to_s == number || number.to_f.to_s == number
end

loop do
  prompt(MESSAGES['welcome'])

  prompt(MESSAGES['linespace'])

  loan = ''
  loop do
    prompt(MESSAGES['loan_question'])
    loan = gets.chomp
    if integer?(loan) && loan.to_i > 0
      break
    elsif loan.to_i <= 0 || loan.empty?()
      prompt(MESSAGES['only_positive'])
    else
      prompt(MESSAGES['not_valid'])
    end
  end

  int_rate = ''
  loop do
    prompt(MESSAGES['interest_question'])
    int_rate = gets.chomp
    if number?(int_rate) && int_rate.to_i > 0 && int_rate.to_f > 0
      break
    elsif int_rate.to_i <= 0 || int_rate.to_f <= 0 || int_rate.empty?()
      prompt(MESSAGES['only_positive'])
    else
      prompt(MESSAGES['not_valid'])
    end
  end

  years = ''
  loop do
    prompt(MESSAGES['duration_question'])
    years = gets.chomp
    if integer?(years) && years.to_i > 0
      break
    elsif years.to_i <= 0 || years.empty?()
      prompt(MESSAGES['only_positive'])
    else
      prompt(MESSAGES['not_valid'])
    end
  end

  months = years.to_i * 12
  ann_int_rate = int_rate.to_f / 100
  mon_int_rate = ann_int_rate / 12

  mon_pay = loan.to_i *
            (mon_int_rate /
            (1 - (1 + mon_int_rate)**-months.to_f))

  prompt("Your loan's duration is #{months} months.")
  prompt("Your monthly payment is going to be $#{mon_pay.round(2)}")

  prompt(MESSAGES['do_again'])
  answer = gets.chomp
  break unless answer == "y" || answer == "Y"
end
prompt(MESSAGES['farewell'])
