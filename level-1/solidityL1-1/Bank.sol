// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
contract Bank {
    // 状态变量
    address public immutable owner;
    // 事件
    event Deposit(address _ads, uint256 amount);
    event Withdraw(address indexed receiver, uint256 amount);  // 现在接受两个参数
    // receive
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
    // 构造函数
    constructor() payable {
        owner = msg.sender;
    }
    function deposit() external payable {
        emit Deposit(msg.sender, msg.value);
    }
    // 方法
    function withdraw() external {
        require(msg.sender == owner, "Not Owner");
        uint256 balance = address(this).balance;
        require(balance > 0, "Zero Balance");
        
        emit Withdraw(msg.sender, balance);
        (bool success, ) = payable(msg.sender).call{value: balance}("");
        require(success, "Transfer failed");
    }
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}