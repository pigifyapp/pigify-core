// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "./PigifyTokenPool.sol";
import "./PigifyNativeToken.sol";

contract Pigify is PigifyTokenPool, PigifyNativeToken {

    address public taxCollector;

    constructor() {
        taxCollector = msg.sender;

        _registerToken(Token.PGY, address(this), 0);

        _registerToken(Token.USDT, address(0x5AB6F31B29Fc2021436B3Be57dE83Ead3286fdc7), 1 * 10 ** 18);
        _registerToken(Token.USDC, address(0x466595626333c55fa7d7Ad6265D46bA5fDbBDd99), 1 * 10 ** 18);
    }

    modifier onlyCollector {
        require(msg.sender == taxCollector, "Only the collector can call this method");
        _;
    }

    function withdrawFeesCollected(Token token) public onlyCollector {
        require(feesCollected[token] > 0, "The fees collected on the token can't be 0");
        uint256 transferAmount = feesCollected[token];
        feesCollected[token] = 0;
        tokenRegistry[token].token.transfer(taxCollector, transferAmount);
    }

}