# Contract Security
## SWC-101: Integer Overflow and Underflow
* Created libraries `SafeMath` and `Counters` to protect against overflow/underflow
## SWC-103: Floating Pragma
* Specific compiler pragma `0.8.10` is used in contracts to avoid introducing bugs that affect the contract system negatively
## SWC-105: Unprotected Ether Withdrawal
* The `transferFrom` function in the `ERC721` contract is protected with `require` statements as per ERC-721 standards to prevent incorrect withdrawals (NFT transfers in this case)
* * The `mint` function in the `Diamonds` contract is set up to use OpenZeppelin's `Ownable` contract with the `onlyOwner` modifier - this modifier isn't implemented in the live contract because I thought it would be more fun to have multiple accounts minting
## Proper Use of Require, Assert and Revert
* The project is compliant with ERC-721 and ERC-165 Standards for all implemented functions, with many `require` checks in place
* * Some functions in the interface have been commented out since they are not in use - these will be completed later to ensure full compliance with the Standards
## Use Modifiers Only for Validation
* All modifiers in the smart contracts validate data with `require` statements
## Pull Over Push
Prioritise receiving contract calls over making contract calls
All functions that modify state are based on receiving calls rather than making contract calls