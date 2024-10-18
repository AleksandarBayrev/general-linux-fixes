const path = require('path');

const isProduction = process.env.NODE_ENV == 'production';


const config = {
    entry: './src/index.js',
    target: 'node',
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'flatpak-install-script.js'
    },
    plugins: [
    ],
    module: {
        rules: [
        ],
    },
    resolve: {
        extensions: ['.js']
    }
};

module.exports = () => {
    if (isProduction) {
        config.mode = 'production';


    } else {
        config.mode = 'development';
    }
    return config;
};
