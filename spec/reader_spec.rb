# frozen_string_literal: true
require_relative "../reader"

RSpec.describe Reader do
  it "integer Reader test" do
    expect(Reader.new("1").parse).to eq(1)
    expect(Reader.new("+1").parse).to eq(1)
    expect(Reader.new("-1").parse).to eq(-1)
  end
  it "String Reader test" do
    expect(Reader.new("\"hello world\"").parse).to eq("hello world")
  end
  it "float Reader test" do
    expect(Reader.new("1.23").parse).to eq(1.23)
  end
  it "add Reader test" do
    expect(Reader.new("(+ 1 2)").parse).to eq([:+, 1, 2])
  end
  it "if Reader.new test" do
    expect(Reader.new("(if (>a b) (print a)(print b))").parse).to eq([:if, [:>, :a, :b], [:print, :a], [:print, :b]])
  end
  it "variable Reader.new test" do
    expect(Reader.new("(test_wei_test 100)").parse).to eq([:test_wei_test, 100])
  end
end
