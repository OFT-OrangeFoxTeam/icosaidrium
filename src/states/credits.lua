credits = {}

function credits:enter()
    foxy = love.graphics.newImage("assets/images/foxy.png")
    choco = love.graphics.newImage("assets/images/choco.png")
    tooru = love.graphics.newImage("assets/images/tooru.png")
    friend = love.graphics.newImage("assets/images/friends.png")
end

function credits:draw()
    love.graphics.setBackgroundColor(0, 0, 0, 1)
    love.graphics.print("Created by Foxy Ayano", love.graphics.getWidth() / 2, 16, 0, 1, 1, font:getWidth("Created by Foxy Ayano") / 2, 0)
    love.graphics.draw(foxy, love.graphics.getWidth() / 2, 32, 0, 2, 2, foxy:getWidth() / 2, 0)
    love.graphics.print("Art by Foxy Ayano and Choco", love.graphics.getWidth() / 2, 112, 0, 1, 1, font:getWidth("Art by Foxy Ayano and Choco") / 2, 0)
    love.graphics.draw(choco, love.graphics.getWidth() / 2, 128, 0, 2, 2, tooru:getWidth() / 2, 0)
    love.graphics.print("Translation by Foxy Ayano and Tooru", love.graphics.getWidth() / 2, 208, 0, 1, 1, font:getWidth("Translation by Foxy Ayano and Tooru") / 2, 0)
    love.graphics.draw(tooru, love.graphics.getWidth() / 2, 224, 0, 2, 2, foxy:getWidth() / 2, 0)
    love.graphics.print("Thanks for all Choco, Th and Amanda", love.graphics.getWidth() / 2, 304, 0, 1, 1, font:getWidth("Thanks for all choco, th and amanda") / 2, 0)
    love.graphics.draw(friend, love.graphics.getWidth() / 2, 320, 0, 2, 2, friend:getWidth() / 2, 0)
end

function credits:update(_elapsed)
    if suit.Button("x", love.graphics.getWidth() - 32, 0, 32, 32).hit then
        foxy:release()
        choco:release()
        tooru:release()
        friend:release()
        gs.switch(states.manager)
    end
end

return credits