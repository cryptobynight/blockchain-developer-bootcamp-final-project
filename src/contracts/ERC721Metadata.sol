/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './interfaces/IERC721Metadata.sol';
import './ERC165.sol';

/// @title Metadata contract
/// @notice Optional extension for ERC-721 Standard
/// @author CryptoByNight

contract ERC721Metadata is IERC721Metadata, ERC165 {

    string private _name;
    string private _symbol;

    constructor(string memory named, string memory symbolised) {
        registerInterface(bytes4(
            keccak256('name(bytes4)')^keccak256('symbol(bytes4)')
        ));
        
        _name = named;
        _symbol = symbolised;
    }

    /// @return Name of token passed in from constructor and main contract
    function name() external view override returns(string memory) {
        return _name;
    }

    /// @return Symbol of token passed in from constructor and main contract
    function symbol() external view override returns(string memory) {
        return _symbol;
    }

}