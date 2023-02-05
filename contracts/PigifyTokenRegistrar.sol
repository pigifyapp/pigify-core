// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "./interfaces/IERC20Minimal.sol";

// Used to register ERC20 tokens so users can establish goals with them
contract PigifyTokenRegistrar {

    enum Token {
        PGY,
        USDT
    }

    struct TokenRegistrarEntry {
        IERC20Minimal token;
    }

    mapping(Token => TokenRegistrarEntry) public tokenRegistry;

    // Registers a token in the token registry, this is necessary
    // to let a token be saved in Pigify's smart contract
    function _registerToken(Token _token, address _tokenAddress) internal {
        tokenRegistry[_token].token = IERC20Minimal(_tokenAddress);
    }

}