// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

library Roles {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
}