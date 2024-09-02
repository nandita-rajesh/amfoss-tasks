const fs = require('fs');

function readAndWriteFile(inputFile, outputFile) {
    fs.readFile(inputFile, 'utf8', (err, data) => {
        if (err) {
            console.error(`Error reading file ${inputFile}:`, err);
            return;
        }
        fs.writeFile(outputFile, data, (err) => {
            if (err) {
                console.error(`Error writing file ${outputFile}:`, err);
                return;
            }
            console.log(`Content successfully copied from ${inputFile} to ${outputFile}.`);
        });
    });
}

readAndWriteFile('input.txt', 'output.txt');