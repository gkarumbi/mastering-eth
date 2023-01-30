// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Owned{
    address payable owner;

    //Contract constructor : set owner
    constructor()public {
        owner = msg.sender;

    }

    //Access control modifier
    modifier onlyOwner{
        require(msg.sender == owner,"Only the contract owner can call this function");
        _;
    }
}

contract Mortal is Owned{
    //contract destructor

    function destroy() public onlyOwner{
        selfdestruct(owner);
    }
}

contract Faucet is Mortal{

   event Withdrawal(address indexed to, uint amount);
   event Deposit(address indexed from, uint amount);
    
    //Give out ether to anyone who asks
    function withdraw(uint withdraw_amount) public {
        //Limit withdrwal amount
        require(withdraw_amount <= 0.1 ether);
        require(address(this).balance >= withdraw_amount, "Insufficient balance in faucet fpr withdrwal request");

        //Send the amount to the address tjhhat requested it
        msg.sender.transfer(withdraw_amount);
        emit Withdrawal(msg.sender, withdraw_amount);
    }

    //Accept any incoming amount
    receive() external payable{
        emit Deposit(msg.sender, msg.value);
    }
    
    
    
   
}

