# Lovely Snake
Written By Calum Lindsay 
It is a very simple implementation of the classic snake game I made to try out the LÖVE 2D Game engine. I also made a simple rng "library" called xorshift for spawning the food.

## How to run it
You will need the LÖVE Engine to run it which you can get [here](https://love2d.org "LÖVE 2D's Homepage"). Download any of the zipped versions, extract them and drag the folder containing the snake source code onto the "love.exe" executable.

## Controls
- Arrow keys or WASD to change direction
- r to reset
- p to pause
- 3 to cheat (snake grows without eating)

## Possible future improvements / problems
- Add win condition and scores
- Add a game over message
- Add a pause menu
- Allow arbitrary window dimensions
- Use a random value for seeding the rng such as the current time
- Food should not spawn inside snake
- Food could respawn as soon as it's eaten by the head
- Larger border on bottom and right than top and left
- Snake update function could be more efficient