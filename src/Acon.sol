// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract Acon is ERC20,Ownable{
    address stakingContract;
    constructor(address _stakingContract) ERC20("Acon","Acon") Ownable(msg.sender){
        stakingContract=_stakingContract;
    }
    function mint(address _to,uint256 _amount)  public{
        require(msg.sender==stakingContract,"Only staking contract can mint tokens");
        
        _mint(_to,_amount);
    }
    function updateStakingContract(address _newStakingContract) public onlyOwner{
        require(_newStakingContract!=address(0),"Invalid address");
        stakingContract=_newStakingContract;
    }
    
}