// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.26;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceDataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceDataFeed.latestRoundData();
        return uint256(price) * 1e10;
    }
    function convertToUsd(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountToUsd = (ethAmount * ethPrice) / (1 * 10 ** 18);
        return ethAmountToUsd;
    }
}