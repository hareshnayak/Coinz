pragma solidity 0.6.6;

contract HarryCoin{
    int balance;

    constructor()public{
        balance = 0;

    }

    // getBalance to view the balance
    // set as view public
    // only viewing is public and cannot be modified
    function getBalanace() view public returns(int){ 
        return balance;
    }

    // depositBalance to add amount amt to the balance
    // set as public
    // both read and write operations are public
    function depositBalance(int amt)public {
        balance = balance + amt; 
    }

    // withdrawBalance to deduct amount amt to the balance
    // set as public
    // both read and write operations are public
    function withdrawBalance(int amt) public {
        balance = balance - amt;
    }
}
