require 'treetop'
require 'active_record'
require 'active_support/all'
require 'ransack'

require 'nql/version'
require 'nql/grammar'
require 'nql/invalid_expression_error'

module NQL

  def self.to_ransack(query)
    return nil if query.nil? || query.strip.empty?
    expression = parser.parse(query)
    raise InvalidExpressionError.new(parser.failure_reason) unless expression
    expression.to_ransack
  end

  private

  def self.parser
    @@parser ||= SyntaxParser.new
  end

end
