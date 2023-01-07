//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract PensionFund {
    address payable public employeeEOA; //address of employee account

    //access the map
   
    constructor() {
       
    }

    //just receive salaries in the contract
    receive() external payable {
        //mark the amount into the account
        // msg.value has the amount received
        //split the salary 
        //add pension also
        // then use call pay function
       
    }


    //pay function to send half amount

    //getter function to see pension amount



    //function to make person retired

   
}
