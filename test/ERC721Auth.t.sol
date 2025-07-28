// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import "forge-std/Test.sol";
import "../src/AuthTest.sol";
import "../src/ERC721Auth.sol";
import "../src/Roles.sol";

contract AuthTestSuite is Test {
    ERC721Auth public erc721;
    AuthTest public authTest;

    address public owner;
    address public userWithToken;
    address public userWithoutToken;

    function setUp() public {
        owner = address(this);
        userWithToken = address(0x1);
        userWithoutToken = address(0x2);

        // Деплой ERC721Auth
        erc721 = new ERC721Auth();

        // Назначение ролей
        erc721.grantRole(Roles.MINTER_ROLE, owner);

        // Минтим два токена (0 и 1)
        erc721.mint(userWithToken, "ipfs://token0");
        erc721.mint(userWithToken, "ipfs://token1");

        // Деплой AuthTest с адресом ERC721Auth
        authTest = new AuthTest(address(erc721));
    }

    function test_ParticipationAllowedWithToken() public {
        // Переходим от имени userWithToken
        vm.prank(userWithToken);
        authTest.partifipate();

        // Проверим, что участие зарегистрировано
        // нельзя напрямую проверить приватный mapping, но отсутствие revert — уже успех
        assertTrue(true); 
    }

    function test_RevertWithoutToken() public {
        vm.prank(userWithoutToken);
        vm.expectRevert(AuthTest.UserDontHaveToken.selector);
        authTest.partifipate();
    }

    function test_RevertWithWrongTokenId() public {
        // Create a user who only has a "wrong" token (not token 0 or 1)
        address userWithWrongToken = address(0x3);
        
        // Mint token 2 to this user (AuthTest only accepts tokens 0 and 1)
        erc721.mint(userWithWrongToken, "ipfs://token2"); // tokenId = 2

        // Try to participate with user who only has token 2 (wrong token)
        vm.prank(userWithWrongToken);
        vm.expectRevert(AuthTest.UserDontHaveToken.selector);
        authTest.partifipate();
    }
}