module Validation
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  ERROR_MESSAGES = {
    presence: 'value is empty or nil!',
    format: 'invalid format!',
    type: 'invalid type for object!'
  }.freeze

  module ClassMethods
    def validate(*args)
      unless instance_variable_get(:@validations)
        instance_variable_set(:@validations, [])
      end
      instance_variable_get(:@validations) << args
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@validations).each do |args|
        val = instance_variable_get("@#{args[0]}")
        message = "#{args[0]} #{Validation::ERROR_MESSAGES[args[1]]}"
        raise message if send("validate_#{args[1]}", val, *args[2])
        puts "#{args[0]} - #{args[1]} OK"
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def validate_presence(val)
      val.empty? || val.nil?
    end

    def validate_type(val, type)
      val.class != type
    end

    def validate_format(val, format)
      val !~ format
    end
  end
end
