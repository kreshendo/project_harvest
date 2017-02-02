pragma solidity ^0.4.8;

import "./Token.sol";

contract StandardToken is Token {
	uint256 public totalSupply;
	mapping (address => uint256) public balances;
	mapping (address =>
		mapping (address => uint256)) public allowed;

	function StandardToken(address _initialOwner, uint256 _supply) {
		totalSupply = _supply;
		balances[_initialOwner] = _supply;
	}

	function transfer(address _to, uint256 _value) returns (bool success) {
		if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
			balances[msg.sender] -= _value;
			balances[_to] += _value;
			Transfer(msg.sender, _to, _value);
			return true;
		} else {
			return false;
		}
	}

	function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
		if (allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
			allowed[_from][msg.sender] -= _value;
			balances[_to] += _value;
			Transfer(_from, _to, _value);
			return true;
		} else {
			return false;
		}
	}

	function approve(address _spender, uint256 _value) returns (bool success) {
		allowed[msg.sender][_spender] = _value;
		Approval(msg.sender, _spender, _value);
		return true;
	}
}
