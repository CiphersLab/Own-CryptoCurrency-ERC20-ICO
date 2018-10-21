pragma solidity ^0.4.24;

contract KhananiToken {
    //Name
    //Symbol
    string public name = 'Khanani Token';
    string public symbol = 'KCOIN';
    string public standard = 'Khanani Token v1.0';
    
    uint256 public totalSupply;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256  _value
    );

    mapping(address => uint256) public balanceOf;

    constructor(uint256 _initalSupply) public {
        balanceOf[msg.sender] = _initalSupply;
        totalSupply = _initalSupply;
         
        //allocating initial supply 
    }

    //Transfer
    

    function transfer(address _to, uint256 _value) public returns (bool success) {
        //Exception if account doesn't have enough
        require(balanceOf[msg.sender] >= _value);
        
        //Transfer the balance
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        
        //Transfer Event
        Transfer(msg.sender, _to, _value);

        //Return Boolean
        return true;
    }
}