// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// import { console } from "forge-std/Console.sol"; // for console.log


contract MyToken is ERC20 {
    address owner;
    constructor() ERC20("YASH", "YGT") {
        // _mint(msg.sender, _value);
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Only owner can mint");
        _mint(to, amount);
    }

}
