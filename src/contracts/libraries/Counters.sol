/// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './SafeMath.sol';

/// @title Counter library
/// @notice Provides counters that can only be incremented or decremented by one
/// @author Matt Condon (@shrugs)

library Counters {

    using SafeMath for uint256;

    struct Counter {
        uint256 count;
    }

    /// @notice Returns current value of a count
    /// @param counter The number to be returned as a uint256
    /// @return Current count number
    function current(Counter storage counter) internal view returns (uint256) {
        return counter.count;
    }

    /// @notice Always increases by 1
    /// @dev This increment can skip the SafeMath overflow check to save gas because 
    /// it's not possible to overflow a 256 bit integer with increments of 1
    /// @param counter Number for target increase
    function increase(Counter storage counter) internal {
        counter.count = counter.count += 1;
    }

    /// @notice Always decreases by 1
    /// @param counter Number for target decrease
    function decrease(Counter storage counter) internal {
        counter.count = counter.count.sub(1);
    }

}