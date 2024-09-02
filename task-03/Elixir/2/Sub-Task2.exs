defmodule FileCopy do
  def read_and_write_file(input_file, output_file) do
    case File.read(input_file) do
      {:ok, content} ->
        case File.write(output_file, content) do
          :ok ->
            IO.puts("Content successfully copied from #{input_file} to #{output_file}.")
          {:error, reason} ->
            IO.puts("Error writing file #{output_file}: #{reason}")
        end
      {:error, reason} ->
        IO.puts("Error reading file #{input_file}: #{reason}")
    end
  end
end

FileCopy.read_and_write_file("input.txt", "output.txt")
