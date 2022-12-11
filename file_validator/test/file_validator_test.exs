defmodule FileValidatorTest do
  use ExUnit.Case
  doctest FileValidator

  test "file validation should be false" do
    file = "somefile.exe"
    assert FileValidator.valid?(file) == false
  end

  test "file validation should be true" do
    file = "somefile.png"
    assert FileValidator.valid?(file) == true
  end
end
