# Feature branch sub-movement
Work on submarine movement using rigidbody and physics engine.
Forces applied with *add_force* et *apply_torque_impulse* functions in *_integrate_forces*.

## Input map
- Z : go down
- S : go up
- Q / D : turn left / right

The following just need to be pressed once
- 1 : Full stop. Kill the submarine thrusters and let the sub come to an halt with damp
- 2 : Low thrust
- 3 : Medium thrust
- 4 : Full speed
