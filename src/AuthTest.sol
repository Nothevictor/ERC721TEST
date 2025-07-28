// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {IERC721Auth} from "./IERC721Auth.sol";

contract AuthTest {
    IERC721Auth public immutable erc721Auth;

    mapping(address => bool) public hasParticipated;

    error UserDontHaveToken();

    constructor(address _erc721Auth) {
        erc721Auth = IERC721Auth(_erc721Auth);
    }

    function partifipate() external {
        // Check if user has any tokens (checking tokens 0 and 1)
        bool hasToken0 = erc721Auth.hasToken(msg.sender, 0);
        bool hasToken1 = erc721Auth.hasToken(msg.sender, 1);

        if (!hasToken0 && !hasToken1) {
            revert UserDontHaveToken();
        }

        hasParticipated[msg.sender] = true;
    }
}
