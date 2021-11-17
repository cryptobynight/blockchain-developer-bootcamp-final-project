// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns(uint256) {
        uint256 x = a + b;
        require(x >= a, 'Addition overflow error via SafeMath');
        return x;
    }

    function sub(uint256 a, uint256 b) internal pure returns(uint256) {
        require(b <= a, 'Subtraction overflow error via SafeMath');
        return a - b;
    }

    function mult(uint256 a, uint256 b) internal pure returns(uint256) {
        if(a == 0) { return 0; }
        uint256 x = a * b;
        require(x / a == b, 'Multiplication overflow error via SafeMath');
        return x;
    }

    function div(uint256 a, uint256 b) internal pure returns(uint256) {
        require(b > 0, 'Division overflow error via SafeMath');
        return a / b;
    }

    function mod(uint256 a, uint256 b) internal pure returns(uint256) {
        require(b != 0, 'Mod zero error via SafeMath');
        return a % b;
    }

}