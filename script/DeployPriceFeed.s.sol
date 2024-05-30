// SPDX-License-Identifier: GNU-3.0-or-later
pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";

import {SimplePriceFeed} from "../contracts/SimplePriceFeed.sol";

contract DeployPriceFeed is Script {
    event DeployedPriceFeed(address implementation);

    function deployPriceFeed() public {
        vm.startBroadcast();
        int256 answer = 1030930790966715357;
        uint8 decimals = 18;
        SimplePriceFeed implementation = new SimplePriceFeed(answer, decimals);
        console.log("PriceFeed deployed at: ", address(implementation));
        emit DeployedPriceFeed(address(implementation));
        vm.stopBroadcast();
    }
}
