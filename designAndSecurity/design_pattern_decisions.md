# Design Patterns
## Inheritance and Interfaces
* The main contract `Diamonds` inherits from a connector contract and the project is set up using multi-level inheritance
* * Multi-level inheritance increases security but also makes the project more scalable and developer-friendly
* An `interfaces` folder was set up to include IERC165, IERC721, IERC721Enumerable and IERC721Metadata
* A `libraries` folder was set up to inherit SafeMath and Counters and the OpenZeppelin library is also used
## Access Control Design Patterns
* `Ownable` is set up to be used in the `mint` function in the main `Diamonds` contract (simply add onlyOwner as a modifier to restrict minting to owner of the contract)
* Require statements are also used in the `transferFrom` function in the `ERC721` contract to ensure only the owner can send the token
* * Note that according to ERC721 Standards, the owner should also be able to approve another sender to transfer tokens but this functionality has not yet been implemented
## Upgradable Contracts
* An `upgrade` function was added to the `Migrations` contract
