require 'treetop'
require 'active_record'
require 'active_support/all'
require 'ransack'

require 'nql/version'
require 'nql/grammar'

module NQL

  def self.to_ransack(query)
    return nil if query.nil? || query.strip.empty?
    expression = SyntaxParser.new.parse(query)
    return invalid_condition unless expression
    expression.to_ransack
  end

  private

  def self.invalid_condition
    {c: [{a: {'0' => {name: 'id'}}, p: 'eq', v: {'0' => {value: '0'}}}]}
  end

end
