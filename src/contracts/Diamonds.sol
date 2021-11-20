// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './ERC721Connector.sol';

contract Diamonds is ERC721Connector {

    using SafeMath for uint256;
    using Counters for Counters.Counter;
    struct Diamond {
        string chemistry;
        uint256 diamondId;
    }

    Diamond[] public diamonds;
    uint256 public constant MINING_LIMIT = 7777;
    Counters.Counter public miningCounter;

    mapping(string => bool) diamondExists;

    function mint(string memory _diamond) public onlyOwner {
        require(miningCounter.current() < MINING_LIMIT, "Total cap reached.");
        require(!diamondExists[_diamond], "Sorry, that token already exists.");

        miningCounter.increase();

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