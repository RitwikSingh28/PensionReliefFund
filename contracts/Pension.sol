// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Pension {
    address owner; //company admin
    address employee;
    uint initalSalary;
    uint currentSalary;
    uint pension = 0;
    uint retireDate;

    //enum for salary class
    enum salary_class {
        ClassD,
        ClassC,
        ClassB,
        ClassA
    }

    //we will give address and initalSalary at time of deploying smart contract
    //we are deploying contract when the employee is hired
    constructor(address _person, uint _initSal) {
        owner = msg.sender;
        employee = _person;
        initalSalary = _initSal;
        currentSalary = _initSal;
    }

    //function to increase salary
    //only deployer should be able to do this
    //do some calculation for getting current salary
    //set currentSalary to calculated salary
    function increaseSalary(uint yrsOfWork, salary_class _class) external {
        require(msg.sender == owner, "Only deployer can change salary");
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
