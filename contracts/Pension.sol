// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Pension{
    address owner; //company admin
    address employee;
    uint initalSalary;
    uint currentSalary;
    uint pension = 0;
    uint retireDate;

    //we will give address and initalSalary at time of deploying smart contract
    //we are deploying contract when the employee is hired
    constructor(address _person,uint _initSal){
        owner = msg.sender;
        employee = _person;
        initalSalary = _initSal;
        currentSalary = _initSal;

    }

    //function to increase salary
    //only deployer should be able to do this
    //do some calculation for getting current salary
    //set currentSalary to calculated salary
    function increaseSalary(uint yrsOfWork,uint _initSalary) external {
        
    }

    //logic to get this month's salary from company to contract as per calculation done above

    //this function transfers half of salary to employee account
    //use call()
    function sendAmount() external {
        
    }

    //counter to store pension
    function storePension()external {

    }

    //check if pensiongiving date occured
    //transfer pension equally at certain intervals
    //reset pension giving date to next month

    



}