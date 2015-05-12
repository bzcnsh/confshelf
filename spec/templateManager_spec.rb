require 'yaml'
require_relative "../component/vlan"

RSpec::Matchers.define :multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end

describe "RSepc Greeter" do
  
  it "should say 'Hello Rspec!' when it receives the greet() message" do
    (2 + 2).should == 4
  end
  it "include 3" do
    [1,2,3].should include(3), "oh no"
  end
  it "array size change" do
    array = []
    expect{array<<44}.to change{array.size}.from(0).to(1)
  end
end

describe 12 do
  it {should multiple_of(6)}
end

describe "Array: " do
  let(:game) { [12,23] }

  it "is not empty" do
    game.should_not be_empty
  end
  it "include 2" do
    game.should include(12)
  end
end

shared_examples_for "a single-element array" do
  it {should_not be_empty}
end

describe ["foo"] do
  it_behaves_like "a single-element array"
end
describe [12] do
  it_behaves_like "a single-element array"
end

describe "double test" do
  it "test01" do
    foo = double(:foo, :size => 3, :to_s => "Foo")
    foo.to_s.should == "Foo"
  end
  it "test02" do
    foo = double
    foo.stub(:bar).and_return 1, 2, 3
    foo.bar.should == 1
    foo.bar.should == 2
    foo.bar.should == 3
  end
  it "test03" do
    foo = double(:foo, :size=>3).as_null_object
    foo.ccdd
  end
  
end
