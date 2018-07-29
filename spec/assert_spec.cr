require "./spec_helper"

class SomeClass
  property id : Int32 = 0
end

describe "#assert!" do
  it "succeeds when value is true" do
    (assert! true).should eq true
  end

  it "fails when value is false" do
    expect_raises(Exception) { assert! false }
  end

  it "works properly with ints" do
    assert! 1
    assert! 10
    expect_raises(Exception) { assert! 0 }
    expect_raises(Exception) { assert! -1 }
  end

  it "works properly with floats" do
    assert! 0.0024
    assert! 100.0
    expect_raises(Exception) { assert! 0.0 }
    expect_raises(Exception) { assert! -0.1 }
  end

  it "works properly with strings" do
    assert! "hey"
    assert! "TrUe"
    assert! "yay"
    assert! "1"
    assert! "1.1"
    expect_raises(Exception) { assert! "fAlse" }
    expect_raises(Exception) { assert! "" }
    expect_raises(Exception) { assert! "0" }
    expect_raises(Exception) { assert! "0.0" }
    expect_raises(Exception) { assert! "nil" }
    expect_raises(Exception) { assert! "No" }
  end

  it "works with nil and objects" do
    assert! SomeClass.new
    expect_raises(Exception) { assert! nil }
  end
end
