
# Fund Me DApp

This is a decentralized application (DApp) built using Solidity. The app allows users to send funds to the contract and lets the contract owner withdraw the collected funds. It's designed to demonstrate core Solidity concepts such as contract ownership, payable functions, and handling Ether within smart contracts.

## Solidity Concepts Implemented

- **Payable Functions**: The `fund()` function is marked as payable, allowing it to receive Ether when called. This demonstrates how smart contracts can handle Ether transactions.
  
- **Modifiers**: The `onlyOwner` modifier restricts access to certain functions, ensuring that only the contract owner can withdraw funds.

- **Mapping**: The contract uses a mapping to keep track of who sent how much Ether, implementing basic fund tracking.

- **Aggregating Data**: The app utilizes Chainlink oracles to fetch the latest ETH/USD price, allowing the contract to set a minimum funding amount in USD.

- **Fallback and Receive Functions**: These functions are used to handle direct Ether transfers and ensure the contract doesn't reject funds sent via non-standard calls.

## Features of the App

- **Fund the Contract**: Users can send Ether to the contract using the `fund()` function. The amount is logged, and each user’s total contribution is tracked.
  
- **Withdraw Funds**: Only the contract owner can withdraw the accumulated funds using the `withdraw()` function, ensuring security.

- **ETH/USD Price Conversion**: The contract ensures users send a minimum amount of USD equivalent in Ether by integrating an oracle to fetch the latest price data.

## Installation and Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/SIEcoder/Solidity-fund-me-app
   ```
2. Compile and deploy the contract using a tool like Remix or Hardhat.
3. Interact with the contract through a Web3 interface like Metamask or using the Hardhat console.

4. You're all done! 🥳
