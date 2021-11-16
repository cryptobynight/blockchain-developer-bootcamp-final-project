// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';
import './libraries/Counters.sol';

contract ERC721 is ERC165, IERC721 {

    using SafeMath for uint256;
    using Counters for Counters.Counter;

    mapping(uint256 => address) private tokenOwner;
    mapping(address => Counters.Counter) private ownerTokenCount;
    // mapping(uint256 => address) private approvals;

    constructor() {
        registerInterface(bytes4(
            keccak256('balanceOf(bytes4)')^keccak256('ownerOf(bytes4)')^keccak256('transferFrom(bytes4)')
        ));
    }

    function balanceOf(address _owner) public view override returns (uint256) {
        require(_owner != address(0), "Can't be the zero address.");
        return ownerTokenCount[_owner].current();
    }

    function ownerOf(uint256 _tokenId) public view override returns (address) {
        require(tokenOwner[_tokenId] != address(0), "NFT can't be owned by zero address.");
        return tokenOwner[_tokenId];
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) override public {
        _transferFrom(_from, _to, _tokenId);
    }

    // function approve(address _to, uint256 _tokenId) public {
    //     address owner = ownerOf(_tokenId);
    //     require(_to != owner, "Approval can't be granted to owner.");
    //     require(msg.sender == owner, "Current msg.sender is not the owner.");
    //     approvals[_tokenId] = _to;

    //     emit Approval(owner, _to, _tokenId);
    // }

    //mark as virtual because we will be overriding from the enumerable contract
    function _mint(address _to, uint256 _tokenId) internal virtual {
        require(_to != address(0), "NFT can't mint to zero address.");
        require(!_exists(_tokenId), "Token is already minted!");
        
        tokenOwner[_tokenId] = _to;
        ownerTokenCount[_to].increase();
        
        emit Transfer(address(0), _to, _tokenId);
    }

    function _transferFrom(address _from, address _to, uint256 _tokenId) internal virtual {
        require(_to != address(0), "NFT can't transfer to zero address.");
        require(ownerOf(_tokenId) == _from, "_from address is not the owner of the token.");

        ownerTokenCount[_from].decrease();
        ownerTokenCount[_to].increase();
        tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function _exists(uint256 _tokenId) internal view returns (bool) {
        address owner = tokenOwner[_tokenId];
        return owner != address(0);
    }

}