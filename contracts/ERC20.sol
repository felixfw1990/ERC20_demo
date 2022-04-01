// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "./IERC20.sol";
import "./SafeMathOnUint256.sol";

/**
* @title WIT(What is this?) about ERC20 contract.
* @dev NOTICE! The contract just demo use test!
*/
contract ERC20 is IERC20{

    // ------------------------------------------------------------------------------

    using SafeMathOnUint256 for uint256;

    string constant NAME = "What is this ?";
    string constant SYMBOL = "WIT";
    uint8 constant DECIMALS = 8;

    uint _totalSupply;
    address _manager;
    mapping(address => uint) _balances;
    mapping(address => mapping(address => uint)) _allowed;

    // ------------------------------------------------------------------------------

    constructor(){
        _manager = msg.sender;
    }

    // ------------------------------------------------------------------------------

    function name() public pure returns (string memory){
        return NAME;
    }

    // ------------------------------------------------------------------------------

    function symbol() public pure returns (string memory){
        return SYMBOL;
    }

    // ------------------------------------------------------------------------------

    function decimals() public pure returns (uint8){
        return DECIMALS;
    }

    // ------------------------------------------------------------------------------

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }

    // ------------------------------------------------------------------------------

    function balanceOf(address _owner) public view returns (uint256 balance){
        return _balances[_owner];
    }

    // ------------------------------------------------------------------------------

    function transfer(address _to, uint256 _value) public returns (bool success){
        require(_to != address(0));
        require(_value <= _balances[msg.sender]);

        _balances[msg.sender] = _balances[msg.sender].sub(_value);
        _balances[_to] = _balances[_to].add(_value);

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    // ------------------------------------------------------------------------------

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(_to != address(0));
        require(_value <= _allowed[_from][msg.sender]);
        require(_value <= _balances[_from]);

        _allowed[_from][msg.sender] = _allowed[_from][msg.sender].sub(_value);
        _balances[_from] = _balances[_from].sub(_value);
        _balances[_to] = _balances[_to].add(_value);

        emit Transfer(_from, _to, _value);

        return true;
    }

    // ------------------------------------------------------------------------------

    function approve(address _spender, uint256 _value) public returns (bool success){
        require(_spender != address(0));

        _allowed[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    // ------------------------------------------------------------------------------

    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return _allowed[_owner][_spender];
    }

    // ------------------------------------------------------------------------------

    function mint(address account, uint256 amount) public returns(bool success){
        require(msg.sender == _manager);

        return _mint(account, amount);
    }

    // ------------------------------------------------------------------------------

    function burn(uint256 amount) public returns(bool success){
        return _burn(msg.sender, amount);
    }

    // ------------------------------------------------------------------------------

    function burnFrom(address account, uint256 amount) public returns(bool success){
        require(amount <= _allowed[account][msg.sender]);

        _allowed[account][msg.sender] = _allowed[account][msg.sender].sub(amount);

        return _burn(account, amount);
    }

    // ------------------------------------------------------------------------------

    function _mint(address account, uint256 amount) private returns(bool success){
        require(account != address(0));

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);

        emit Transfer(address(0), account, amount);

        return true;
    }

    // ------------------------------------------------------------------------------

    function _burn(address account, uint256 amount) private returns(bool success){
        require(account != address(0));
        require(amount <= _balances[account]);

        _balances[account] = _balances[account].sub(amount);
        _totalSupply = _totalSupply.sub(amount);

        emit Transfer(account, address(0), amount);

        return true;
    }

    // ------------------------------------------------------------------------------
}