// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Company {
    address public owner; //company admin
    address empFundContract; //employee fund contract address
    //enum for salary class
    enum salary_class {
        ClassD,
        ClassC,
        ClassB,
        ClassA
    }

    struct Employee {
        address account;
        uint currentSalary;
        salary_class class;
        uint timeSinceClassChange;
        uint experience;
        bool flag;
    }

    mapping(address => Employee) public employeeList;

    constructor(address _fundContractAddress) {
        empFundContract = _fundContractAddress;
    }


     function addNewEmployee(address newEmpAccount,uint _initSal,salary_class _startClass) external{
        require(msg.sender== owner,"Only deployer can add new employee");
        Employee memory newEmp = Employee({
            account : newEmpAccount,
            currentSalary : _initSal,
            class : _startClass,
            timeSinceClassChange : 0,
            experience : 0,
            flag : true
        });
        employeeList[newEmpAccount] = newEmp;
    }

    //make a modifier if needed to set initial checks for repeated codes in various functions

    //function to increase salary
    //only deployer should be able to do this
    //set currentSalary to calculated salary
    function increaseSalary(address empAccount, Employee memory _empl)
        external
        view
    {
        require(msg.sender == owner, "Only deployer can change salary");
        require(
            employeeList[empAccount].flag == true,
            "This employee does not exist"
        );
        uint _timeSinceClassChange = _empl.timeSinceClassChange;
        salary_class _class = _empl.class;
        uint _currentSalary = _empl.currentSalary;
        uint yrsOfWork = _empl.experience;

        //check if employee scales up in paygrade after a certain period of time, say 1 year
        if (
            block.timestamp >= _timeSinceClassChange + 30 seconds && //365 days or more depending on company's policy
            _class != salary_class.ClassA //no upgrade after reaching class A
        ) {
            _class = salary_class(uint(_class) + 1); //upgrade class by one
            _timeSinceClassChange = block.timestamp; //reset the timer after changing class
        }

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

        _empl.currentSalary = _currentSalary;
    }

    //logic to get this month's salary from company to contract as per calculation done above

    //this function transfers half of salary to employee account
    //use call()
    function sendAmount(address emplAccount) external payable {
        Employee storage _empl = employeeList[emplAccount];
        (bool sent, ) = empFundContract.call{value: _empl.currentSalary}("");
        require(sent, "Transaction failed");
    }

    //counter to store pension
    // function storePension() external {}

    //check if pensiongiving date occured
    //transfer pension equally at certain intervals
    //reset pension giving date to next month
}
