// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.26;

import "./PriceConverter.sol";

contract MyFundme {
    using PriceConverter for uint256;

    uint256 constant public MINIMUM_USD = 5 * 10 ** 18;

    address immutable public i_owner ;

    address[] public senderAddressArray;

    mapping(address sender => uint256 amount) public senderToAmountMapping;

    function send() public payable {
        require(msg.value.convertToUsd() >= MINIMUM_USD, "Not enough send amount!");
        senderAddressArray.push(msg.sender);
        senderToAmountMapping[msg.sender] += msg.value;
    }

    function withdraw() public ForOwner {
        require(msg.sender == i_owner, "Not the owner!");
        (bool callSuccessful,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccessful, "Call failed!");

        for(uint256 indexLoop = 0; indexLoop <= senderAddressArray.length; indexLoop++) {
            address eachSender = senderAddressArray[indexLoop];
            senderToAmountMapping[eachSender] = 0;
            senderAddressArray = new address[](0);
        }
    }

    constructor(){
        i_owner = msg.sender;
    }

    modifier ForOwner() {
        require(msg.sender == i_owner, "Strictly for owner!");
        _;
    }
    
    receive() external payable {
        send();
    }

    fallback() external payable {
        send();
    }
}