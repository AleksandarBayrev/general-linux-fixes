const fs = require('fs');
const fileName = '/usr/bin/nvidia-sleep.sh';

const getMessage = (reverting, fileName) => {
    return reverting ? `Reverting patch of file ${fileName}...` : `Patching file ${fileName}...`;
}

const getFileContent = (isReverting, updatedFileContent) => {
    if (isReverting) {
        const index = updatedFileContent.findIndex(x => x === "exit 0");
        if (index !== -1) {
            updatedFileContent[index] = '';
        }
    }
    return updatedFileContent.join('\n').toString();
}

try {
    const fileContent = fs.readFileSync(fileName).toString().split('\n');
    const isReverting = process.argv[2] && process.argv[2].indexOf('--revert') !== -1;
    const updatedFileContent = [
        fileContent[0],
        'exit 0',
        fileContent.slice(2).join('\n')
    ];

    console.log(getMessage(isReverting, fileName));
    fs.writeFileSync(fileName, getFileContent(isReverting, updatedFileContent));
} catch (error) {
    console.error(`Failed patching ${fileName}, reason: ${JSON.stringify(error)}`)
}