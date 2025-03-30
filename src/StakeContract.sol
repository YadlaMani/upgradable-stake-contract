// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
interface Acon {
    function mint(address to, uint256 amount) external;
}

contract StakeContract {
  mapping(address=>UserInfo)public users;
    Acon public aconToken;
    uint public totalStakes;
     uint256 private constant REWARD_RATE = 20;
     struct UserInfo{
        uint256 stakeAmount;
        uint256 unClaimedRewards;
        uint256 lastClaimed;
     }
    constructor(Acon _aconToken) {
        aconToken = _aconToken;

    }
   function stake() public payable {
    require(msg.value > 0, "Amount must be greater than 0");
    if(users[msg.sender].unClaimedRewards>0){
        _updateRewards(msg.sender);
    }
    else{
        users[msg.sender].lastClaimed= block.timestamp;
    }
   
    users[msg.sender].stakeAmount += msg.value;
    totalStakes += msg.value;
   
}
   function unstake(uint _amount) public {
    require(_amount > 0, "Amount must be greater than 0");
    require(users[msg.sender].stakeAmount >= _amount, "Not enough stakes");
    require(address(this).balance >= _amount, "Not enough balance in contract");
    _updateRewards(msg.sender);
    users[msg.sender].stakeAmount -= _amount;
    totalStakes -= _amount;
    payable(msg.sender).transfer(_amount);
    
}

    function getStakeAmount(address _address) public view returns(uint256){
        return users[_address].stakeAmount;
    }
    function claimReward() public payable{
        _updateRewards(msg.sender);
        uint256 reward=users[msg.sender].unClaimedRewards;
        require(reward>0,"No rewards to claim");
        users[msg.sender].unClaimedRewards=0;
        aconToken.mint(msg.sender,reward);

    }
    function getRewards(address _user) public  returns(uint256){
       _updateRewards(_user);
       return users[_user].unClaimedRewards;
    }
    function _updateRewards(address _user) internal {
        if(users[_user].stakeAmount == 0 || users[_user].lastClaimed == 0) {
            return;
        }
        uint256 newReward=_calculateRewards(_user);
        users[_user].unClaimedRewards += newReward;
        users[_user].lastClaimed = block.timestamp;
       
    }
    function _calculateRewards(address _user) internal view returns(uint256){
        if (users[_user].lastClaimed == 0 || users[_user].stakeAmount == 0) return 0;
        uint256 timeElapsed = block.timestamp - users[_user].lastClaimed;
        return (REWARD_RATE*(users[_user].stakeAmount/1 ether)) * (timeElapsed / 1 days);
    }
 }
