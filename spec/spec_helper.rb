require 'nql'

Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].each {|f| require f}

ActiveRecord::Migrator.migrations_path = "#{File.dirname(__FILE__)}/migrations"

RSpec::Matchers.define :have_attribute do |expected|
  match do |actual|
    actual['a']['0']['name'] == expected
  end

  failure_message_for_should do |actual|
    "expected: #{actual['a']['0']['name']}\n     got: #{expected}"
  end
end

RSpec::Matchers.define :have_predicate do |expected|
  match do |actual|
    actual['p'] == expected
  end

  failure_message_for_should do |actual|
    "expected: #{actual['p']}\n     got: #{expected}"
  end
end

RSpec::Matchers.define :have_value do |expected|
  match do |actual|
    actual['v']['0']['value'] == expected
  end

  failure_message_for_should do |actual|
    "expected: #{actual['v']['0']['value']}\n     got: #{expected}"
  end
end

RSpec::Matchers.define :produce_sql do |expected|
  match do |actual|
    actual.to_sql == expected
  end

  failure_message_for_should do |actual|
    "expected: #{actual.to_sql}\n     got: #{expected}"
  end
end