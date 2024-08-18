//SPDX-License-Identifer: MIT

pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20 } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/*
* @title DecentralizedStableCoin
* @author Georgia
* Collateral: Exogenous (ETH & BTC)
* Relative Stability: Pegged to USD
*
* This is the contract meant to be governed by DSCEngine. This contract is just the ERC20 implementation of our stablecoin system.
*
*/

contract DecentralizedStableCoin is ERC20Burnable, Ownable {

    error DecentraclizedStableCoin__MustBeMoreThanZero();
    error DecentraclizedStableCoin__BurnAmountExceedsBalance();
    error DecentraclizedStableCoin__NotZeroAddress();

    constructor(address initialOwner) ERC20("DecentraclizedStableCoin", "DSC") Ownable(initialOwner){}

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if(_amount <= 0 ) {
            revert DecentraclizedStableCoin__MustBeMoreThanZero();
        }
        if (balance < _amount) {
            revert DecentraclizedStableCoin__BurnAmountExceedsBalance();
        }
        super.burn(_amount); //go to super class and use the burn function (this will be in the erc20burnable contract)
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool){
        if(_to == address(0)) {
            revert DecentraclizedStableCoin__NotZeroAddress();
        }
        if (_amount <= 0) {
            revert DecentraclizedStableCoin__MustBeMoreThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}
