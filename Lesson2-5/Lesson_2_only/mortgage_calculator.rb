require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def prompt(message)
  Kernel.puts "-- #{message}"
end

def integer?(number)
  number.to_i.to_s == number
end

def number?(number)
  integer?(number) || number.to_f.to_s == number
end

def valid_loan_input?(loan)
  integer?(loan) && loan.to_i > 0
end

def empty_or_minus_loan_input?(loan)
  loan.to_i <= 0 || loan.empty?()
end

def obtain_loan_amount
  loan = ''
  loop do
    prompt(MESSAGES['loan_question'])
    loan = gets.chomp
    if valid_loan_input?(loan)
      break
    elsif empty_or_minus_loan_input?(loan)
      prompt(MESSAGES['only_positive'])
    else
      prompt(MESSAGES['not_whole'])
    end
  end
  loan
end

def valid_interest_rate_input?(int_rate)
  int_rate.to_i > 0 && int_rate.to_f > 0
end

def empty_or_minus_int_rate_input?(int_rate)
  int_rate.to_i <= 0 || int_rate.to_f <= 0 || int_rate.empty?()
end

def obtain_interest_rate
  int_rate = ''
  loop do
    prompt(MESSAGES['interest_question'])
    int_rate = gets.chomp
    if number?(int_rate) && valid_interest_rate_input?(int_rate)
      break
    elsif number?(int_rate) && (0.0..1.0).cover?(int_rate.to_f)
      break
    elsif empty_or_minus_int_rate_input?(int_rate)
      prompt(MESSAGES['only_positive'])
    else
      prompt(MESSAGES['invalid_input'])
    end
  end
  int_rate
end

def valid_duration_input?(months)
  integer?(months) && months.to_i > 0
end

def empty_or_minus_duration_input?(months)
  months.to_i <= 0 || months.empty?()
end

def obtain_loan_duration
  months = ''
  loop do
    prompt(MESSAGES['duration_question'])
    months = gets.chomp
    if valid_duration_input?(months)
      break
    elsif empty_or_minus_duration_input?(months)
      prompt(MESSAGES['only_positive'])
    else
      prompt(MESSAGES['not_whole'])
    end
  end
  months
end

def calculate_monthly_pay(loan, int_rate, months)
  ann_int_rate = int_rate.to_f / 100
  mon_int_rate = ann_int_rate / 12
  mon_pay = loan.to_i * (mon_int_rate / (1 - (1 + mon_int_rate)**-months.to_f))
  prompt("Your monthly payment is going to be $#{mon_pay.round(2)}")
end

def obtain_play_again_answer
  answer = ''
  loop do
    valid = %w(y yes n no)
    prompt(MESSAGES['do_again'])
    answer = gets.chomp.downcase
    break if valid.include?(answer)
    prompt(MESSAGES['invalid_input'])
  end
  answer
end

def new_calculation?(answer)
  answer == "y" || answer == "yes"
end

loop do
  prompt(MESSAGES['welcome'])

  prompt(MESSAGES['linespace'])

  loan = obtain_loan_amount

  int_rate = obtain_interest_rate

  months = obtain_loan_duration

  calculate_monthly_pay(loan, int_rate, months)

  break unless new_calculation?(obtain_play_again_answer)
end
prompt(MESSAGES['farewell'])
