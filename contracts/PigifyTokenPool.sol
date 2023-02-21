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
    // the amount of deposited tokens is greater than the goal
    function establishGoal(Token token, uint256 goal) public checkGoalCompletion(token) {
        savings[token][msg.sender].goal = goal;
    }

    // Returns the goal of an address in a specific token
    function readGoal(Token token, address target) public view returns(uint256) {
        return savings[token][target].goal;
    }

    // Returns the balance of an address in a specific token
    function readBalance(Token token, address target) public view returns(uint256) {
        return savings[token][target].balance;
    }

    // Tries to deposit an amount of tokens from the user to
    // the smart contract balance.
    function depositToken(Token token, uint256 amount) public {
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
    function withdrawToken(Token token) public checkGoalCompletion(token) {
        uint256 totalSavings = savings[token][msg.sender].balance;
        savings[token][msg.sender].balance = 0;
        savings[token][msg.sender].goal = 0;
        tokenRegistry[token].token.transfer(msg.sender, totalSavings);
    }

}