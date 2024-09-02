defmodule Diamond do
  def main do
    IO.write("Enter a number: ")
    n = IO.gets("") |> String.trim() |> String.to_integer()
    print_diamond(n)
  end

  defp print_diamond(n) do
    for i <- 0..(n-1) do
      IO.write(String.duplicate(" ", n - i - 1))
      IO.write(String.duplicate("*", 2 * i + 1))
      IO.puts("")
    end

    for i <- (n-2)..0 do
      IO.write(String.duplicate(" ", n - i - 1))
      IO.write(String.duplicate("*", 2 * i + 1))
      IO.puts("")
    end
  end
end

Diamond.main()
