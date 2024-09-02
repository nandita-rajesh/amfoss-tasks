use std::fs;
use std::io::Write;

fn generate_diamond(n: usize) -> String {
    let mut lines = Vec::new();

    for i in 0..n {
        let spaces = " ".repeat(n - i - 1);
        let stars = "*".repeat(2 * i + 1);
        lines.push(format!("{}{}", spaces, stars));
    }

    for i in (0..n-1).rev() {
        let spaces = " ".repeat(n - i - 1);
        let stars = "*".repeat(2 * i + 1);
        lines.push(format!("{}{}", spaces, stars));
    }

    lines.join("\n")
}

fn main() -> std::io::Result<()> {
    let content = fs::read_to_string("input.txt")?;
    let n: usize = content.trim().parse().expect("Invalid number format");

    let diamond_pattern = generate_diamond(n);

    let mut file = fs::File::create("output.txt")?;
    file.write_all(diamond_pattern.as_bytes())?;

    Ok(())
}
