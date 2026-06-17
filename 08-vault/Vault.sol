// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface Iethernaut {
    function unlock(bytes32) external;
}

contract VaultSolve {
    Iethernaut target = Iethernaut(0x093A2CC166EA01a066b67A5ca0aE31a7322Df45E);
    function unlockVault(bytes32 val) public {
        target.unlock(val);
    }
}