//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract PensionFund {
    address internal owner;

    mapping(address => uint) public funds;

    // uint retireDate;
    // address payable public employeeEOA; //address of employee account

    //bind the contract to the employee's EOA and set retire_date
    constructor() payable {
        owner = msg.sender;
    }

    //receive salary and perform calculations to store
    //half the received salary and forward remaining half to EOA
    function processFunds(address _empAddress, uint _salary) external payable {
        funds[_empAddress] += (_salary / 2);
        (bool sent, ) = _empAddress.call{value: (_salary / 2)}("");
        require(sent, "Couldnt send money to employee");

        //address payable public employeeEOA; //address of employee account

        //access the map
    }

    //getter function to see pension amount
    function getPensionAmount(address _empAddress) public view returns (uint) {
        //check if the address belongs to an employee or not
        //would need to use mapping here to find out
    }

    //function to make person retired
}
