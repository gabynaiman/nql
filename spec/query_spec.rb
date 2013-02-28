require 'spec_helper'

describe NQL::Query do

  before :all do
    ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ":memory:"
    ActiveRecord::Base.connection
    ActiveRecord::Migrator.migrate ActiveRecord::Migrator.migrations_path
  end

  it 'Valid expression' do
    query = NQL::Query.new Country, 'name: Argentina'

    query.text.should eq 'name: Argentina'
    query.expression.should be_a Treetop::Runtime::SyntaxNode
  end

  it 'Valid with empty expression' do
    query = NQL::Query.new Country, ''

    query.text.should eq ''
    query.expression.should be_nil
  end

  it 'Valid with nil expression' do
    query = NQL::Query.new Country, nil

    query.text.should be_nil
    query.expression.should be_nil
  end

  it 'Invalid model type' do
    expect { NQL::Query.new Object, nil }.to raise_error NQL::InvalidModelError
  end

  it 'Invalid expression type' do
    expect { NQL::Query.new Country, Object.new }.to raise_error NQL::DataTypeError
  end

  it 'Invalid expression syntax' do
    expect { NQL::Query.new Country, 'xyz1234' }.to raise_error NQL::SyntaxError
  end

  it 'Invalid fields' do
    expect { NQL::Query.new Country, 'name: Argentina | xyz: 1234 | abc: 0000'}.to raise_error NQL::AttributesNotFoundError
  end

end