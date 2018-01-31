module Bibox
  module Models
    class Base
      
      def initialize(hash)
        self.class::MAPPING.keys.each { |key| self.class.send(:attr_accessor, key) }
        
        hash.each do |key, value|
          key             =     key.underscore.to_sym
          type            =     self.class::MAPPING.fetch(key, nil)
          value           =     value && type ? ::Bibox::Utilities::convert_value(value, type, use_ms_for_time: true) : value
          self.send("#{key}=", value) if self.respond_to?(key)
        end
      end
      
      def attributes
        Hash[instance_variables.map { |name| [name.to_s.gsub(/^@/, "").to_sym, instance_variable_get(name)] }]
      end
      
      def self.parse(data)
        data&.collect { |item| self.new(item) }
      end
      
    end
  end
end
