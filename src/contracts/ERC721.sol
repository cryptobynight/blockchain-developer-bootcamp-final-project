/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './ERC165.sol';
import './interfaces/IERC721.sol';
import './libraries/Counters.sol';

/// @title EIP-721 NFT Standard
/// @notice Based on the standard interface for non-fungible tokens, also known as deeds
/// @author CryptoByNight

contract ERC721 is ERC165, IERC721 {

    using SafeMath for uint256;
    using Counters for Counters.Counter;

    mapping(uint256 => address) private tokenOwner;
    mapping(address => Counters.Counter) private ownerTokenCount;

    constructor() {
        registerInterface(bytes4(
            keccak256('balanceOf(bytes4)')^keccak256('ownerOf(bytes4)')^keccak256('transferFrom(bytes4)')
        ));
    }

    /// @notice Get total tokens owned by user
    /// @param _owner Owner's address
    /// @return The current token count for the owner
    function balanceOf(address _owner) public view override returns (uint256) {
        require(_owner != address(0), "Can't be the zero address.");
        return ownerTokenCount[_owner].current();
    }

    /// @notice Get owner of a specific token
    /// @param _tokenId Token ID to identify diamond
    /// @return Address of owner of the diamond
    function ownerOf(uint256 _tokenId) public view override returns (address) {
        require(tokenOwner[_tokenId] != address(0), "NFT can't be owned by zero address.");
        return tokenOwner[_tokenId];
    }

    /// @notice Transfer token from one user to another
    /// @param _from From address
    /// @param _to To address to send the token
    /// @param _tokenId Token number to send
    function transferFrom(address _from, address _to, uint256 _tokenId) override public {
        _transferFrom(_from, _to, _tokenId);
    }

    /// @notice Mint new token
    /// @dev Mark as virtual because we will be overriding from the enumerable contract
    /// @param _to Address to mint token to
    /// @param _tokenId ID of token to be minted
    function _mint(address _to, uint256 _tokenId) internal virtual {
        require(_to != address(0), "NFT can't mint to zero address.");
        require(!_exists(_tokenId), "Token is already minted!");
        
        tokenOwner[_tokenId] = _to;
        ownerTokenCount[_to].increase();
        
        emit Transfer(address(0), _to, _tokenId);
    }

    /// @notice Transfer token from one user to another
    /// @dev Internal function to increase security as it's called from a public function
    /// @param _from From address
    /// @param _to To address to send the token
    /// @param _tokenId Token number to send
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal virtual {
        require(_to != address(0), "NFT can't transfer to zero address.");
        require(ownerOf(_tokenId) == _from, "_from address is not the owner of the token.");

        ownerTokenCount[_from].decrease();
        ownerTokenCount[_to].increase();
        tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    /// @notice Check if token already exists
    /// @param _tokenId ID of token to check
    /// @return True if owner address is not the zero address
    function _exists(uint256 _tokenId) internal view returns (bool) {
        address owner = tokenOwner[_tokenId];
        return owner != address(0);
    }

}