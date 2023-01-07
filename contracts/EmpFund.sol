//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract PensionFund {
    uint retireDate;
    address payable public employeeEOA; //address of employee account

    //bind the contract to the employee's EOA and set retire_date
    constructor(uint _retireDate, address payable _employeeEOA) {
        retireDate = _retireDate;
        employeeEOA = _employeeEOA;
    }

    //receive salary and perform calculations to store
    //half the received salary and forward remaining half to EOA
    receive() external payable {
        uint _salaryReceived = address(this).balance;
        uint _salaryPay = _salaryReceived / 2;
        (bool sent,) = employeeEOA.call{value:_salaryPay}("");
        require(sent, "Couldnt send money to employee");
    }

    //to display balance in the PensionFund
    function getBalance() public view returns (uint256) {
        return address(this).balance; //in wei
    }
}
