// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.26;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract MyFundMe {
    // Create a variable 'minimumUsdToSend'
    uint256 public minimumUsdToSend = 5e18;

    address[] public fundersArray;

    mapping(address funders => uint256 fundAmount) public funderToAmount;

    // Create a function to send minimum 5usd worth of ETH 
    function send() public payable {
        uint256 totalEthWorthInUsd = getConversionRate(msg.value);
        require(totalEthWorthInUsd >= minimumUsdToSend, "Please specify greater send amount"); 
        // msg.value is of type uint256
       fundersArray.push(msg.sender);
       funderToAmount[msg.sender] = funderToAmount[msg.sender] + msg.value;
       /** 'funderToAmount[msg.sender]' would be used as a key to refer to the uint256 value
            that the address is mapped to, take its current value, and add the new amount sent
            NOTE: 'funderToAmount[msg.sender]' is the value held in the place of 'fundAmount' within 
            the mapping 
        */
    }

    // Create a 'getPrice' function to get ETH price from chainlink
    function getPrice() public view returns (uint256) {
        // Store 'aggregator' interface in variable 'priceDataFeed'
        AggregatorV3Interface priceDataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price,,,) = priceDataFeed.latestRoundData();
        return uint256(price) * 1e10;
    }

    // Create function 'getConversionRate' 
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethPriceInUsd = (ethPrice * ethAmount) / 1e18;
        /** For line 25, 'ethAmount' is the amount of units of ETHs the user aims to convert
            And it's being multiplied by 'ethPrice' aka price per unit to give total worth of all
            eth the user aims to send
            After the totalling, the result is stored in an 'ethPriceInUsd' variable
        */
        return ethPriceInUsd;
    }
}