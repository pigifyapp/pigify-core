const path = require("path");
const fs = require("fs");
const solc = require("solc");

const contractPath = path.resolve(__dirname, "contracts");

const input = {
    language: "Solidity",
    sources: {
        "@openzeppelin/contracts/token/ERC20/IERC20.sol": {
            content: fs.readFileSync(
              path.resolve(__dirname, "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol"),
              "utf8"
            )
        },
        "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol": {
            content: fs.readFileSync(
              path.resolve(__dirname, "node_modules/@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol"),
              "utf8"
            )
        },
        "@openzeppelin/contracts/utils/Context.sol": {
            content: fs.readFileSync(
              path.resolve(__dirname, "node_modules/@openzeppelin/contracts/utils/Context.sol"),
              "utf8"
            )
        },
        "@openzeppelin/contracts/token/ERC20/ERC20.sol": {
            content: fs.readFileSync(
              path.resolve(__dirname, "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol"),
              "utf8"
            )
        },
        "interfaces/IERC20Minimal.sol": {
            content: fs.readFileSync(
              path.resolve(contractPath, "interfaces", "IERC20Minimal.sol"),
              "utf8"
            )
        },
        "PigifyTokenRegistrar.sol": {
            content: fs.readFileSync(
              path.resolve(contractPath, "PigifyTokenRegistrar.sol"),
              "utf8"
            )
        },
        "PigifyTokenPool.sol": {
            content: fs.readFileSync(
              path.resolve(contractPath, "PigifyTokenPool.sol"),
              "utf8"
            )
        },
        "PigifyNativeToken.sol": {
            content: fs.readFileSync(
              path.resolve(contractPath, "PigifyNativeToken.sol"),
              "utf8"
            )
        },
        "Pigify.sol": {
            content: fs.readFileSync(
              path.resolve(contractPath, "Pigify.sol"),
              "utf8"
            )
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