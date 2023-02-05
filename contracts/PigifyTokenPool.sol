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
    // is greather than the goal
    modifier goal(Token _token) {
        require(
            savings[_token][msg.sender].balance >= savings[_token][msg.sender].goal,
            "You haven't met your goal yet."
        );
        _;
    }

    // Checks that the smart contract is allowed to take tokens
    // from the desired address.
    modifier checkAllowance(Token _token, uint amount) {
        require(tokenRegistry[_token].token.allowance(msg.sender, address(this)) >= amount, "Not enough allowance");
        _;
    }

    // Establishes a goal on a specific token, once a goal is set
    // the sender won't be able to withdraw their tokens until
    // the amount of deposited tokens is greather than the goal
    function _establishGoal(Token _token, uint256 _goal) internal goal(_token) {
        savings[_token][msg.sender].goal = _goal;
    }

    // Tries to deposit an amount of tokens from the user to
    // the smart contract balance.
    function _depositToken(Token _token, uint256 _amount) internal checkAllowance(_token, _amount) {
        require(
            tokenRegistry[_token].token.transferFrom(msg.sender, address(this), _amount),
            "Failed to deposit token"
        );

        savings[_token][msg.sender].balance += _amount;
    }

    // Tries to withdraw all the tokens saved by an user from
    // the smart contract to their personal wallet. 
    // If the user hasn't completed his goal they won't be able
    // to withdraw the tokens.
    function _withdrawToken(Token _token) internal goal(_token) {
        uint256 _totalSavings = savings[_token][msg.sender].balance;
        savings[_token][msg.sender].balance = 0;
        savings[_token][msg.sender].goal = 0;
        tokenRegistry[_token].token.transferFrom(address(this), msg.sender, _totalSavings);
    }

}