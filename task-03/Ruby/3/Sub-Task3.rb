def print_diamond(n)
    (0...n).each do |i|
      print ' ' * (n - i - 1)
      print '*' * (2 * i + 1)
      puts
    end
  
    (n - 2).downto(0) do |i|
      print ' ' * (n - i - 1)
      print '*' * (2 * i + 1)
      puts
    end
  end
  
  print 'Enter a number: '
  n = gets.to_i
  print_diamond(n)
  