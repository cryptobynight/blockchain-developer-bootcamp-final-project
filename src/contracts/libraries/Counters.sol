// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import './SafeMath.sol';

library Counters {

    using SafeMath for uint256;

    struct Counter {
        uint256 count;
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter.count;
    }

    function increase(Counter storage counter) internal {
        counter.count = counter.count += 1;
    }

    function decrease(Counter storage counter) internal {
        counter.count = counter.count.sub(1);
    }

}