// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Joel {
    string public name = "JOEL";
    string public symbol = "JL";
    uint8 public  decimals = 18;
    uint256 public  totalSupply = 1000;
    address private owner;

    mapping (address => uint256) private balances; // alias: "BalanceOf" ... 
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address indexed indexedFrom, address indexed indexedTo, uint256 value);
    event Approval(address indexed indexedOwner, address indexed indexedSpender, uint256 value);
    event Burn(address indexed indexedOwner, uint256 amount);

    constructor() {
        owner = msg.sender;
        _mint(msg.sender, 100e18);
    }

    function approve(address addressFrom, address addressTO, uint256 allowed ) public  {
        allowance[addressFrom][addressTO] = allowed;
    }

    function balanceOf( address account) public view returns (uint256) {
        return balances[account];
    }

    function _mint(address address_to, uint256 amount ) public  {
        require(address_to != address(0), "MUST NOT BE A ZERO ADDRESS.");
        require(msg.sender == owner, "YOU ARE NOT AUTHORIZED TO MINT THIS TOKEN");
        totalSupply += amount;
        balances[address_to] += amount;
        emit Transfer(msg.sender, address_to, amount);
    }


    function _transfer(address addressFrom, address addressTo, uint256 amount) private returns (bool) {
        uint256 currentBalance = balances[addressFrom];
        require(addressTo != address(0), "ERC20 TRANSFER TO ADDRESS 0.");
        require(amount <= currentBalance, "INSUFFICIENT BALANCE.");
        balances[addressFrom] -= amount;
        balances[addressTo] += amount;
        emit Transfer(addressFrom, addressTo, amount);
        return true;
    }


    function transferFrom(address addressFrom, address addressTo, uint256 amount) external returns (bool){
        uint256 currentAllowance = allowance[addressFrom][msg.sender];
        require(currentAllowance >= amount, "ERC20 TRANSFER AMOUNT NOT EXCEED ALLOWANCE."); 
        require(addressTo != address(0), "ERC20 TRANSFER TO ADDRES 0.");
        currentAllowance = currentAllowance - amount;
        emit Approval(addressFrom, addressTo, amount);
        return _transfer(addressFrom, addressTo, amount);
    }

    function approve(address addressSpender, uint256 value) external returns (bool) {
        require(addressSpender != address(0), "INVALID ADDRESS!");
        allowance[msg.sender][addressSpender];
        emit Approval(msg.sender, addressSpender, value);
        return true;
    }
}