// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract Diamonds is ERC721Connector {

    struct Diamond {
        string chemistry;
        uint256 diamondId;
    }

    Diamond[] public diamonds;

    mapping(string => bool) diamondExists;

    function mint(string memory _diamond) public onlyOwner {
        require(!diamondExists[_diamond], "Sorry, that token already exists.");

        uint256 _tokenId = diamonds.length;

        Diamond memory diamond = Diamond({
            chemistry: _diamond,
            diamondId: _tokenId
        });

        diamonds.push(diamond);

        _mint(msg.sender, _tokenId);
        diamondExists[_diamond] = true;

    }

    constructor() ERC721Connector('Diamond Hands', 'DH') {}

}