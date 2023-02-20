// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "./PigifyTokenPool.sol";
import "./PigifyNativeToken.sol";

contract Pigify is PigifyTokenPool, PigifyNativeToken {

    constructor() {
        _registerToken(Token.PGY, address(this));
        _registerToken(Token.USDT, address(0x5AB6F31B29Fc2021436B3Be57dE83Ead3286fdc7));
        _registerToken(Token.USDC, address(0x466595626333c55fa7d7Ad6265D46bA5fDbBDd99));
    }

}