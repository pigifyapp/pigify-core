// SPDX-License-Identifier: GPLv3
pragma solidity ^0.8.9;

import "./interfaces/IERC20Minimal.sol";

contract PigifyPresaleManager {

    enum Token {
        PGY,
        USDT,
        USDC,
        BUSD
    }

    address public contractDeployer;

    mapping(Token => IERC20Minimal) public tokenContracts;

    uint256 public balancePGY;
    uint256 public minimumBuyAmount;
    uint256 public maximumBuyAmount;

    constructor() {
        contractDeployer = msg.sender;

        minimumBuyAmount = 50 * 10 ** 18;
        maximumBuyAmount = 400_000 * 10 ** 18;

        tokenContracts[Token.PGY] = IERC20Minimal(address(0xA7aea9E0605C1Ce37aC049D60363A8209F9F040C));

        tokenContracts[Token.USDT] = IERC20Minimal(address(0x55d398326f99059fF775485246999027B3197955));
        tokenContracts[Token.USDC] = IERC20Minimal(address(0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d));
        tokenContracts[Token.BUSD] = IERC20Minimal(address(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56));
    }

    modifier onlyContractDeployer {
        require(msg.sender == contractDeployer, "You need to be the contract deployer to deposit");
        _;
    }

    function _buy(Token token, uint256 amountUSD) internal {
        require(amountUSD > minimumDeposit, "You need to pay more than the minimum buy amount");
        require(amountUSD < maximumDeposit, "You need to pay less than the maximum buy amount");

        require(balancePGY > amountUSD * 10 / 4, "There isn't enough PGY to pay you uwu");

        require(
            tokenContracts[Token.USDT].transferFrom(msg.sender, address(this), amountUSD * 10 ** 18),
            "The deposit to buy PGY failed"
        );
    }

    function depositPGY(uint256 amount) public onlyContractDeployer {
        require(
            tokenContracts[Token.PGY].transferFrom(msg.sender, address(this), amount),
            "You need to allow the transaction and have enough balance"
        );

        balancePGY += amount;
    }

    function withdrawSales() public onlyContractDeployer {
        withdraw(Token.USDC, msg.sender);
        withdraw(Token.USDT, msg.sender);
        withdraw(Token.BUSD, msg.sender);
    }

    function withdraw(Token token, address receiver) public onlyContractDeployer {
        require(tokenContracts[token].transfer(receiver, tokenContracts[token].balanceOf(address(this))));
    }

    function buyWithUSDT(uint256 amountUSDT) public {
        _buy(Token.USDT, amountUSDT);
    }

    function buyWithUSDC(uint256 amountUSDC) public {
        _buy(Token.USDC, amountUSDC);
    }

    function buyWithBUSD(uint256 amountBUSD) public {
        _buy(Token.BUSD, amountBUSD);
    }

}