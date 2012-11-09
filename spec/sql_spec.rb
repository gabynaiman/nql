require 'spec_helper'

describe 'SQL generation' do

  before :all do
    ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ":memory:"
    ActiveRecord::Base.connection
    ActiveRecord::Migrator.migrate ActiveRecord::Migrator.migrations_path
  end

  context 'Single comparisons' do

    it 'Equals' do
      q = 'name = abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE \"countries\".\"name\" = 'abcd'"
    end

    it 'Not equals' do
      q = 'name != abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE (\"countries\".\"name\" != 'abcd')"
    end

    it 'Greater than' do
      q = 'name > abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE (\"countries\".\"name\" > 'abcd')"
    end

    it 'Greater or equals than' do
      q = 'name >= abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE (\"countries\".\"name\" >= 'abcd')"
    end

    it 'Less than' do
      q = 'name < abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE (\"countries\".\"name\" < 'abcd')"
    end

    it 'Less or equals than' do
      q = 'name <= abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE (\"countries\".\"name\" <= 'abcd')"
    end

    it 'Contains' do
      q = 'name : abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE (\"countries\".\"name\" LIKE '%abcd%')"
    end

  end

  context 'Coordinated comparisons' do

    it 'And' do
      q = 'id > 1234 & name = abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE ((\"countries\".\"id\" > 1234 AND \"countries\".\"name\" = 'abcd'))"
    end

    it 'Or' do
      q = 'id < 1234 | name : abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE ((\"countries\".\"id\" < 1234 OR \"countries\".\"name\" LIKE '%abcd%'))"
    end

    it 'And then Or' do
      q = 'id > 1234 & name = abcd | name : efgh'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE ((\"countries\".\"id\" > 1234 AND (\"countries\".\"name\" = 'abcd' OR \"countries\".\"name\" LIKE '%efgh%')))"
    end

    it 'With parentheses' do
      q = '(id > 1234 & name = abcd) | name : efgh'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE ((\"countries\".\"name\" LIKE '%efgh%' OR (\"countries\".\"id\" > 1234 AND \"countries\".\"name\" = 'abcd')))"
    end

  end

  context 'Model joins' do

    it 'Parent join' do
      q = 'country.name : abcd'
      City.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"cities\".* FROM \"cities\" LEFT OUTER JOIN \"countries\" ON \"countries\".\"id\" = \"cities\".\"country_id\" WHERE (\"countries\".\"name\" LIKE '%abcd%')"
    end

    it 'Children join' do
      q = 'cities.name : abcd'
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\" LEFT OUTER JOIN \"cities\" ON \"cities\".\"country_id\" = \"countries\".\"id\" WHERE (\"cities\".\"name\" LIKE '%abcd%')"
    end

    it 'Children join distinct' do
      q = 'cities.name : abcd'
      Country.search(NQL.to_ransack(q)).result(distinct: true).should produce_sql "SELECT DISTINCT \"countries\".* FROM \"countries\" LEFT OUTER JOIN \"cities\" ON \"cities\".\"country_id\" = \"countries\".\"id\" WHERE (\"cities\".\"name\" LIKE '%abcd%')"
    end

  end

  context 'Invalid queries' do

    it 'Nil' do
      q = nil
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\""
    end

    it 'Empty' do
      q = ''
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\""
    end

    it 'Empty with spaces' do
      q = '   '
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\""
    end

    it 'Partial expression' do
      q = 'id ='
      Country.search(NQL.to_ransack(q)).result.should produce_sql "SELECT \"countries\".* FROM \"countries\"  WHERE \"countries\".\"id\" = 0"
    end

  end

end