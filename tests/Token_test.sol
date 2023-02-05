// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol";
import "../contracts/MyToken.sol";

contract MyTokenTest {

    MyToken s;
    function beforeAll() public {
        s = new MyToken();
    }

    function testTokenNameAndSymbol() public {
        Assert.equal(s.name(), "Pigify", "token name did not match");
        Assert.equal(s.symbol(), "PGY", "token symbol did not match");
    }
}