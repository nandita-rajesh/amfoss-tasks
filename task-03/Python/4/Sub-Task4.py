def generate_diamond(n):
    lines = []
    for i in range(n):
        line = ' ' * (n - i - 1) + '*' * (2 * i + 1)
        lines.append(line)
    
    for i in range(n - 2, -1, -1):
        line = ' ' * (n - i - 1) + '*' * (2 * i + 1)
        lines.append(line)
    
    return '\n'.join(lines)

def main():
    with open('input.txt', 'r') as file:
        n = int(file.read().strip())
    
    diamond_pattern = generate_diamond(n)
    
    with open('output.txt', 'w') as file:
        file.write(diamond_pattern)

if __name__ == '__main__':
    main()
