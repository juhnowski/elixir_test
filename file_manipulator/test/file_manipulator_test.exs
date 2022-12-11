defmodule FileManipulatorTest do
  use ExUnit.Case
  doctest FileManipulator

  setup do
    file = %{
      name: "test.exs",
      directory: "my_test",
      content: "IO.puts",
      content_to_append: "\" Hello world from Elixir \""
    }

    %{my_file: file}
  end

  test "creates file", %{my_file: file} do
    my_file = FileManipulator.create(file)
    File.rm_rf!(file.directory)
    assert my_file == {:ok, :ok}
  end

  test "error when files exists", %{my_file: file} do
    FileManipulator.create(file)
    assert FileManipulator.create(file) == {:error, :eexist}
    File.rm_rf!(file.directory)
  end
end
