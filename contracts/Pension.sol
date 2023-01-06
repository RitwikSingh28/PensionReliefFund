// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Pension {
    //enum for salary class
    enum salary_class {
        ClassD,
        ClassC,
        ClassB,
        ClassA
    }

    address owner; //company admin
    address employee;
    uint currentSalary;
    uint pension = 0;
    salary_class class;
    uint timeSinceClassChange;
    uint retireDate;

    //we will give address and initalSalary at time of deploying smart contract
    //we are deploying contract when the employee is hired
    constructor(
        address _person,
        uint _initSal,
        salary_class _class
    ) {
        owner = msg.sender;
        employee = _person;
        currentSalary = _initSal;
        class = _class;
        timeSinceClassChange = block.timestamp;
    }

    //function to increase salary
    //only deployer should be able to do this
    //do some calculation for getting current salary
    //set currentSalary to calculated salary
    function increaseSalary(uint yrsOfWork, salary_class _class) external {
        require(msg.sender == owner, "Only deployer can change salary");

        //check if employee scales up in paygrade after a certain period of time, say 1 year
        if (
            block.timestamp >= timeSinceClassChange + 365 days &&
            class != salary_class.ClassA //no upgrade after reaching class A
        ) {
            class = salary_class(uint(class) + 1); //upgrade class by one
            timeSinceClassChange = block.timestamp; //reset the timer after changing class
        }

        uint _currentSalary = currentSalary;
        //depending on class, initial percent starts with 0, 2, 4, 6 for respective grades
        uint _percentIncr = uint(_class) * 2;

        //scope of improving the increase_salary logic
        if (yrsOfWork <= 1) {
            _percentIncr += 5;
        } else if (yrsOfWork <= 5) {
            _percentIncr += 10;
        } else if (yrsOfWork <= 10) {
            _percentIncr += 15;
        } else {
            _percentIncr += 20;
        }

        _currentSalary =
            _currentSalary +
            ((_currentSalary / 100) * _percentIncr);
        currentSalary = _currentSalary;
    }

    //logic to get this month's salary from company to contract as per calculation done above

    //this function transfers half of salary to employee account
    //use call()
    function sendAmount() external {}

    //counter to store pension
    function storePension() external {}

    //check if pensiongiving date occured
    //transfer pension equally at certain intervals
    //reset pension giving date to next month
}
