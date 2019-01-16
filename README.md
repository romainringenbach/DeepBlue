# Feature branch procedural-mines
Tried some stuff to procedurally place mines in a given zone, using Poisson distribution, where every mine is randomly placed in an area with constraints :
- The center of the mines must be separated by a distance in (radius, 2*radius);
- The mines must be regularly distributed in the area

There is also an orbital cam.

## Input map
- Z : forward
- S : backward
- Q / D : Strafe left / right
- A / E : Go Up / Down

- Arrow keys
    - Left / Right : orbit around sphere (equivalent to yaw on a plane)
    - Up / Down : orbit up and down around sphere (equivalent to pitch)
