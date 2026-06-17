# 9. King

## Goal
Take the throne and keep anyone else, including the level itself, from reclaiming it.

## Vulnerability
The King contract sends the prize to the current king with a plain `transfer`/low-level send when a new king pays up. Whoever is king receives that payout. If the king is a contract that rejects incoming ETH, the payout reverts, which reverts the whole `receive`, so no one can ever become king again. The throne is permanently locked to that contract.

## Exploit
See [`King.sol`](./King.sol). The attacker contract claims the throne by paying the prize, then reverts on any incoming ETH:

Once this contract is king, the level's attempt to pay it back when reclaiming the throne hits the reverting `receive`, the transaction fails, and the contract stays king.

## Takeaway
Don't make state changes depend on a successful push of ETH to an arbitrary address, since the recipient can be a contract that reverts. Prefer the pull-payment pattern, where users withdraw funds themselves, so one malicious recipient can't block the whole contract. This is the same denial-of-service risk behind many stuck-funds bugs.