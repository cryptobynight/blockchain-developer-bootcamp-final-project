// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is ERC721, IERC721Enumerable {

    uint256[] private tokenList;

    //TokenId to tokenList position
    mapping(uint256 => uint256) private tokenListIndex;
    //Owner to list of all owned token Ids
    mapping(address => uint256[]) private ownedTokens;
    //TokenId to index of the owner's token list
    mapping(uint256 => uint256) private ownedTokenIndex;

    constructor() {
        registerInterface(bytes4(
            keccak256('totalSupply(bytes4)')^keccak256('tokenByIndex(bytes4)')^keccak256('tokenOfOwnerByIndex(bytes4)')
        ));
    }

    function totalSupply() public view override returns (uint256) {
        return tokenList.length;
    }

    function tokenByIndex(uint256 _index) public view override returns (uint256) {
        require(_index < totalSupply(), "Index is out of bounds.");
        return tokenList[_index];
    }

    function tokensOfOwner(address _owner) public view returns (uint256[] memory) {
        return ownedTokens[_owner];
    }

    function tokenOfOwnerByIndex(address _owner, uint256 _index) public view override returns (uint256) {
        require(_index < balanceOf(_owner), "Owner index is out of bounds.");
        return ownedTokens[_owner][_index];
    }

    function _mint(address _to, uint256 _tokenId) internal override (ERC721) {
        //Super allows us to grab the mint function from ERC721 contract
        super._mint(_to, _tokenId);
        // Need to add tokens to owner and also add to total supply
        _addTokensToSupplyAndIndex(_tokenId);
        _addTokensToOwner(_to, _tokenId);
    }

    function _transferFrom(address _from, address _to, uint256 _tokenId) internal override (ERC721) {
        super._transferFrom(_from, _to, _tokenId);

        _updateTokensToOwner(_from, _to, _tokenId);
    }

    // Add tokens to the tokenList array and set the index location for the newly added token
    function _addTokensToSupplyAndIndex(uint256 _tokenId) private {
        tokenListIndex[_tokenId] = tokenList.length;
        tokenList.push(_tokenId);
    }

    function _addTokensToOwner(address _to, uint256 _tokenId) private {
        // ownedTokenIndex tokenId needs to be set to the address of the ownedTokens position
        ownedTokenIndex[_tokenId] = ownedTokens[_to].length;
        // Need to add new token for owner's ownedTokens
        ownedTokens[_to].push(_tokenId);
    }

    function _updateTokensToOwner(address _from, address _to, uint256 _tokenId) private {
        //Need to remove from sender
        if (ownedTokens[_from].length > 1) {
            ownedTokens[_from][ownedTokenIndex[_tokenId]] = ownedTokens[_from][ownedTokens[_from].length - 1];
        }
        ownedTokens[_from].pop();
        
        // ownedTokenIndex tokenId needs to be set to the address of the ownedTokens position
        ownedTokenIndex[_tokenId] = ownedTokens[_to].length;
        // Need to add new token for owner's ownedTokens
        ownedTokens[_to].push(_tokenId);
        
    }

}