module NQL
  class Error < StandardError
  end

  class SyntaxError < Error
  end

  class DataTypeError < Error
    def initialize(text)
      super "#{text} must be a String"
    end
  end

  class InvalidModelError < Error
    def initialize(model)
      super "#{model} must be subclass of ActiveRecord::Base"
    end
  end

  class AttributesNotFoundError < Error
    def initialize(model, attributes)
      super "#{model} does not contains the attributes #{attributes}"
    end
  end

end