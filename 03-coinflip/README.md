# 3. CoinFlip

## Goal
Win the coin flip 10 times in a row by guessing the outcome correctly each time.

## Vulnerability
The "random" result is fully deterministic and derived from on-chain data anyone can read. It computes the flip from `blockhash(block.number - 1)` divided by a fixed `FACTOR`, with no private entropy. An attacker can run the exact same calculation in their own contract within the same block and always submit the correct guess.

## Exploit
See [`CoinFlip.sol`](./CoinFlip.sol). The attacker contract recomputes the flip using the same block hash and factor, then calls `flip` with the known answer.

Because the attack contract and the target read the same `blockhash` in the same transaction, the guess always matches. Call this 10 times across separate blocks to reach 10 consecutive wins.

## Takeaway
Block values like `blockhash`, `block.timestamp`, and `block.number` are not secret and can be read or reproduced by any contract, so they can't be used as randomness. Secure randomness on-chain requires an external source such as a verifiable random function, such as a Chainlink VRF, or a commit-reveal scheme.
