// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "./PigifyTokenPool.sol";
import "./PigifyNativeToken.sol";

contract Pigify is PigifyTokenPool, PigifyNativeToken {

    constructor() {
        _registerToken(Token.PGY, address(this));
        _registerToken(Token.USDT, 0xdAC17F958D2ee523a2206206994597C13D831ec7);
    }

    // Publicly accesible method to deposit PGY
    // requires a previous allowance so the smart
    // contract can take the tokens
    function depositPGY(uint256 amount) public {
        _depositToken(Token.PGY, amount);
    }

    // Publicly accessible method to withdraw PGY
    // the sender must have completed their goal
    // to withdraw their tokens. If successful
    // this method will withdraw ALL their tokens
    function withdrawPGY() public {
        _withdrawToken(Token.PGY);
    }

    // Publicly accessible method to read the balance
    // of a specific address in PGY
    function balancePGY(address target) public view returns(uint256) {
        return _readBalance(Token.PGY, target);
    }

    // Publicly accessible method to read the goal
    // of a specific address in PGY
    function goalPGY(address target) public view returns(uint256) {
        return _readGoal(Token.PGY, target);
    }

    // Publicly accesible method to deposit USDT
    // requires a previous allowance so the smart
    // contract can take the tokens
    function depositUSDT(uint256 amount) public {
        _depositToken(Token.USDT, amount);
    }

    // Publicly accessible method to withdraw USDT
    // the sender must have completed their goal
    // to withdraw their tokens. If successful
    // this method will withdraw ALL their tokens
    function withdrawUSDT() public {
        _withdrawToken(Token.USDT);
    }

    // Publicly accessible method to read the balance
    // of a specific address in PGY
    function balanceUSDT(address target) public view returns(uint256) {
        return _readBalance(Token.USDT, target);
    }

    // Publicly accessible method to read the goal
    // of a specific address in PGY
    function goalUSDT(address target) public view returns(uint256) {
        return _readGoal(Token.USDT, target);
    }

}