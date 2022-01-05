# Contract Security
## SWC-100: Function Default Visibility
* Function visibility type is specified with `external`, `public`, `internal` or `private` to reduce the attack surface of contracts
## SWC-101: Integer Overflow and Underflow
* Created libraries `SafeMath` and `Counters` to protect against overflow/underflow
* I'm aware that `SafeMath` isn't needed as of Solidity `0.8.0` but I wanted to build the functionality myself
## SWC-103: Floating Pragma
* Specific compiler pragma `0.8.10` is used in contracts to avoid introducing bugs that affect the contract system negatively
## Proper Use of Require, Assert and Revert
* The project is compliant with ERC-721 and ERC-165 Standards for all implemented functions, with many `require` checks in place
* * For example, require statements are used in the `transferFrom` function in the `ERC721` contract to ensure only the owner can send their tokens
* * Some functions in the interface have been commented out since they are not in use - these will be completed later to ensure full compliance with the Standards
## Use Modifiers Only for Validation
* All modifiers in the smart contracts validate data with `require` statements