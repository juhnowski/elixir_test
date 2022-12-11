defmodule FileManipulator do
  def append_to_file(my_file) do
    File.open("#{my_file.directory}/#{my_file.name}", [:read, :write], fn file ->
      IO.read(file, :line)
      IO.binwrite(file, my_file.content_to_append)
    end)
  end

  def create(file) do
    with :ok <- File.mkdir(file.directory),
         :ok <- File.write("#{file.directory}/#{file.name}", file.content) do
      append_to_file(file)
    else
      error ->
        error
    end
  end
end
