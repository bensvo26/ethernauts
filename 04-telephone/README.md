# 4. Telephone

## Goal
Claim ownership of the contract.

## Vulnerability
The `changeOwner` function authorizes the caller using `tx.origin != msg.sender`. `tx.origin` is the original externally-owned account that started the transaction, while `msg.sender` is the immediate caller. When you call through an intermediary contract, these differ, so the check passes and ownership transfers.

## Exploit
See [`Telephone.sol`](./Telephone.sol). The attacker contract calls `changeOwner` on your behalf, so `msg.sender` is the contract while `tx.origin` is your wallet:

Because the call is routed through the contract, `tx.origin` (your EOA) and `msg.sender` (the attack contract) are different, satisfying the condition and making you the owner.

## Takeaway
Never use `tx.origin` for authorization. It breaks the moment a call passes through another contract and enables phishing-style attacks. Use `msg.sender` to authenticate the immediate caller.