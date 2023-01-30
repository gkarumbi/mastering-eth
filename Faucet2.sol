// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Faucet{

    address owner ;
    constructor(){
        owner = msg.sender;
    }
    //Accept any incoming amount
    receive() external payable{}
    //Give out ether to anyone who asks
    function withdraw(uint withdraw_amount) public {
        //Limit withdrwal amount
        require(withdraw_amount <= 0.1 ether);

        //Send the amount to the address tjhhat requested it
        msg.sender.transfer(withdraw_amount);
    }

    function destroy() public onlyOwner{
        
        selfdestruct(owner);
    }

    
    modifier onlyOwner {
    require(msg.sender == owner);
    _;
    }
   
}

