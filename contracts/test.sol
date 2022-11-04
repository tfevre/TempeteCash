//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
// IMPORTS //
import "./ERC20Token.sol";
import "./VRF2Consumer.sol";
contract TempeteCash {
    uint256 private passNumber;
    VRF2Consumer public contractA;
    struct userDeposit {
        uint256 numberPass;
        uint256 numberOfDeposit;
        uint256 balanceDeposit;
    }
    mapping(address => userDeposit) private User;
    constructor(address _otherContract) {
        contractA = VRF2Consumer(_otherContract);
    }
    function deposit() public payable {
        require(msg.value > 0, "You have to deposit some ETH");
        getRandom();
        passNumber = contractA.lastRequestId();
        User[payable(msg.sender)] = userDeposit({
            numberPass: passNumber,
            numberOfDeposit: 1,
            balanceDeposit: msg.value
    });
    }
    function withdraw(uint256 _numberPass, address _To) public payable {
        require(_numberPass == User[msg.sender].numberPass, "Incorrect NumberPass");
        payable(_To).transfer(User[msg.sender].balanceDeposit);
        User[msg.sender].balanceDeposit = 0;
    }
    function getRandom() internal {
        contractA.requestRandomWords();
    }
    function getPassNumber() public view returns (uint256) {
        return User[msg.sender].numberPass;
    }
    receive() external payable {}
}