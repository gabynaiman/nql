module NQL
  class Query

    attr_reader :model
    attr_reader :text
    attr_reader :expression

    def initialize(model, text)
      raise InvalidModelError.new model unless model.ancestors.include? ::ActiveRecord::Base
      raise DataTypeError.new text if text && !text.is_a?(String)
      @model = model
      @text = text
      evaluate
    end

    def ransack_search
      if expression
        model.search(expression.to_ransack)
      else
        model.search
      end
    end

    private

    def evaluate
      if text.nil? || text.strip.empty?
        @expression = nil
      else
        parser = SyntaxParser.new
        @expression = parser.parse(text)
        raise SyntaxError.new(parser.failure_reason) unless expression
        validate_attributes!
      end
    end

    def validate_attributes!
      return unless expression
      extended_attributes = model.column_names | model.reflections.flat_map { |k, v| v.klass.column_names.map { |c| "#{k}_#{c}" } }
      invalid_attributes(expression.to_ransack, extended_attributes).tap do |attributes|
        raise AttributesNotFoundError.new model, attributes if attributes.any?
      end
    end

    def invalid_attributes(node, valid_attributes)
      return [] unless node

      node.deep_symbolize_keys.flat_map do |k, v|
        if k == :a
          [v['0'.to_sym][:name]] unless valid_attributes.include?(v['0'.to_sym][:name])
        else
          if v.is_a?(Hash)
            invalid_attributes(v, valid_attributes)
          elsif v.is_a?(Array)
            v.select { |e| e.is_a?(Hash) }.flat_map { |e| invalid_attributes(e, valid_attributes) }
          end
        end
      end.compact
    end

  end
end