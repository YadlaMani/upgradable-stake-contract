// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/StakeContract.sol";

contract TestStakeContract is Test {
    StakeContract stake;

    function setUp() public {
        stake = new StakeContract();
    }
    function testStake() public {
        
        stake.stake{value:1000}(1000);
        assertEq(stake.getStakeAmount(), 1000, "Staking failed");
    }
    function testUnstake() public{
      
        stake.stake{value:1000}(1000);
        stake.unstake(500);
        assertEq(stake.getStakeAmount(), 500, "Unstaking failed");
    }


   
}
