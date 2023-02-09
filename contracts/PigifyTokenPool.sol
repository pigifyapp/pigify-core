// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "./PigifyTokenRegistrar.sol";

contract PigifyTokenPool is PigifyTokenRegistrar {

    struct Savings {
        uint256 balance;
        uint256 goal;
    }

    mapping(Token => mapping(address => Savings)) public savings;

    // Checks that the sender's balance on a specific token
    // is greater than the goal
    modifier checkGoalCompletion(Token token) {
        require(
            savings[token][msg.sender].balance >= savings[token][msg.sender].goal,
            "You haven't met your goal yet."
        );
        _;
    }

    // Checks that the smart contract is allowed to take tokens
    // from the desired address.
    modifier checkAllowance(Token token, uint256 amount) {
        require(tokenRegistry[token].token.allowance(msg.sender, address(this)) >= amount, "Not enough allowance");
        _;
    }

    // Establishes a goal on a specific token, once a goal is set
    // the sender won't be able to withdraw their tokens until
    // the amount of deposited tokens is greather than the goal
    function _establishGoal(Token token, uint256 goal) internal checkGoalCompletion(token) {
        savings[token][msg.sender].goal = goal;
    }

    // Tries to deposit an amount of tokens from the user to
    // the smart contract balance.
    function _depositToken(Token token, uint256 amount) internal checkAllowance(token, amount) {
        require(
            tokenRegistry[token].token.transferFrom(msg.sender, address(this), amount),
            "Failed to deposit token"
        );

        savings[token][msg.sender].balance += amount;
    }

    // Tries to withdraw all the tokens saved by an user from
    // the smart contract to their personal wallet. 
    // If the user hasn't completed his goal they won't be able
    // to withdraw the tokens.
    function _withdrawToken(Token token) internal checkGoalCompletion(token) {
        uint256 totalSavings = savings[token][msg.sender].balance;
        savings[token][msg.sender].balance = 0;
        savings[token][msg.sender].goal = 0;
        tokenRegistry[token].token.transferFrom(address(this), msg.sender, totalSavings);
    }

}