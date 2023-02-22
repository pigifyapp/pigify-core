// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "./interfaces/IERC20Minimal.sol";

// Used to register ERC20 tokens so users can establish goals with them
contract PigifyTokenRegistrar {

    enum Token {
        PGY,
        USDT,
        USDC
    }

    struct TokenRegistrarEntry {
        IERC20Minimal token;
        uint256 depositFee;
    }

    mapping(Token => TokenRegistrarEntry) public tokenRegistry;

    function getTokenDepositFee(Token token) public view returns(uint256) {
        return tokenRegistry[token].depositFee;
    }

    // Registers a token in the token registry, this is necessary
    // to let a token be saved in Pigify's smart contract
    function _registerToken(Token token, address tokenAddress, uint256 depositFee) internal {
        tokenRegistry[token].token = IERC20Minimal(tokenAddress);
        tokenRegistry[token].depositFee = depositFee;
    }

}