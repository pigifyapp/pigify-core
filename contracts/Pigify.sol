// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "./PigifyTokenPool.sol";
import "./PigifyNativeToken.sol";

contract Pigify is PigifyTokenPool, PigifyNativeToken {

    address public taxCollector;

    constructor() {
        taxCollector = msg.sender;

        _registerToken(Token.PGY, address(this), 0);
        _registerToken(Token.USDT, address(0x55d398326f99059fF775485246999027B3197955), 1 * 10 ** 18);
        _registerToken(Token.USDC, address(0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d), 1 * 10 ** 18);
        _registerToken(Token.BUSD, address(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56), 1 * 10 ** 18);
        _registerToken(Token.USDD, address(0xd17479997F34dd9156Deef8F95A52D81D265be9c), 1 * 10 ** 18);
        _registerToken(Token.DAI, address(0x1AF3F329e8BE154074D8769D1FFa4eE058B1DBc3), 1 * 10 ** 18);
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