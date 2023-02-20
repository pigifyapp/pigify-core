// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "./PigifyTokenPool.sol";
import "./PigifyNativeToken.sol";

contract Pigify is PigifyTokenPool, PigifyNativeToken {

    constructor() {
        _registerToken(Token.PGY, address(this));
        _registerToken(Token.USDT, 0xeC357C27a26E94955eb415633404495044Ba7fcd);
        _registerToken(Token.USDC, 0x466595626333c55fa7d7Ad6265D46bA5fDbBDd99);
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

    // Publicly accessible method to establish goal
    // of a specific address in PGY
    function establishGoalPGY(uint256 goal) public {
        _establishGoal(Token.PGY, goal);
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
    // of a specific address in USDT
    function balanceUSDT(address target) public view returns(uint256) {
        return _readBalance(Token.USDT, target);
    }

    // Publicly accessible method to read the goal
    // of a specific address in USDT
    function goalUSDT(address target) public view returns(uint256) {
        return _readGoal(Token.USDT, target);
    }

    // Publicly accessible method to establish goal
    // of a specific address in USDT
    function establishGoalUSDT(uint256 goal) public {
        _establishGoal(Token.USDT, goal);
    }

    // Publicly accesible method to deposit USDC
    // requires a previous allowance so the smart
    // contract can take the tokens
    function depositUSDC(uint256 amount) public {
        _depositToken(Token.USDC, amount);
    }

    // Publicly accessible method to withdraw USDT
    // the sender must have completed their goal
    // to withdraw their tokens. If successful
    // this method will withdraw ALL their tokens
    function withdrawUSDC() public {
        _withdrawToken(Token.USDC);
    }

    // Publicly accessible method to read the balance
    // of a specific address in USDC
    function balanceUSDC(address target) public view returns(uint256) {
        return _readBalance(Token.USDC, target);
    }

    // Publicly accessible method to read the goal
    // of a specific address in USDC
    function goalUSDC(address target) public view returns(uint256) {
        return _readGoal(Token.USDC, target);
    }

    // Publicly accessible method to establish goal
    // of a specific address in USDC
    function establishGoalUSDC(uint256 goal) public {
        _establishGoal(Token.USDC, goal);
    }

}