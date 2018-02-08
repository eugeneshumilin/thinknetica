module Validation
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attr_name, *params)
      @validations ||= []
      @validations << { attr_name => params }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |values|
        values.each do |attr_name, params|
          attribute = instance_variable_get("@#{attr_name}")
          send(params[0].to_s, attribute, params[1])
          puts "'#{attr_name} - #{params[0]}' validation OK"
        end
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
      raise 'value is empty or nil!' if attribute.empty? || attribute.nil?
    end

    def format(attribute, format)
      raise 'invalid format!' if attribute !~ format
    end

    def type(attribute, type)
      raise 'invalid type for object!' if attribute.class != type
    end
  end
end
