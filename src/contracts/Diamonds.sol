/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/// @title Main NFT contract
/// @notice Generative NFT marketplace to mint and send
/// @author CryptoByNight
/// @dev This is the main contract, with inheritance from Connector and other nested contracts like ERC721, Enumerable and Metadata

import './ERC721Connector.sol';

contract Diamonds is ERC721Connector {

    using SafeMath for uint256;
    using Counters for Counters.Counter;
    struct Diamond {
        string chemistry;
        uint256 diamondId;
    }

    /// @notice Array of diamonds (NFTs) 
    Diamond[] public diamonds;
    /// @notice Maximum supply constant
    uint256 public constant MINING_LIMIT = 7777;
    /// @notice Counter to track against maximum supply limit
    Counters.Counter public miningCounter;

    mapping(string => bool) diamondExists;

    /// @notice Main minting function with ownable modifier from OpenZeppelin
    /// @param _diamond String for randomly generated diamond to be minted - generated on front end and passeed through
    /// @dev Contract is set up to add onlyOwner to this function if you want to limit the mining function to the owner.
    /// For this version, we left it so anyone can mint because it's more fun :)
    function mint(string memory _diamond) public {
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

    /// @notice Constructor for token name and symbol
    constructor() ERC721Connector('Diamond Hands', 'DH') {}

}