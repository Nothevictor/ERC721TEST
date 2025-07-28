// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {ERC721Auth} from "../src/ERC721Auth.sol";
import {Roles} from "../src/Roles.sol";

contract ERC721AuthDeploy is Script {
    ERC721Auth public erc721Auth;

    // Set deployer address
    address private deployer = 0x224c8c053fCa8127E226b72eFdb49faf8a43C1A5;
    uint256 private deployerPrivateKey = 0x8b02f8e614300a65e40b34bac3af0caf648a1c0cbcd8f34a49a279952701da4b;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the ERC721Auth contract
        erc721Auth = new ERC721Auth();

        // Grant minter role to deployer
        erc721Auth.grantRole(Roles.MINTER_ROLE, msg.sender);
        erc721Auth.grantRole(Roles.MANAGER_ROLE, msg.sender);

        console.log("ERC721Auth deployed at:", address(erc721Auth));
        console.log("Deployer has MINTER_ROLE and MANAGER_ROLE");

        vm.stopBroadcast();
    }
}

//forge script script/ERC721AuthDeploy.s.sol --fork-url https://base-sepolia.drpc.org --broadcast