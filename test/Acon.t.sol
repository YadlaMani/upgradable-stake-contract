// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Acon.sol";

contract TestAconContract is Test {
    Acon token;

    function setUp() public {
    token= new Acon(address(this));
    }
    function testInitialSupply() public{
        assertEq(token.totalSupply(),0,"Initial supply should be zero");
    }
  
    function testMint() public{
       token.mint(address(this),1000);
       assertEq(token.balanceOf(address(this)),1000,"Minting failed");
       token.updateStakingContract(address(0xD9A6E167a149219155a1bc5480Bc9738CdDb48F7));
       vm.startPrank(address(0xD9A6E167a149219155a1bc5480Bc9738CdDb48F7));
       token.mint(address(this),1000);
       vm.stopPrank();
       assertEq(token.balanceOf(address(this)),2000,"Minting failed");
    }
    function testFailMint() public {
        vm.startPrank(address(0xD9A6E167a149219155a1bc5480Bc9738CdDb48F7));
        token.mint(address(this),1000);
        vm.stopPrank();
        assertEq(token.balanceOf(address(this)),0,"Minting should fail");
    }
}
