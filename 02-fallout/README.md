# 2. Fallout

## Goal
Claim ownership of the contract.

## Vulnerability
The function meant to be the constructor is misspelled `Fal1out` (a "1" instead of an "l"), so it compiles as an ordinary public function rather than a constructor. It was never run at deployment, the owner was never set, and anyone can call it to become owner.

## Exploit
​```javascript
// call the misnamed "constructor" directly to claim ownership
await contract.Fal1out()
​```

## Takeaway
This level predates Solidity 0.4.22, when constructors were defined by naming a function after the contract. A single typo left it callable by anyone. The `constructor` keyword in modern Solidity removes this whole class of mistake.