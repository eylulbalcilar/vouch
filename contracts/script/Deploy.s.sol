// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {Vouch} from "../src/Vouch.sol";

contract DeployVouch is Script {
    function run() external returns (Vouch) {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        Vouch vouch = new Vouch();
        vm.stopBroadcast();

        return vouch;
    }
}
