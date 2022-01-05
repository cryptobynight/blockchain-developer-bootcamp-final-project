# Design Patterns
## Inheritance and Interfaces
* The main contract `Diamonds` inherits from a connector contract and the project is set up using multi-level inheritance
* * This structure makes the project more scalable and developer-friendly
* An `interfaces` folder was set up to include IERC165, IERC721, IERC721Enumerable and IERC721Metadata
* A `libraries` folder was set up to inherit SafeMath and Counters and the OpenZeppelin library is also used
## Access Control Design Patterns
* OpenZeppelin's `Ownable` is imported and `onlyOwner` is used in the `setCompleted` and `upgrade` functions in the `Migrations` contract
* OpenZeppelin's `Ownable` is set up to be used in the `mint` function in the main `Diamonds` contract (simply add `onlyOwner` as a modifier to restrict minting to owner of the contract)
* * This was originally implemented but removed for the demo version since it's more fun to have public minting
## Upgradable Contracts
* An `upgrade` function was added to the `Migrations` contract
