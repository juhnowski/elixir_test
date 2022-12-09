defmodule PasswordGeneratorTest do
  use ExUnit.Case

  setup do
    options = %{
      "length" => "10",
      "numbers" => "false",
      "uppercase" => "false",
      "symbols" => "false"
    }

    options_type = %{
      lowercase: Enum.map(?a..?z, &<<&1>>),
      numbers: Enum.map(0..9, &Integer.to_string(&1)),
      uppercase: Enum.map(?A..?Z, &<<&1>>),
      symbols: String.split("!#$%^&*()_+-=}{||;:@~^\|?<>", "", trim: true)
    }

    {:ok, result} = PasswordGenerator.generate(options)

    %{
      options_type: options_type,
      result: result
    }
  end

  test "returns a string", %{result: result} do
    assert is_bitstring(result)
  end

  test "returns error, when no lenhth is given" do
    options = %{"invalid" => "false"}

    assert({:error, _error} = PasswordGenerator.generate(options))
  end

  test "return error when length is not an integer" do
    options = %{"length" => "ab"}

    assert({:error, _error} = PasswordGenerator.generate(options))
  end

  test "length of returned string is the option provided" do
    length_option = %{"length" => "5"}
    {:ok, result} = PasswordGenerator.generate(length_option)

    assert 5 = String.length(result)
  end

  test "return a lowercase string just with the length", %{options_type: options} do
    length_option = %{"length" => "7"}
    {:ok, result} = PasswordGenerator.generate(length_option)

    assert String.contains?(result, options.lowercase)

    refute String.contains?(result, options.numbers)
    refute String.contains?(result, options.uppercase)
    refute String.contains?(result, options.symbols)
  end

  test "return uppercase string just with the length", %{options_type: options} do
    length_option = %{
      "length" => "7",
      "numbers" => "false",
      "uppercase" => "true",
      "symbols" => "false"
    }

    {:ok, result} = PasswordGenerator.generate(length_option)

    assert String.contains?(result, options.uppercase)

    refute String.contains?(result, options.numbers)
    refute String.contains?(result, options.symbols)
  end

  test "return numbers string just with the length", %{options_type: options} do
    length_option = %{
      "length" => "7",
      "numbers" => "true",
      "uppercase" => "false",
      "symbols" => "false"
    }

    {:ok, result} = PasswordGenerator.generate(length_option)

    assert String.contains?(result, options.numbers)

    refute String.contains?(result, options.uppercase)
    refute String.contains?(result, options.symbols)
  end

  test "return numbers uppercase string just with the length", %{options_type: options} do
    length_option = %{
      "length" => "7",
      "numbers" => "true",
      "uppercase" => "true",
      "symbols" => "false"
    }

    {:ok, result} = PasswordGenerator.generate(length_option)

    assert String.contains?(result, options.lowercase)
    refute String.contains?(result, options.symbols)
  end

  test "returns error when options values are not booleans" do
    options = %{
      "lengths" => "10",
      "numbers" => "invalid",
      "uppercase" => "0",
      "symbols" => "false"
    }

    assert {:error, _error} = PasswordGenerator.generate(options)
  end

  test "return error when options not allowed" do
    options = %{
      "length" => "5",
      "invalid" => "true"
    }

    assert {:error, _error} = PasswordGenerator.generate(options)
  end

  test "return error when 1 option not allowed" do
    options = %{"length" => "5", "numbers" => "true", "invalid" => "true"}

    assert {:error, _error} = PasswordGenerator.generate(options)
  end

  test "return symbols string just with the length", %{options_type: options} do
    length_option = %{
      "length" => "7",
      "numbers" => "false",
      "uppercase" => "false",
      "symbols" => "true"
    }

    {:ok, result} = PasswordGenerator.generate(length_option)

    assert String.contains?(result, options.symbols)

    refute String.contains?(result, options.numbers)
    refute String.contains?(result, options.uppercase)
  end

  test "return symbols numbers string just with the length", %{options_type: options} do
    length_option = %{
      "length" => "7",
      "numbers" => "true",
      "uppercase" => "false",
      "symbols" => "true"
    }

    {:ok, result} = PasswordGenerator.generate(length_option)

    assert String.contains?(result, options.symbols)

    refute String.contains?(result, options.uppercase)
  end

  test "return symbols uppercase string just with the length", %{options_type: options} do
    length_option = %{
      "length" => "7",
      "numbers" => "false",
      "uppercase" => "true",
      "symbols" => "true"
    }

    {:ok, result} = PasswordGenerator.generate(length_option)

    assert String.contains?(result, options.symbols)

    refute String.contains?(result, options.numbers)
  end

  test "return symbols numbers uppercase string just with the length", %{options_type: options} do
    length_option = %{
      "length" => "10",
      "numbers" => "true",
      "uppercase" => "true",
      "symbols" => "true"
    }

    {:ok, result} = PasswordGenerator.generate(length_option)

    assert String.contains?(result, options.symbols)
  end
end
