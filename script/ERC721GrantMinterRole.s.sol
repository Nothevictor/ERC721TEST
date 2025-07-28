// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {ERC721Auth} from "../src/ERC721Auth.sol";
import {Roles} from "../src/Roles.sol";

contract ERC721GrantMinterRole is Script {
    function setUp() public {}

    function run() public {
        address contractAddress = vm.envAddress("CONTRACT_ADDRESS");
        address grantee = vm.envAddress("GRANTEE_ADDRESS");

        vm.startBroadcast();

        ERC721Auth erc721Auth = ERC721Auth(contractAddress);

        // Grant minter role to specified address
        erc721Auth.grantRole(Roles.MINTER_ROLE, grantee);

        console.log("Granted MINTER_ROLE to:", grantee);
        console.log("On contract:", contractAddress);

        vm.stopBroadcast();
    }
}
