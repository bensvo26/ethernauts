# 10. Reentrancy

## Goal
Drain all the funds from the contract.

## Vulnerability
The `withdraw` function sends ETH to the caller before it updates the caller's recorded balance. Because the external call happens first, a malicious contract's `receive` function can call back into `withdraw` again while its balance still shows as funded. Each re-entry passes the balance check and pulls more ETH, repeating until the contract is empty.

## Exploit
See [`Reentrancy.sol`](./Reentrancy.sol). The attack donates a small amount to establish a balance, then calls `withdraw`. The payout triggers the attacker's `receive`, which re-enters `withdraw` before the first call finishes:

Each re-entry runs before the balance is zeroed, so the loop keeps draining until the contract holds nothing. The `receive` caps each withdrawal at the contract's remaining balance to cleanly empty the last partial chunk.

## Takeaway
Follow the checks-effects-interactions pattern: update state (zero the balance) before making external calls, so a re-entrant call sees the updated state and fails the check. A reentrancy guard (mutex modifier) is a second line of defense. This bug class is behind some of the largest exploits in DeFi history, including the original DAO hack.