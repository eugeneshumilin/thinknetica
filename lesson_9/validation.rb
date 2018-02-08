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
    def validate(attribute, val_type, *param)
      @validations ||= {}
      validations[attribute] = { val_type: val_type, param: param.first }
      define_method("validations") { self.class.instance_variable_get("@validations") }
      define_method("attr_value") { |name| instance_variable_get("@#{name}") }
    end

    private

    attr_reader :validations
  end

  module InstanceMethods
    def validate!
      validations.each do |attribute, args|
        val_type = args[:val_type]
        param = args[:param]
        message = "#{attribute} #{Validation::ERROR_MESSAGES[val_type]}"
        raise message if send("#{val_type}", attribute, param)
        puts "'#{attribute} - #{val_type}' validation OK"
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def presence(attribute, _option)
      attr_value(attribute).empty? || attr_value(attribute).nil?
    end

    def format(attribute, format)
      attr_value(attribute) !~ format
    end

    def type(attribute, type)
      attr_value(attribute).class != type
    end
  end
end
