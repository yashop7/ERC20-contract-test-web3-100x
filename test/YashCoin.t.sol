// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/YashCoin.sol";

contract TestContract is Test {
    MyToken c;

    function setUp() public {
        c = new MyToken();
    }

    function testSimple() public {
        assertEq(c.name(), "YASH");
        assertEq(c.symbol(), "YGT");
        assertEq(c.totalSupply(), 0);
    }

    function testBar() public {
        assertEq(uint256(1), uint256(1), "ok");
    }

    function testFoo(uint256 x) public {
        vm.assume(x < type(uint128).max);
        assertEq(x + x, x * 2);
    }

    function testMint() public {
        c.mint(address(this), 400);
        assertEq(c.balanceOf(address(this)), 400,"person has 400 Yash Coins");
        assertEq(c.totalSupply(), 400,"Total supply should be 400 Yash Coins" );
    }

    function testTranser() public {
        c.mint(address(this),400);
        c.transfer(address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), 200);
        assertEq(c.balanceOf(address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)), 200,"person has 200 Yash Coins");
        assertEq(c.balanceOf(address(this)), 200,"person has 200 Yash Coins");

        vm.prank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        c.transfer(address(this), 50);

        assertEq(c.balanceOf(address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)), 150,"person has 150 Yash Coins");
        assertEq(c.balanceOf(address(this)), 250,"person has 250 Yash Coins");
    }
    function testApproval() public {
        c.mint(address(this),400);
        c.approve(address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), 300);

        vm.prank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        c.transferFrom(address(this),address(0x617F2E2fD72FD9D5503197092aC168c91465E7f2), 100);
        assertEq(c.balanceOf(address(this)),300,"Sombody spent 100 Yash Coins from me");
        assertEq(c.balanceOf(address(0x617F2E2fD72FD9D5503197092aC168c91465E7f2)),100,"Somebody got 100 Yash Coins");
        assertEq(c.allowance(address(this),address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)),200,"I have 200 Yash Coins allowance left for 0x5B" );
    }
    function test_Revert_Approvals() public {
        c.mint(address(this),400);
        c.approve(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 300);

        vm.expectRevert();
        vm.prank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        c.transferFrom(address(this),0x617F2E2fD72FD9D5503197092aC168c91465E7f2, 400);
    }
}