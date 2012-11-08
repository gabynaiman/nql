require 'treetop'
require 'active_record'
require 'active_support/all'
require 'ransack'

require 'nql/version'
require 'nql/grammar'

module NQL

  def self.to_ransack(query)
    SyntaxParser.new.parse(query).to_ransack
  end

end
