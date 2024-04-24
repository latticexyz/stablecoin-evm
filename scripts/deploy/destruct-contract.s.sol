// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "forge-std/console.sol"; // solhint-disable no-global-import, no-console
import { Script } from "forge-std/Script.sol";
import {
    AdminUpgradeabilityProxy
} from "../../contracts/upgradeability/AdminUpgradeabilityProxy.sol";

contract Destructor {
    function destruct() public {
        selfdestruct(address(0));
    }
}

/**
 * A utility script to destruct a contract
 */
contract DestructContract is Script {
    /**
     * @notice main function that will be run by forge
     */
    function run(address admin, AdminUpgradeabilityProxy proxy) external {
        vm.startBroadcast(admin);
        Destructor destructor = new Destructor();
        proxy.upgradeTo(address(destructor));
        Destructor(address(proxy)).destruct();
        vm.stopBroadcast();
    }
}
