/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/// @title ERC-721 Non-Fungible Token Standard
/// @dev See https://eips.ethereum.org/EIPS/eip-721
/// @author William Entriken, Dieter Shirley, Jacob Evans, Nastassia Sachs

interface IERC721Metadata {
    /// @notice A descriptive name for a collection of NFTs in this contract
    function name() external view returns (string memory _name);

    /// @notice An abbreviated name for NFTs in this contract
    function symbol() external view returns (string memory _symbol);
}