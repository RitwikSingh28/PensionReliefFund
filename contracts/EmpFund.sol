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

    modifier onlyOwner() {
        require(msg.sender == owner, "Funds to be accepted through owner only");
        _;
    }

    //receive salary and perform calculations to store
    //half the received salary and forward remaining half to EOA
    function processFunds(address _empAddress, uint _salary)
        external
        payable
        onlyOwner
    {
        funds[_empAddress] += (_salary / 2);
        (bool sent, ) = _empAddress.call{value: (_salary / 2)}("");
        require(sent, "Couldnt send money to employee");

    //address payable public employeeEOA; //address of employee account

    //access the map
   
    //constructor() {
    //   
    //}

    //just receive salaries in the contract
    //receive() external payable {
        //mark the amount into the account
        // msg.value has the amount received
        //split the salary 
        //add pension also
        // then use call pay function
    //}


    //pay function to send half amount

    //getter function to see pension amount



    //function to make person retired

   
}
