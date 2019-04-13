# Lovely Snake
Written By Calum Lindsay.  
 It is a very simple implementation of the classic snake game I made to try out the LÖVE 2D Game engine. I also made a simple rng "library" called xorshift for spawning the food.

## How to run it
You will need the LÖVE Engine to run it which you can get [here](https://love2d.org "LÖVE 2D's Homepage"). Download any of the zipped versions, extract them and drag the folder containing Lovely Snake's source code onto the "love.exe" executable.

## Controls
- Arrow keys or WASD to change direction
- r to reset
- ESC to pause
- 3 to cheat (snake grows without eating)

## Possible future improvements / problems
- [x] Add win condition and scores
- [x] Add a game over message
- [x] Add a pause menu
- [ ] Allow arbitrary window dimensions
- [x] Use a random value for seeding the rng such as the current time
- [x] Food should not spawn in a space occupied by the snake
- [ ] Food could respawn as soon as it's eaten by the head
- [x] Border on bottom, right, top and left should be the same size
- [ ] Snake update function could be more efficient