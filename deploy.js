const HDWalletProvider = require("@truffle/hdwallet-provider");
const Web3 = require("web3");
const fs = require("fs")

const { abi, bytecode } = require("./compile");
const path = require("path");

const provider = new HDWalletProvider(
    process.env.ETH_MNEMONIC,
    process.env.ETH_PROVIDER
);
const web3 = new Web3(provider);

const deploy = async () => {
    console.log("Obtaining available accounts");
    const accounts = await web3.eth.getAccounts();
    console.log("Successfully obtained " + accounts.length + " accounts");

    console.log("Reading account balance before starting...");
    const balance = await web3.eth.getBalance(accounts[0]);
    console.log("Your balance is " + balance +  " wei");

    console.log("Attempting to deploy from account", accounts[0]);

    const result = await new web3.eth.Contract(abi)
        .deploy({ data: bytecode, arguments: []})
        .send({ gas: "10000000", from: accounts[0] });

    console.log("Storing contract ABI in abi.json");

    fs.writeFileSync(
        path.resolve(__dirname, "abi.json"),
        JSON.stringify(abi)
    );

    console.log("Successfully saved ABI");


    console.log("Contract deployed to ", result.options.address);

    provider.engine.stop();
}

console.log("Starting deployment...");
deploy();