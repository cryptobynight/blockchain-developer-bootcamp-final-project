/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './ERC721Metadata.sol';
import './ERC721Enumerable.sol';
import '../../node_modules/@openzeppelin/contracts/access/Ownable.sol';

/// @title Connector contract
/// @notice Links key contracts into main contract - ERC721 is inherited through Enumerable
/// @author CryptoByNight

contract ERC721Connector is ERC721Metadata, ERC721Enumerable, Ownable {

    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol) {

    }

}