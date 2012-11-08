require 'spec_helper'

describe NQL::SyntaxParser, '-> Comparison' do

  let(:parser) { NQL::SyntaxParser.new }

  context 'Structure and comparators' do

    it 'Equals' do
      tree = parser.parse('var = value')

      tree.comparison.variable.text_value.should eq 'var'
      tree.comparison.comparator.text_value.should eq '='
      tree.comparison.value.text_value.should eq 'value'
    end

    it 'Not equals' do
      tree = parser.parse('var != value')

      tree.comparison.variable.text_value.should eq 'var'
      tree.comparison.comparator.text_value.should eq '!='
      tree.comparison.value.text_value.should eq 'value'
    end

    it 'Greater than' do
      tree = parser.parse('var > value')

      tree.comparison.variable.text_value.should eq 'var'
      tree.comparison.comparator.text_value.should eq '>'
      tree.comparison.value.text_value.should eq 'value'
    end

    it 'Greater or equals than' do
      tree = parser.parse('var >= value')

      tree.comparison.variable.text_value.should eq 'var'
      tree.comparison.comparator.text_value.should eq '>='
      tree.comparison.value.text_value.should eq 'value'
    end

    it 'Less than' do
      tree = parser.parse('var < value')

      tree.comparison.variable.text_value.should eq 'var'
      tree.comparison.comparator.text_value.should eq '<'
      tree.comparison.value.text_value.should eq 'value'
    end

    it 'Less or equals than' do
      tree = parser.parse('var <= value')

      tree.comparison.variable.text_value.should eq 'var'
      tree.comparison.comparator.text_value.should eq '<='
      tree.comparison.value.text_value.should eq 'value'
    end

    it 'Contains' do
      tree = parser.parse('var % value')

      tree.comparison.variable.text_value.should eq 'var'
      tree.comparison.comparator.text_value.should eq '%'
      tree.comparison.value.text_value.should eq 'value'
    end

  end

  context 'Space separators' do

    it 'Without spaces' do
      tree = parser.parse('var=value')

      tree.comparison.variable.text_value.should eq 'var'
      tree.comparison.comparator.text_value.should eq '='
      tree.comparison.value.text_value.should eq 'value'
    end

    it 'With many spaces' do
      tree = parser.parse('var   =   value')

      tree.comparison.variable.text_value.should eq 'var'
      tree.comparison.comparator.text_value.should eq '='
      tree.comparison.value.text_value.should eq 'value'
    end

  end

  context 'Variable names' do

    it 'With numbers' do
      tree = parser.parse('var1 = value')
      tree.comparison.variable.text_value.should eq 'var1'
    end

    it 'With uppercase' do
      tree = parser.parse('varName = value')
      tree.comparison.variable.text_value.should eq 'varName'
    end

    it 'With underscore' do
      tree = parser.parse('var_name = value')
      tree.comparison.variable.text_value.should eq 'var_name'
    end

    it 'With dot' do
      tree = parser.parse('var.name = value')
      tree.comparison.variable.text_value.should eq 'var.name'
    end

  end

  context 'Values' do

    it 'With numbers' do
      tree = parser.parse('var = value1')
      tree.comparison.value.text_value.should eq 'value1'
    end

    it 'With uppercase' do
      tree = parser.parse('var = valueDummy')
      tree.comparison.value.text_value.should eq 'valueDummy'
    end

    it 'With dot' do
      tree = parser.parse('var = value.dummy')
      tree.comparison.value.text_value.should eq 'value.dummy'
    end


    it 'With utf8 chars and symbols' do
      utf8_symbols = "\u00c1\u00c0\u00c9\u00c8\u00cd\u00cc\u00d3\u00d2\u00da\u00d9\u00dc\u00d1\u00c7\u00e1\u00e0\u00e9\u00e8\u00ed\u00ec\u00f3\u00f2\u00fa\u00f9\u00fc\u00f1\u00e7"
      tree = parser.parse("var = .#+-#{utf8_symbols}")
      tree.comparison.value.text_value.should eq ".#+-#{utf8_symbols}"
    end

    it 'With spaces' do
      tree = parser.parse('var = value 123')
      tree.comparison.value.text_value.should eq 'value 123'
    end

    it 'With comparators, symbols and spaces' do
      tree = parser.parse('var = value1 > value2 ! value3')
      tree.comparison.value.text_value.should eq 'value1 > value2 ! value3'
    end

  end

end
