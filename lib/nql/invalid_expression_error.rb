module NQL
  class InvalidExpressionError < StandardError
    def initialize(message)
      super
    end
  end
end