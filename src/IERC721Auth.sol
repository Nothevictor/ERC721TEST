// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IERC721Auth {
    /// Минт нового токена
    function mint(address to, string memory _tokenUri) external;

    /// Обновление URI токена
    function updateTokenUri(uint256 tokenId, string memory _newTokenUri) external;

    /// Проверка, владеет ли пользователь токеном
    function hasToken(address user, uint256 tokenId) external view returns (bool);

    /// Получение URI токена
    function tokenURI(uint256 tokenId) external view returns (string memory);

    /// Текущий ID токена (автоинкремент)
    function currentTokenId() external view returns (uint256);
}