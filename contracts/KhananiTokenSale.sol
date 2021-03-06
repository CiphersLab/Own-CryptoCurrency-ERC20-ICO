pragma solidity ^0.4.24;

import './KhananiToken.sol';

contract KhananiTokenSale {
    address admin;
    KhananiToken public tokenContract;
    uint256 public tokenPrice = 0;
    uint256 public tokensSold;

    event Sell(
        address   _buyer,
        uint256  _amount
    );

    constructor (KhananiToken _tokenContract, uint256 _tokenPrice ) public {
        //Assign an Admin
        admin = msg.sender; //address of person how deployed the contract

        //Assign Token Contract
        tokenContract = _tokenContract;

        //Set the token Price
        tokenPrice = _tokenPrice;
    }

    //Multiple function 
    function multiply(uint x, uint y) internal pure returns(uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    //Buy Token

    function buyTokens(uint256 _numberOfTokens) public payable {
        //Require that value is equal to token
        require(msg.value == multiply(_numberOfTokens , tokenPrice));

        //require that enough token are avaible in token
        require(tokenContract.balanceOf(this) >= _numberOfTokens);        

        //require transfer is succesfull
        require(tokenContract.transfer(msg.sender, _numberOfTokens));        
        
        //Keep track of num of token sold
        tokensSold += _numberOfTokens;


        //trigger for Sell Event
        Sell(msg.sender, _numberOfTokens);
    }



    //Ending of Token Salse
    // function endSale() public{
    //     //require admin
    //     require(msg.sender == admin);

    //     //transfer remaing token to admin
    //     require(tokenContract.transfer(admin, tokenContract.balanceOf(this)));
    //     //Destory this contract
    //     selfdestruct(admin);

    // }

    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(this)));
        selfdestruct(admin);
    }

}