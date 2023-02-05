// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PigifyNativeToken is ERC20 {

    constructor() ERC20("Pigify", "PGY") {
        _mint(msg.sender, 2000000000 * 10 ** decimals());
    }

}