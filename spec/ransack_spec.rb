require 'spec_helper'

describe 'Ransack Query' do

  let(:parser) { NQL::SyntaxParser.new }

  context 'Single comparisons' do

    it 'Equals' do
      q = parser.parse('id = 1234').to_ransack

      q[:c][0].should have_attribute 'id'
      q[:c][0].should have_predicate 'eq'
      q[:c][0].should have_value '1234'
    end

    it 'Not equals' do
      q = parser.parse('id != 1234').to_ransack

      q[:c][0].should have_attribute 'id'
      q[:c][0].should have_predicate 'not_eq'
      q[:c][0].should have_value '1234'
    end

    it 'Greater than' do
      q = parser.parse('id > 1234').to_ransack

      q[:c][0].should have_attribute 'id'
      q[:c][0].should have_predicate 'gt'
      q[:c][0].should have_value '1234'
    end

    it 'Greater or equals than' do
      q = parser.parse('id >= 1234').to_ransack

      q[:c][0].should have_attribute 'id'
      q[:c][0].should have_predicate 'gteq'
      q[:c][0].should have_value '1234'
    end

    it 'Less than' do
      q = parser.parse('id < 1234').to_ransack

      q[:c][0].should have_attribute 'id'
      q[:c][0].should have_predicate 'lt'
      q[:c][0].should have_value '1234'
    end

    it 'Less or equals than' do
      q = parser.parse('id <= 1234').to_ransack

      q[:c][0].should have_attribute 'id'
      q[:c][0].should have_predicate 'lteq'
      q[:c][0].should have_value '1234'
    end

    it 'Contains' do
      q = parser.parse('id : 1234').to_ransack

      q[:c][0].should have_attribute 'id'
      q[:c][0].should have_predicate 'cont'
      q[:c][0].should have_value '1234'
    end

    it 'Matches' do
      q = parser.parse('id ~ 1234').to_ransack

      q[:c][0].should have_attribute 'id'
      q[:c][0].should have_predicate 'matches'
      q[:c][0].should have_value '1234'
    end

    it 'Model references' do
      q = parser.parse('models.id = 1234').to_ransack

      q[:c][0].should have_attribute 'models_id'
      q[:c][0].should have_predicate 'eq'
      q[:c][0].should have_value '1234'
    end

  end

  context 'Coordinated comparisons' do

    it 'And' do
      q = parser.parse('id > 1234 & name = abcd').to_ransack

      q[:g][0][:m].should eq 'and'
      q[:g][0][:c][0].should have_attribute 'id'
      q[:g][0][:c][0].should have_predicate 'gt'
      q[:g][0][:c][0].should have_value '1234'
      q[:g][0][:c][1].should have_attribute 'name'
      q[:g][0][:c][1].should have_predicate 'eq'
      q[:g][0][:c][1].should have_value 'abcd'
    end

    it 'Or' do
      q = parser.parse('id < 1234 | name : abcd').to_ransack

      q[:g][0][:m].should eq 'or'
      q[:g][0][:c][0].should have_attribute 'id'
      q[:g][0][:c][0].should have_predicate 'lt'
      q[:g][0][:c][0].should have_value '1234'
      q[:g][0][:c][1].should have_attribute 'name'
      q[:g][0][:c][1].should have_predicate 'cont'
      q[:g][0][:c][1].should have_value 'abcd'
    end

    it 'And then Or' do
      q = parser.parse('id > 1234 & name = abcd | name : efgh').to_ransack

      q[:g][0][:m].should eq 'and'
      q[:g][0][:c][0].should have_attribute 'id'
      q[:g][0][:c][0].should have_predicate 'gt'
      q[:g][0][:c][0].should have_value '1234'
      q[:g][0][:g][0][:m].should eq 'or'
      q[:g][0][:g][0][:c][0].should have_attribute 'name'
      q[:g][0][:g][0][:c][0].should have_predicate 'eq'
      q[:g][0][:g][0][:c][0].should have_value 'abcd'
      q[:g][0][:g][0][:c][1].should have_attribute 'name'
      q[:g][0][:g][0][:c][1].should have_predicate 'cont'
      q[:g][0][:g][0][:c][1].should have_value 'efgh'
    end

    it 'With parentheses' do
      q = parser.parse('(id > 1234 & name = abcd) | name : efgh').to_ransack

      q[:g][0][:g][0][:m].should eq 'and'
      q[:g][0][:g][0][:c][0].should have_attribute 'id'
      q[:g][0][:g][0][:c][0].should have_predicate 'gt'
      q[:g][0][:g][0][:c][0].should have_value '1234'
      q[:g][0][:g][0][:c][1].should have_attribute 'name'
      q[:g][0][:g][0][:c][1].should have_predicate 'eq'
      q[:g][0][:g][0][:c][1].should have_value 'abcd'
      q[:g][0][:m].should eq 'or'
      q[:g][0][:c][0].should have_attribute 'name'
      q[:g][0][:c][0].should have_predicate 'cont'
      q[:g][0][:c][0].should have_value 'efgh'
    end

  end

end