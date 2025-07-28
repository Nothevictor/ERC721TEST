// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {AuthTest} from "../src/AuthTest.sol";
import {ERC721Auth} from "../src/ERC721Auth.sol";

contract AuthTestDeploy is Script {
    AuthTest public authTest;
    ERC721Auth public erc721Auth;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // First deploy the ERC721Auth contract
        erc721Auth = new ERC721Auth();

        // Then deploy AuthTest with the ERC721Auth address
        authTest = new AuthTest(address(erc721Auth));

        console.log("ERC721Auth deployed at:", address(erc721Auth));
        console.log("AuthTest deployed at:", address(authTest));

        vm.stopBroadcast();
    }
}

