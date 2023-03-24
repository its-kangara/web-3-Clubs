/ SPDX-License-Identifier: MIT 

// uses a solidity complier version greater than 0.8.15
pragma solidity ^0.8.15; 

contract payableSample { 
//     We declare astate variable called Owner  with  a data type "address payable" which means that the contract can be read from outside.
// The state variable called "Owner" that holds the address of the contract owner (the person who deployed the contract), which is marked as "payable" to enable it to receive ether.
    
    address payable public Owner;

  //the constructor function initializes the owner variable to the address that deploys the contract
    constructor () { 
        Owner = payable (msg.sender);
    } 
    

    //receive fallback function that is executed when the contract receives ether without a specific function call.
    //we need to use value and transact while first sending ether to the owner contract.
    receive() external payable{}

    //this allows the contract owner to withdraw ether from the contract
    //if the caller is not the owner the funtion throws an error.
    //if amount to transfer must be available 

    function withdraw (uint _amount) external{ 
        require(msg.sender == Owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
       
    }

     //the function allows anyone to transfer ether from the contract  and takes 2 parameters an address and the amount to transfer 
    function TransferEthe(address payable _to, uint _amount) external payable { 
        _to.transfer(_amount);
    
    }

    //ths function transfers the balance of the ether held by the contract..Marked as \View since it does not change the contract state
    function getbalance() external view returns(uint) {
        return address(this).balance;
    }



}
