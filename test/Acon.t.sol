// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Acon.sol";

contract TestContract is Test {
    Acon token;

    function setUp() public {
    token= new Acon();
    }

    function testBar() public {
        assertEq(uint256(1), uint256(1), "ok");
    }

    function testFoo(uint256 x) public {
        vm.assume(x < type(uint128).max);
        assertEq(x + x, x * 2);
    }
    function testMint() public{
        vm.startPrank(address(0x1111111111111111111111111111111111111111));
        token.mint(address(this),1000);
        assertEq(token.balanceOf(address(this)),1000,"Minting failed");
        vm.stopPrank();
    }
}
