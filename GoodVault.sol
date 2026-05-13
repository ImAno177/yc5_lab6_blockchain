// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GoodVault {
    mapping(address => uint256) public balances;
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value > 0, "No ether sent");
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Nothing to withdraw");

        balances[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
    }

    function emergencyWithdraw(address payable recipient) external {
        require(msg.sender == owner, "Only owner");
        recipient.transfer(address(this).balance);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}