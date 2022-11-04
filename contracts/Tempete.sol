// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract Tempete {
    
    
    mapping(address => string) private addressArray;  
    mapping(string => uint256) private valueArray;

    constructor() {}

    function deposit() public payable {
        // value should be > 0
        require(msg.value > 0);
        // To be replaced with chainlink oracle
        string memory message = Strings.toString(uint(keccak256("wow")));
        addressArray[msg.sender] = message;
        valueArray[message] = msg.value;
    }

    function getMessage() public view returns(string memory){
        return addressArray[msg.sender];
    }

    function withdraw(string memory _message, address _to, uint256 _amount) public payable{
        require(valueArray[_message] > 0, "There is no ETH to withdraw from this message");
        
        payable(_to).transfer(_amount);
        valueArray[_message] -= _amount;
    }




    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}