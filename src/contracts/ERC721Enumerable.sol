/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

/// @title Enumerable contract
/// @notice Optional extension for ERC-721 Standard
/// @author CryptoByNight

contract ERC721Enumerable is ERC721, IERC721Enumerable {

    uint256[] private tokenList;

    /// @dev TokenId to tokenList position
    mapping(uint256 => uint256) private tokenListIndex;
    /// @dev Owner to list of all owned token Ids
    mapping(address => uint256[]) private ownedTokens;
    /// @dev TokenId to index of the owner's token list
    mapping(uint256 => uint256) private ownedTokenIndex;

    constructor() {
        registerInterface(bytes4(
            keccak256('totalSupply(bytes4)')^keccak256('tokenByIndex(bytes4)')^keccak256('tokenOfOwnerByIndex(bytes4)')
        ));
    }

    /// @notice Total supply of tokens 
    /// @return Total supply of tokens
    function totalSupply() public view override returns (uint256) {
        return tokenList.length;
    }

    /// @dev Retrieve token based on position in array
    /// @param _index Array index of token
    /// @return Token number
    function tokenByIndex(uint256 _index) public view override returns (uint256) {
        require(_index < totalSupply(), "Index is out of bounds.");
        return tokenList[_index];
    }

    /// @notice List all tokens of owner from address
    /// @param _owner Address of owner
    /// @return Array of owned tokens
    function tokensOfOwner(address _owner) public view returns (uint256[] memory) {
        return ownedTokens[_owner];
    }

    /// @notice Find token of an owner by index in their list of owned tokens
    /// @param _owner Address of owner
    /// @param _index Array index of owned token from owner's token index
    /// @return Token ID for owned token
    function tokenOfOwnerByIndex(address _owner, uint256 _index) public view override returns (uint256) {
        require(_index < balanceOf(_owner), "Owner index is out of bounds.");
        return ownedTokens[_owner][_index];
    }

    /// @notice Override mint function to update token supply and owner
    /// @param _to Address to mint token
    /// @param _tokenId Token ID to mint
    /// @inheritdoc ERC721
    function _mint(address _to, uint256 _tokenId) internal override (ERC721) {
        //Super allows us to grab the mint function from ERC721 contract
        super._mint(_to, _tokenId);
        // Need to add tokens to owner and also add to total supply
        _addTokensToSupplyAndIndex(_tokenId);
        _addTokensToOwner(_to, _tokenId);
    }

    /// @notice Override transfer function to update owner and token data
    /// @param _from Address that is sending token
    /// @param _to Address to send token
    /// @param _tokenId Token ID to transfer
    /// @inheritdoc ERC721
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal override (ERC721) {
        super._transferFrom(_from, _to, _tokenId);

        _updateTokensToOwner(_from, _to, _tokenId);
    }

    /// @notice Add tokens to the tokenList array and set the index location for the newly added token
    /// @param _tokenId Token ID to be added to supply and index
    function _addTokensToSupplyAndIndex(uint256 _tokenId) private {
        tokenListIndex[_tokenId] = tokenList.length;
        tokenList.push(_tokenId);
    }

    /// @notice Add tokens to owner so we can track and call to front end
    /// @param _to Address token is being sent
    /// @param _tokenId Token ID for token being sent
    function _addTokensToOwner(address _to, uint256 _tokenId) private {
        // ownedTokenIndex tokenId needs to be set to the address of the ownedTokens position
        ownedTokenIndex[_tokenId] = ownedTokens[_to].length;
        // Need to add new token for owner's ownedTokens
        ownedTokens[_to].push(_tokenId);
    }

    /// @notice Update tokens of owner for transfers
    /// @param _from Address token is transferred from
    /// @param _to Address where token is being transferred
    /// @param _tokenId Token ID being transferred
    /// @dev This function was created to allow tracking and display of individually owned tokens on the front end
    function _updateTokensToOwner(address _from, address _to, uint256 _tokenId) private {
        /// Need to remove from sender
        if (ownedTokens[_from].length > 1) {
            ownedTokens[_from][ownedTokenIndex[_tokenId]] = ownedTokens[_from][ownedTokens[_from].length - 1];
        }
        ownedTokens[_from].pop();
        
        /// ownedTokenIndex tokenId needs to be set to the address of the ownedTokens position
        ownedTokenIndex[_tokenId] = ownedTokens[_to].length;
        /// Need to add new token for owner's ownedTokens
        ownedTokens[_to].push(_tokenId);
        
    }

}