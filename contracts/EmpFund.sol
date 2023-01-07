//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract PensionFund {
    //Pensions will be released equally in x(eg 10) times per hr(month)
    address internal owner;

    mapping(address => uint) public userFunds;
    mapping(address => uint) public pensionLastReceived;


    //bind the contract to the employee's EOA and set retire_date
    constructor() payable {
        owner = msg.sender;
    }

    //receive salary and perform calculations to store
    //half the received salary and forward remaining half to EOA
    function processFunds(address _empAddress, uint _salary) external payable {
        userFunds[_empAddress] += (_salary / 2);
        (bool sent, ) = _empAddress.call{value: (_salary / 2)}("");
        require(sent, "Couldnt send money to employee");

    }

    //getter function to see pension amount
    function getPensionAmount(address _empAddress) public view returns (uint) {
        return userFunds[_empAddress];
    }

    //function to make person retired
    function getPension(address _empAddress) public{
        uint lastTime = pensionLastReceived[_empAddress];
        uint month = 30*24*3600;
        require(block.timestamp >= lastTime + month && block.timestamp <= lastTime + (2*month),"You received your pension last month");
        uint numTimes = 10;
        uint pensionAmtPerTime = userFunds[_empAddress]/numTimes;
        (bool sent,) = _empAddress.call{value : pensionAmtPerTime}("");
        require(sent, "Transaction failed");
        lastTime = block.timestamp;
        userFunds[_empAddress] -= pensionAmtPerTime;
    
    }
}
