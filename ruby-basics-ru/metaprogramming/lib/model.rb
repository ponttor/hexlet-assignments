# frozen_string_literal: true

# BEGIN
module Model
  def self.included(base)
    base.extend(ClassMethods)
  end

  def convert(type, value)
    return nil if value.nil?

    case type
    when :integer
      value.to_i
    when :string
      value.to_s
    when :datetime
      DateTime.parse(value)
    when :boolean
      !!value
    else
      value
    end
  end

  def initialize(attributes = {})
    @store = self.class.instance_variable_get :@store
    @initial_state = self.class.instance_variable_get :@initial_state
    initialization(@initial_state.merge(attributes), @store)
  end

  def initialization(data, scheme)
    data.each do |k, v|
      public_send "#{k}=", v if scheme.key? k
    end
  end

  def attributes
    @store.keys.each_with_object({}) { |cur, acc| acc[cur] = public_send(cur); acc }
  end

  module ClassMethods
    def attribute(name, options)
      @store ||= {}
      @initial_state ||= {}
      @store[name] = options
      @initial_state[name] = options[:default] unless options[:default].nil?

      define_method name do
        instance_variable_get "@#{name}"
      end

      define_method "#{name}=" do |value|
        reduced_type = convert options[:type], value
        instance_variable_set "@#{name}", reduced_type
      end
    end
  end
end
# END
