def generate_diamond(n)
    lines = []
  
    (0...n).each do |i|
      spaces = ' ' * (n - i - 1)
      stars = '*' * (2 * i + 1)
      lines << "#{spaces}#{stars}"
    end
  
    (n - 2).downto(0) do |i|
      spaces = ' ' * (n - i - 1)
      stars = '*' * (2 * i + 1)
      lines << "#{spaces}#{stars}"
    end
  
    lines.join("\n")
  end
  
  def main
    n = File.read('input.txt').to_i
  
    diamond_pattern = generate_diamond(n)
  
    File.write('output.txt', diamond_pattern)
  end
  
  main
  