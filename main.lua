-- Codédex Lua Final Project: Coin Collector Game
-- Demonstrating: Variables, Tables, Functions, Loops, and Input Handling

local player = {}
local coins = {}
local enemies = {}
local score = 0
local gameOver = false
local windowWidth = 800
local windowHeight = 600

-- Check collision between two circular objects
local function checkCollision(a, b)
    local distance = math.sqrt((a.x - b.x)^2 + (a.y - b.y)^2)
    return distance < (a.radius + b.radius)
end

-- Spawn a new coin at a random location
local function spawnCoin()
    table.insert(coins, {
        x = math.random(50, windowWidth - 50),
        y = math.random(50, windowHeight - 50),
        radius = 12
    })
end

-- Spawn a bouncing enemy
local function spawnEnemy()
    table.insert(enemies, {
        x = math.random(50, windowWidth - 50),
        y = math.random(50, windowHeight - 50),
        radius = 16,
        vx = math.random(-150, 150),
        vy = math.random(-150, 150)
    })
end

-- Reset or start the game
local function resetGame()
    player.x = windowWidth / 2
    player.y = windowHeight / 2
    player.radius = 20
    player.speed = 260

    score = 0
    gameOver = false
    coins = {}
    enemies = {}

    -- Spawn initial coins
    for i = 1, 5 do
        spawnCoin()
    end

    -- Spawn initial enemies
    for i = 1, 3 do
        spawnEnemy()
    end
end

function love.load()
    love.window.setTitle("Codédex Final Project - Coin Collector")
    love.window.setMode(windowWidth, windowHeight)
    math.randomseed(os.time())
    resetGame()
end

function love.update(dt)
    if gameOver then
        if love.keyboard.isDown("r") then
            resetGame()
        end
        return
    end

    -- Player movement (Arrow keys or WASD)
    if love.keyboard.isDown("right", "d") then
        player.x = math.min(windowWidth - player.radius, player.x + player.speed * dt)
    end
    if love.keyboard.isDown("left", "a") then
        player.x = math.max(player.radius, player.x - player.speed * dt)
    end
    if love.keyboard.isDown("down", "s") then
        player.y = math.min(windowHeight - player.radius, player.y + player.speed * dt)
    end
    if love.keyboard.isDown("up", "w") then
        player.y = math.max(player.radius, player.y - player.speed * dt)
    end

    -- Update and bounce enemies
    for _, enemy in ipairs(enemies) do
        enemy.x = enemy.x + enemy.vx * dt
        enemy.y = enemy.y + enemy.vy * dt

        -- Bounce off screen edges
        if enemy.x - enemy.radius < 0 or enemy.x + enemy.radius > windowWidth then
            enemy.vx = -enemy.vx
        end
        if enemy.y - enemy.radius < 0 or enemy.y + enemy.radius > windowHeight then
            enemy.vy = -enemy.vy
        end

        -- Check collision with player
        if checkCollision(player, enemy) then
            gameOver = true
        end
    end

    -- Check coin collection
    for i = #coins, 1, -1 do
        if checkCollision(player, coins[i]) then
            table.remove(coins, i)
            score = score + 1
            spawnCoin()

            -- Add a new enemy every 5 points to increase challenge
            if score % 5 == 0 then
                spawnEnemy()
            end
        end
    end
end

function love.draw()
    -- Draw background
    love.graphics.clear(0.12, 0.14, 0.18)

    -- Draw coins (Gold)
    love.graphics.setColor(1, 0.85, 0.2)
    for _, coin in ipairs(coins) do
        love.graphics.circle("fill", coin.x, coin.y, coin.radius)
    end

    -- Draw enemies (Red)
    love.graphics.setColor(0.9, 0.2, 0.25)
    for _, enemy in ipairs(enemies) do
        love.graphics.circle("fill", enemy.x, enemy.y, enemy.radius)
    end

    -- Draw player (Cyan / Bright Blue)
    love.graphics.setColor(0.2, 0.75, 1)
    love.graphics.circle("fill", player.x, player.y, player.radius)

    -- Draw UI / HUD
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. score, 20, 20, 0, 1.5, 1.5)
    love.graphics.print("Move: Arrow Keys or WASD", 20, 50)

    -- Game Over Screen
    if gameOver then
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)

        love.graphics.setColor(1, 0.3, 0.3)
        love.graphics.printf("GAME OVER", 0, windowHeight / 2 - 40, windowWidth, "center", 0, 2, 2)

        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Final Score: " .. score, 0, windowHeight / 2 + 20, windowWidth, "center", 0, 1.4, 1.4)
        love.graphics.printf("Press 'R' to Play Again", 0, windowHeight / 2 + 60, windowWidth, "center", 0, 1.2, 1.2)
    end
end
