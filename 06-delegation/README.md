# 6. Delegation

## Goal
Claim ownership of the contract.

## Vulnerability
The `Delegation` contract's `fallback` forwards any unmatched call to the `Delegate` contract using `delegatecall`. With `delegatecall`, the called contract's code runs in the *caller's* storage context. So when `Delegate.pwn()` executes, it writes `owner = msg.sender` into `Delegation`'s storage, not `Delegate`'s. Since `pwn()` has no access control, anyone can trigger it and become owner.

## Exploit
Two console commands. First get the function selector for `pwn()`, then send it as raw calldata so the `fallback` fires and delegates into `Delegate.pwn()`:

```javascript
const data = web3.eth.abi.encodeFunctionSignature("pwn()")
```

```javascript
await contract.sendTransaction({ from: player, data: data })
```

Because no real function on `Delegation` matches that selector, `fallback` runs, `delegatecall`s into `Delegate`, and `pwn()` overwrites `owner` in `Delegation`'s storage with your address.

## Takeaway
`delegatecall` executes external code against your own storage. Forwarding arbitrary calldata into a `delegatecall` lets a caller run any of the target's functions in your context, which can clobber critical state like `owner`. Never expose an unguarded `delegatecall` to user-controlled input.