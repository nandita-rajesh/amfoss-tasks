defmodule DiamondPattern do
  def generate_diamond(n) do
    upper_part = for i <- 0..(n-1) do
      spaces = String.duplicate(" ", n - i - 1)
      stars = String.duplicate("*", 2 * i + 1)
      spaces <> stars
    end

    lower_part = for i <- (n-2)..0 do
      spaces = String.duplicate(" ", n - i - 1)
      stars = String.duplicate("*", 2 * i + 1)
      spaces <> stars
    end

    Enum.join(upper_part ++ lower_part, "\n")
  end

  def main do
    case File.read("input.txt") do
      {:ok, content} ->
        n = String.trim(content) |> String.to_integer()

        diamond_pattern = generate_diamond(n)

        File.write!("output.txt", diamond_pattern)

        IO.puts("Pattern printed to output.txt")

      {:error, reason} ->
        IO.puts("Error reading input file: #{reason}")
    end
  end
end

DiamondPattern.main()
