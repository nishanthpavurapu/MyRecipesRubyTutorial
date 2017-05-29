require 'test_helper'

class ChefTest < ActiveSupport::TestCase

def setup
@chef = Chef.new(chefname: "nishanth", email: "nishanth@yahoo.com")
end

test "should be valid" do
assert @chef.valid?    
end

test "chefname should be present" do
@chef.chefname = " "
assert_not @chef.valid?
end

test "chefname should not be too long" do
@chef.chefname = "a" * 41
assert_not @chef.valid?
end

test "chefname should not be too short" do
@chef.chefname = "a" * 2    
assert_not @chef.valid?
end

test "email should be present" do
@chef.email = " " 
assert_not @chef.valid?
end

test "email length should be within bounds" do
@chef.email = "a" * 100 + "@example.com"
assert_not @chef.valid?
end

test "email should be unique" do 
dup_chef = @chef.dup
dup_chef.email = @chef.email.upcase
dup_chef.save
assert_not @chef.valid?
end

test "email validation should accept valid address" do
valid_adress = %W[user@eee.com R_TDD-DS@eee.hello.org first.last@nisha.com]
valid_adress.each do |item|
@chef.email = item
assert @chef.valid?, '#{item.inspect} should be valid'
end
end

test "email validation should reject invalid address" do
invalid_adress = %W[user@eee,com R_TDD-DS.hello.org first.last@nisha]
invalid_adress.each do |item|
@chef.email = item
assert_not @chef.valid?, '#{item.inspect} should be invalid'
end
end
end