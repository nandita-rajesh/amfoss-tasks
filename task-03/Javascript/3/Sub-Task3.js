function printDiamond(n) {
    for (let i = 0; i < n; i++) {
        let spaces = ' '.repeat(n - i - 1);
        let stars = '*'.repeat(2 * i + 1);
        console.log(spaces + stars);
    }

    for (let i = n - 2; i >= 0; i--) {
        let spaces = ' '.repeat(n - i - 1);
        let stars = '*'.repeat(2 * i + 1);
        console.log(spaces + stars);
    }
}

const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question('Enter a number: ', (input) => {
    const n = parseInt(input, 10);
    if (isNaN(n) || n <= 0) {
        console.log('Please enter a valid positive number.');
    } else {
        printDiamond(n);
    }
    rl.close();
});
