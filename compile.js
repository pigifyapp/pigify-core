const path = require("path");
const fs = require("fs");
const solc = require("solc");

const contractPath = path.resolve(__dirname, "contracts", "Pigify.sol");
const source = fs.readFileSync(contractPath, "utf8");

const input = {
    language: "Solidity",
    sources: {
        "Pigify.sol": {
            content: source
        }
    },
    settings: {
        outputSelection: {
            "*": {
                "*": ["*"]
            }
        }
    }
};

const compilation = JSON.parse(solc.compile(JSON.stringify(input)));
const compilationObject = compilation.contracts["Pigify.sol"].Pigify;

const output = {};

output.abi = compilationObject.abi;
output.bytecode = compilationObject.evm.bytecode.object;

module.exports = output;