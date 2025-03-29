// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Contract {
    mapping(address=>uint256) stakes;
    uint public totalStakes;
    constructor(){

    }
    function stake(uint _amount)public payable{
        require(_amount>0, "Amount must be greater than 0");
        require(msg.value == _amount, "Amount must be equal to msg.value");
        stakes[msg.sender]+=_amount;
        totalStakes+=_amount;
    }
    function unstake(uint _amount)public payable{
        require(_amount>0," Amount must be greater than 0");
        require(stakes[msg.sender]>=_amount,"Not enough stakes");
        require(address(this).balance>=_amount,"Not enough balance in contract");
        payable(msg.sender).transfer(_amount);
        totalStakes-=_amount;
        stakes[msg.sender]-=_amount;
    }
    function claimReward() public payable{

    }
    function getRewards() public view returns(uint256){
        return stakes[msg.sender];

    }
 }
