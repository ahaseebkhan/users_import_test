module PasswordValidations
  extend ActiveSupport::Concern

  def password_strength_validation
    add, minus, repetition_correction = 0, 0, 0
    errors.add(:change, "10 character of #{name}'s password") && return unless password.present?
    add += (10 - password.length) if password.length < 10
    minus += (password.length - 16) if password.length > 16
    add = [missing_values, add].max
    add, minus, repetition_correction = repetition_check(add, minus, repetition_correction) if password.match?(repetition_regex)
    
    characters_to_change = repetition_correction + add + minus
    errors.add(:change, "#{characters_to_change} characters of #{name}'s password") if characters_to_change != 0
  end

  def repetition_check(add, minus, repetition_correction)    
    password.scan(repetition_regex).map { |c| (c[0].length) }.each do |repeat_length|
      if minus >= repeat_length - 2
        minus -= (repeat_length - 2)
        repetition_correction += (repeat_length - 2)
      elsif add >= (repeat_length/3)
        add -= (repeat_length/3)
        repetition_correction += (repeat_length/3) 
      else
        repetition_correction += 1
      end   
    end

    return add, minus, repetition_correction
  end

  def missing_values(missing=0)
    missing += 1 unless password.match?(/(?=.*\d)/)
    missing += 1 unless password.match?(/(?=.*[a-z])/)
    missing += 1 unless password.match?(/(?=.*[A-Z])/)
    missing
  end

  def repetition_regex
    /((.)\2+{2})/
  end
end
