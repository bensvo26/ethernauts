# 11. Elevator

## Goal
Reach the top level by setting `top` to true.

## Vulnerability
The `goTo` function calls `isLastFloor` twice on `msg.sender`, trusting the caller's own `Building` implementation. It first checks `isLastFloor(_floor)` and proceeds only if it returns false, then sets `top = isLastFloor(_floor)` using a second call to the same function. Nothing forces those two calls to return the same value, so a malicious `Building` can answer false then true.

## Exploit
See [`Elevator.sol`](./Elevator.sol). The attack implements the `isLastFloor` function as a `Building` interface. The first call in `isLastFloor` will always return false. Any sequential calls will return true. When `solve` is called, the floor 10 is passed into the `goTo` function, which requires `isLastFloor` (implemented by `Building`) returns false so the function continues past its check, then the `top` variable is set to another call to the `isLastFloor`, which will be true on the second call.

## Takeaway
Do not assume that interfaces are implemented how you would expect. Even if functions are named a certain way, they might have unexpected results. Always check how a function in an external interface is implemented before calling it in your own contract.