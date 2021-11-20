/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/// @title SafeMath library
/// @notice Provides a safe way to do math in contracts to prevent overflow - based on OpenZeppelin's version of the library
/// and it should also be noted this is a practice exercise since Solidity 0.8 compiler includes overflow checks
/// @author CryptoByNight & credit: OpenZeppelin

library SafeMath {

    /// @notice Simple function to add two numbers and return the sum
    function add(uint256 a, uint256 b) internal pure returns(uint256) {
        uint256 x = a + b;
        require(x >= a, 'Addition overflow error via SafeMath');
        return x;
    }

    /// @notice Simple function to subtract one number from another and return the difference
    function sub(uint256 a, uint256 b) internal pure returns(uint256) {
        require(b <= a, 'Subtraction overflow error via SafeMath');
        return a - b;
    }

    /// @notice Simple function to multiply two numbers and return the product
    function mult(uint256 a, uint256 b) internal pure returns(uint256) {
        if(a == 0) { return 0; }
        uint256 x = a * b;
        require(x / a == b, 'Multiplication overflow error via SafeMath');
        return x;
    }

    /// @notice Simple function to divide one number by another and return the quotient
    function div(uint256 a, uint256 b) internal pure returns(uint256) {
        require(b > 0, 'Division overflow error via SafeMath');
        return a / b;
    }

    /// @notice simple mod function to return the modular
    function mod(uint256 a, uint256 b) internal pure returns(uint256) {
        require(b != 0, 'Mod zero error via SafeMath');
        return a % b;
    }

}