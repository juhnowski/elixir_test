defmodule FileValidator do
  @extension_whitelist ~w(.jpg .jpeg .gif .png .pdf)

  def valid?(file) do
    file_extension = get_ext(file)

    @extension_whitelist
    |> Enum.member?(file_extension)
  end

  defp get_ext(file) do
    file
    |> Path.extname()
    |> String.downcase()
  end
end
