function love.load()
    --^libs^--
    --#graphicals libs#--
    gs = require "libs/gamestate"
    --#dataBank libs#--
    json = require "libs/json"
    lip = require "libs/lip"
    --#others#--
    suit = require "libs/suit"
    timer = require "libs/timer"
    require "libs/lep"
    require "libs/addons"
    --^tables^--
    --#gamestate states#--
    states = {}
    states.loadscreen = require "src/states/loadscreen"
    states.editor = require "src/states/editor"
    states.manager = require "src/states/manager"
    states.credits = require "src/states/credits"
    --^vars^--
    font = love.graphics.setNewFont("assets/fonts/phoenixBIOS.ttf", 12) --defaultFont
    mobile = false --check if the user is a mobile user
    --^cmds^--
    love.graphics.setDefaultFilter("nearest", "nearest") --defaultfilter
    gs.registerEvents({"update"; "textinput"; "textedited"; "keypressed"; "touchpressed"; "touchmoved"; "touchreleased"; "mousepressed"; "mousemoved"}) --events to register
    gs.switch(states.loadscreen)
    if love.system.getOS() == 'iOS' or love.system.getOS() == 'Android' then mobile = true end
end

function love.draw()
    gs.current():draw()
    suit.draw()
end

function love.textedited(_t, _s, _l) suit.textedited(_t, _s, _l) end

function love.keypressed(_k) suit.keypressed(_k) end

function love.textinput(_t) suit.textinput(_t) end
