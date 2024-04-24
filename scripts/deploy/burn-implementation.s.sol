// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/console.sol"; // solhint-disable no-global-import, no-console
import { Script } from "forge-std/Script.sol";
import {
    AdminUpgradeabilityProxy
} from "../../contracts/upgradeability/AdminUpgradeabilityProxy.sol";

contract Dummy {}

/**
 * A utility script to destruct a contract
 */
contract BurnImplementation is Script {
    function run(address admin, AdminUpgradeabilityProxy proxy) external {
        vm.startBroadcast(admin);
        Dummy dummy = new Dummy();
        proxy.upgradeTo(address(dummy));
        vm.stopBroadcast();
    }
}
