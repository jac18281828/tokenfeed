// SPDX-License-Identifier: GNU-3.0-or-later
pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";

import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

import {
    ITransparentUpgradeableProxy,
    TransparentUpgradeableProxy
} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import {TREx} from "../contracts/TREx.sol";

contract DeployTREx is Script {
    event ProxyAdminCreated(address proxyAdmin, address owner);
    event DeployedTREx(address proxy, address implementation);

    function deployAdmin() public {
        address admin = vm.envAddress("ADMIN");
        vm.startBroadcast();
        ProxyAdmin proxyAdmin = new ProxyAdmin(admin);
        console.log("ProxyAdmin: ", address(proxyAdmin));
        emit ProxyAdminCreated(address(proxyAdmin), admin);
        vm.stopBroadcast();
    }

    function deployProxyTREx() public {
        address admin = vm.envAddress("ADMIN");
        address proxyAdmin = vm.envAddress("PROXY_ADMIN");
        console.log("ProxyAdmin: ", proxyAdmin);
        address deploymentAdmin = msg.sender;
        vm.startBroadcast();
        TREx implementation = new TREx();
        bytes memory initializationData = abi.encodeWithSelector(TREx.initialize.selector, deploymentAdmin);
        TransparentUpgradeableProxy proxy =
            new TransparentUpgradeableProxy(address(implementation), proxyAdmin, initializationData);
        console.log("TREx deployed to proxy at: ", address(proxy));
        emit DeployedTREx(address(proxy), address(implementation));
        TREx trex = TREx(address(proxy));
        if (admin != deploymentAdmin) {
            trex.grantRole(trex.DEFAULT_ADMIN_ROLE(), admin);
            trex.renounceRole(trex.DEFAULT_ADMIN_ROLE(), deploymentAdmin);
            console.log("TREx set admin to: ", admin);
            console.log("TREx renounced admin: ", deploymentAdmin);
        } else {
            console.log("TREx set admin to: ", admin);
        }
        vm.stopBroadcast();
    }
}
