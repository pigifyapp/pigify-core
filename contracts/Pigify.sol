// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Pigify is ERC20 {

    struct SavingAccount {
        uint256 balance;
        uint256 goal;
    }

    mapping(address => SavingAccount) public savings;

    constructor() ERC20("Pigify", "PGF") {
        _mint(msg.sender, 2000000000 * 10 ** decimals());
    }

    // Checks that the balance on the savings account is greater than the goal
    modifier goalCompleted {
        require(savings[msg.sender].balance >= savings[msg.sender].goal, "You haven't met your goal.");
        _;
    }

    // Goals cannot be deleted until they are accomplished.
    function setGoal(uint256 _goal) public goalCompleted {
        savings[msg.sender].goal = _goal;
    }

    // Facilitates the transfer of a user's funds from their wallet to a savings account.
    function depositToSavingsAccount(uint256 _amount) public {
        _transfer(msg.sender, address(this), _amount);
        savings[msg.sender].balance += _amount;
    }

    // Withdraws all the money from the user saving account
    // The transaction will be reverted if the user hasn't completed its goal
    function withdrawFromSavingsAccount() public goalCompleted {
        uint256 _totalSavings = savings[msg.sender].balance;
        savings[msg.sender].balance = 0;
        savings[msg.sender].goal = 0;
        _transfer(address(this), msg.sender, _totalSavings);
    }

}