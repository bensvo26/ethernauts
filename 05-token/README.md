# 5. Token

## Goal
Steal tokens so your balance increases beyond the starting 20.

## Vulnerability
The `transfer` function guards with `require(balances[msg.sender] - _value >= 0)`. Since `balances` holds unsigned integers, this check can never fail. This is because subtracting more than you own underflows and wraps to a huge number instead of going negative. The contract compiles with Solidity ^0.6.0, which has no built-in underflow protection.

## Exploit
Transfer more than your balance to any non-self address:

```javascript
await contract.transfer("0x0000000000000000000000000000000000000000", 21)
```

Starting with 20 tokens, `balances[msg.sender]` becomes `20 - 21`, which underflows to `2^256 - 1`. The require passes and you end up holding nearly the max uint value.

## Takeaway
Before Solidity 0.8.0, arithmetic didn't revert on underflow or overflow. Use a recent compiler version, or SafeMath on older ones, to guard against these bugs.