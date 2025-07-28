// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {ERC721Auth} from "../src/ERC721Auth.sol";

contract ERC721Mint is Script {
    function setUp() public {}

    function run() public {
        address contractAddress = vm.envAddress("CONTRACT_ADDRESS");
        address recipient = vm.envAddress("RECIPIENT_ADDRESS");
        string memory tokenUri = vm.envString("TOKEN_URI");

        vm.startBroadcast();

        ERC721Auth erc721Auth = ERC721Auth(contractAddress);

        // Mint new token
        erc721Auth.mint(recipient, tokenUri);

        console.log("Minted token to:", recipient);
        console.log("Token URI:", tokenUri);
        console.log("On contract:", contractAddress);

        vm.stopBroadcast();
    }
}
