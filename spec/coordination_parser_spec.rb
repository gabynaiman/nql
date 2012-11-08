require 'spec_helper'

describe NQL::SyntaxParser, '-> Coordination' do

  let(:parser) { NQL::SyntaxParser.new }

  it 'And' do
    tree = parser.parse('var1 = value1 & var2 = value2')

    tree.left.text_value.strip.should eq 'var1 = value1'
    tree.coordinator.text_value.should eq '&'
    tree.right.text_value.strip.should eq 'var2 = value2'
  end

  it 'Or' do
    tree = parser.parse('var1 = value1 | var2 = value2')

    tree.left.text_value.strip.should eq 'var1 = value1'
    tree.coordinator.text_value.should eq '|'
    tree.right.text_value.strip.should eq 'var2 = value2'
  end

  it 'And then Or' do
    tree = parser.parse('var1 = value1 & var2 = value2 | var3 = value3')

    tree.left.text_value.strip.should eq 'var1 = value1'
    tree.coordinator.text_value.should eq '&'
    tree.right.left.text_value.strip.should eq 'var2 = value2'
    tree.right.coordinator.text_value.strip.should eq '|'
    tree.right.right.text_value.strip.should eq 'var3 = value3'
  end

  it 'With parentheses' do
    tree = parser.parse('(var1 = value1 & var2 = value2) | var3 = value3')

    tree.left.expression.left.text_value.strip.should eq 'var1 = value1'
    tree.left.expression.coordinator.text_value.should eq '&'
    tree.left.expression.right.text_value.strip.should eq 'var2 = value2'
    tree.coordinator.text_value.strip.should eq '|'
    tree.right.text_value.strip.should eq 'var3 = value3'
  end

end