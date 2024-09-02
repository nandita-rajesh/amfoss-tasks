const fs = require('fs');

function generateDiamond(n) {
    let lines = [];

    for (let i = 0; i < n; i++) {
        let spaces = ' '.repeat(n - i - 1);
        let stars = '*'.repeat(2 * i + 1);
        lines.push(spaces + stars);
    }

    for (let i = n - 2; i >= 0; i--) {
        let spaces = ' '.repeat(n - i - 1);
        let stars = '*'.repeat(2 * i + 1);
        lines.push(spaces + stars);
    }

    return lines.join('\n');
}

function main() {
    fs.readFile('input.txt', 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading input file:', err);
            return;
        }
        
        let n = parseInt(data.trim(), 10);
        if (isNaN(n)) {
            console.error('Invalid number format in input file.');
            return;
        }

        let diamondPattern = generateDiamond(n);

        fs.writeFile('output.txt', diamondPattern, (err) => {
            if (err) {
                console.error('Error writing to output file:', err);
                return;
            }
            console.log('Pattern printed in output.txt');
        });
    });
}

main();
