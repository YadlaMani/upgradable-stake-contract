// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/StakeContract.sol";
import "src/Acon.sol";

contract TestStakeContract is Test {
    StakeContract stake;
    Acon aconToken;

    function setUp() public {
        aconToken=new Acon(address(this));
        stake =new StakeContract(address(aconToken));
        aconToken.updateStakingContract(address(stake));

    }
    function testStake() public {
        
        stake.stake{value:1000}(1000);
        assertEq(stake.getStakeAmount(address(this)), 1000, "Staking failed");
    }
    function testUnstake() public{
      
       uint256 stakeAmount = 1 ether;
        uint256 unstakeAmount = 0.5 ether;
        
       
        stake.stake{value: stakeAmount}(stakeAmount);
        
       
        uint256 initialBalance = address(this).balance;
        
       
        stake.unstake(unstakeAmount);
        
        
        assertEq(stake.getStakeAmount(address(this)), stakeAmount - unstakeAmount, "Unstaking failed");
        assertEq(address(stake).balance, stakeAmount - unstakeAmount, "Contract balance incorrect after unstake");
        assertEq(address(this).balance, initialBalance + unstakeAmount, "Ether not returned correctly");
    }
    function testFailUnstake()public{
        stake.stake{value:100}(100);
        stake.unstake(200);
    }
     receive() external payable {}


   
}
