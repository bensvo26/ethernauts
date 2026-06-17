# 8. Vault

## Goal
Unlock the vault by setting `locked` to false.

## Vulnerability
The vault is unlocked by passing the correct `password` to `unlock`. The password is stored in a state variable marked `private`, but `private` only restricts access from other Solidity contracts. It does nothing to hide the value on-chain. Every storage slot is publicly readable by anyone reading the blockchain directly.

The contract layout puts `locked` (a bool) in slot 0 and `password` (a bytes32) in slot 1. Read slot 1 and you have the password.

## Exploit
See [`Vault.sol`](./Vault.sol). Read the password from storage, then pass it to your solver:

1. In the console, read slot 1:

```javascript
const password = await web3.eth.getStorageAt(instance, 1)
```

2. Call `unlockVault(password)` (or `contract.unlock(password)` directly). The contract checks it against the stored value, they match, and `locked` flips to false.

## Takeaway
`private` is a Solidity visibility keyword, not a security feature. All contract storage is public on-chain regardless of visibility. Never store secrets, passwords, or keys in contract storage expecting them to stay hidden.