// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// OpenZeppelin импорты
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

// Локальный импорт ролей
import {Roles} from "./Roles.sol";

contract ERC721Auth is ERC721, AccessControl {
    uint256 public currentTokenId = 0;

    // Хранение кастомных URI
    mapping(uint256 => string) private _tokenUris;

    constructor() ERC721("MyToken", "MTK") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    // Минт одного токена с кастомным URI
    function mint(address to, string memory _tokenUri) external onlyRole(Roles.MINTER_ROLE) {
        uint256 newTokenId = currentTokenId;
        currentTokenId++;

        _safeMint(to, newTokenId);
        _tokenUris[newTokenId] = _tokenUri;
    }

    // Helper function to check if token exists
    function _exists(uint256 tokenId) internal view returns (bool) {
        return _ownerOf(tokenId) != address(0);
    }

    // Обновление URI токена
    function updateTokenUri(uint256 tokenId, string memory _newTokenUri) external onlyRole(Roles.MANAGER_ROLE) {
        require(_exists(tokenId), "Token does not exist");
        _tokenUris[tokenId] = _newTokenUri;
    }

    // Проверка, владеет ли пользователь токеном
    function hasToken(address user, uint256 tokenId) external view returns (bool) {
        return _exists(tokenId) && ownerOf(tokenId) == user;
    }

    // Возврат кастомного URI
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return _tokenUris[tokenId];
    }

    // Поддержка интерфейсов
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}