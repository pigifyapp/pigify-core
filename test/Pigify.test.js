const assert = require("assert");
const ganache = require("ganache");
const { abi, bytecode } = require("../compile");


const Web3 = require("web3");

const web3 = new Web3(ganache.provider());

let accounts;
let contract;

beforeEach(async () => {
    // Get a list of all accounts
    accounts = await web3.eth.getAccounts();

    // Use an account to deploy contract
    contract = await new web3.eth.Contract(abi)
        .deploy({ data: bytecode })
        .send({ from: accounts[0], gas: "2000000" });
});

describe("Pigify", () => {
    it("Deploys a contract", () => {
        // Checks that address is assigned, if it isn't,
        // the contract hasn't been deployed
        assert.ok(contract.options.address);
    });

    it("Deployer has PGY tokens", async () => {
        // The deployer should have PGY tokens in their account
        const balance = await contract.methods.balanceOf(accounts[0]).call();
        assert(balance > 0);
    });

    it("Regular users don't have PGY tokens yet", async () => {
       // Regular users start with 0 PGY tokens
        const balance = await contract.methods.balanceOf(accounts[1]).call();
        assert.strictEqual(parseInt(balance), 1);
    });
});