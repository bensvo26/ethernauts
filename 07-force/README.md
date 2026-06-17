# 7. Force

## Goal
Make the balance of the contract greater than zero.

## Vulnerability
The `Force` contract has no `payable` functions, no `receive`, and no `fallback`, so normal sends and transfers revert. But Solidity can't actually stop a contract from receiving ETH. `selfdestruct` forcibly sends the destroyed contract's remaining balance to a target address, and the target has no way to reject it. No code runs on the receiving side, so the absence of a payable entry point doesn't matter.

## Exploit
See [`Force.sol`](./Force.sol). Deploy the solver pointed at the `Force` instance, fund it, then self-destruct into the target:

1. Deploy `EthernautSolver` with `other` set to the `Force` instance address.
2. Call `deposit()` with some ETH (e.g. 0.001 ether) to give the solver a balance.
3. Call `solve()`, which runs `selfdestruct(other)` and force-sends that balance into `Force`.

After the self-destruct, the `Force` contract holds a nonzero balance and the level is solved.

## Takeaway
Never rely on the absence of a `receive`/`fallback` to assume a contract can't hold ETH. `selfdestruct` (and block reward / coinbase payments) can force ETH into any address. Don't write logic that depends on `address(this).balance` being zero or matching internal accounting.