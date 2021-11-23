/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import '../../node_modules/@openzeppelin/contracts/access/Ownable.sol';

/// @title Migrations contract
/// @notice Contract allows updates and upgrades for migrations
/// @author CryptoByNight

contract Migrations is Ownable {
  uint public last_completed_migration;

  function setCompleted(uint completed) public onlyOwner {
    last_completed_migration = completed;
  }

  /// @dev Make contract upgradable for the owner
  function upgrade(address new_address) public onlyOwner {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }

}
