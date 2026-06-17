# Ethernaut Solutions

My solutions and writeups for [OpenZeppelin's Ethernaut](https://ethernaut.openzeppelin.com/), a Web3/Solidity security wargame where each level is a vulnerable smart contract to exploit.

## Overview

Ethernaut is a set of intentionally broken smart contracts. Each level presents a contract with a security flaw, and the goal is to identify and exploit that flaw to take ownership, drain funds, or otherwise break the contract's intended behavior. This repo contains my solutions along with writeups explaining each vulnerability and the resulting solution.

## What I Practiced

Working through these levels covered a range of common smart contract vulnerability classes, including re-entrancy, access control flaws, storage and privacy misconceptions, and unsafe handling of external calls. Each solution reinforced not just how to exploit a bug, but why it exists and how to write contracts that avoid it.

## Structure

Each level has its own solution and a short writeup describing the vulnerability, the exploit, and the recommended fix.

## Key Takeaways

These challenges made clear how small mistakes in Solidity can become serious security holes. Ordering of state updates, function and variable visibility, and trust in external calls all turned out to matter far more than they appear at first glance. Working through them built a habit of thinking about contracts from an attacker's perspective.
