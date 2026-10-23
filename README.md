# Coin Collector - Codédex Lua Final Project

A 2D arcade mini-game built with **Lua** and the **LÖVE2D (Love2D)** framework for the Codédex Lua Final Project.

## 🎮 How to Play
- **Movement:** Use **Arrow Keys** or **WASD** to move the player (Cyan circle).
- **Objective:** Collect the yellow coins to increase your score.
- **Danger:** Avoid colliding with the red bouncing obstacles!
- **Difficulty:** An extra hazard spawns every 5 points.
- **Restart:** Press **R** to restart after Game Over.

## 🛠️ Concepts Demonstrated
- **Variables & Data Types:** Storing position, speeds, game states, and score.
- **Tables (Arrays):** Managing dynamic lists of coins and enemy objects.
- **Functions:** Modular functions for collision detection (`checkCollision`), spawning entities (`spawnCoin`, `spawnEnemy`), and resetting states (`resetGame`).
- **Control Flow & Loops:** Delta time (`dt`) updates, boundary collision bounce physics, and game loop iteration.

## 🚀 How to Run Locally
1. Download and install [LÖVE (Love2D)](https://love2d.org/).
2. Drag this project folder directly onto `love.exe` or press `Ctrl + Shift + B` in VS Code!
