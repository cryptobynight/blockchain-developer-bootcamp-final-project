// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './interfaces/IERC165.sol';

contract ERC165 is IERC165 {

    mapping(bytes4 => bool) private supportedInterfaces;

    constructor() {
        registerInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    }

    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return supportedInterfaces[interfaceId];
    }

    function registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "Invalid request.");
        supportedInterfaces[interfaceId] = true;
    }

}