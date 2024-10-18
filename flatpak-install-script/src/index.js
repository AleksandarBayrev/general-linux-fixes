const path = require("node:path");
const fs = require("fs");
const { spawn } = require("node:child_process");

const pathToRead = path.join(__dirname, "flatpaks.txt");
const spawnProcessAsync = (pathToRead) => new Promise((resolve, reject) => {
    if (!fs.existsSync(pathToRead)) {
        reject(`Path ${pathToRead} not found!`);
    }
    const spawnedProcess = spawn(`cat`, [pathToRead, `| xargs flatpak install`]);
    spawnedProcess.on("message", (message) => {
        console.log(message);
    });
    spawnedProcess.on("error", (err) => {
        reject(err);
    });
    spawnedProcess.on("exit", () => {
        console.log("Finished");
        resolve();
    });
});
(async () => {
    try {
        await spawnProcessAsync(pathToRead);
    } catch (err) {
        console.log(err);
    }
})();