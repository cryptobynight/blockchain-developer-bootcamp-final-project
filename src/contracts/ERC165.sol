/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './interfaces/IERC165.sol';

/// @title ERC-165 Standard
/// @notice Creates a standard method to publish and detect what interfaces a smart contract implements
/// @author CryptoByNight

contract ERC165 is IERC165 {

    mapping(bytes4 => bool) private supportedInterfaces;

    /// @notice Register interface 'fingerprint'
    constructor() {
        registerInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    }

    /// @notice Query if a contract implements an interface
    /// @param interfaceId Registered interface ID
    /// @return True or false if interface is registered and supported
    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return supportedInterfaces[interfaceId];
    }

    /// @notice Register interface
    /// @param interfaceId Interface ID to register
    function registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "Invalid request.");
        supportedInterfaces[interfaceId] = true;
    }

}