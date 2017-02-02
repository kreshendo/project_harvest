pragma solidity ^0.4.8;


/*
This Token Contract implements the standard token functionality (https://github.com/ethereum/EIPs/issues/20) as well as the following OPTIONAL extras intended for use by humans.

In other words. This is intended for deployment in something like a Token Factory or Mist wallet, and then used by humans.
Imagine coins, currencies, shares, voting weight, etc.
Machine-based, rapid creation of many tokens would not necessarily need these extra features or will be minted in other manners.

1) Initial Finite Supply (upon creation one specifies how much is minted).
2) In the absence of a token registry: Optional Decimal, Symbol & Name.
3) Optional approveAndCall() functionality to notify a contract if an approval() has occurred.

.*/

import "./StandardToken.sol";

contract HumanStandardToken is StandardToken {
  function () {
    //if ether is sent to this address, send it back.
    throw;
  }

  /*Public variables of the token*/

  /*
  NOTE:
  The following variables are OPTIONAL vanities. One does not have to include them.
  They allow one to customise the token cotract & in no way influences the core functionality.
  Some wallets/interfaces might not even bother to look at this information.
  */
  string public name;                    //fancy name: eg BlockBucks
  uint8 public decimals;                 //How many decimals
  string public symbol;                  //An identifier
  string public version = 'BB0.1';       //Block Bucks 0.1

  function HumanStandardToken(
    uint256 _initialAmount,
    string _tokenName,
    uint8 _decimalUnits,
    string _tokenSymbol
    ){
      balances[msg.sender] = _initialAmount;
      totalSupply = _initialAmount;
      name = _tokenName;
      decimals = _decimalUnits;
      symbol = _tokenSymbol;
    }

    /*Approves and then calls the receiving contract*/
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
      allowed[msg.sender][_spender] = _value;
      Approval(msg.sender, _spender, _value);

      //call the receiveApproval function on the contract you want to be notified. This cragts the function signature manually so one doesn't have to include a contract in here just for this.
      //recieveApproval(address _from, uint256 _value, address _tokenContract, bytes extraData)
      //it is assumed that when it does this that the call *should* succeed, otherwise one would use vanilla approval instead.
      if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
      return true;
    }
}
