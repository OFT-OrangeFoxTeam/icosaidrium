loadscreen = {}

function loadscreen:enter()
    --#tables--
    meta = {}
    meta.settings = {}
    meta.settings.grid = {}
    meta.settings.grid.color = {255; 255; 255; 20}
    meta.settings.touch = {}
    meta.settings.touch.show = true
    meta.settings.touch.sensitivity = 50
    meta.settings.gui = {}
    meta.settings.gui.optinalInfos = true
    meta.settings.theme = "dark"
    meta.settings.lang = "englsh"
    meta.map = {}
    meta.map.blocks = {}
    meta.map.objects = {}
    meta.map.gridSize = 32
    --#variables--
    --^assets^--
    logo = love.graphics.newImage("assets/images/icosaidrium.png")
    timer = timer.new()
    --^numbers--
    alph = 1
    --#cmds--
    --^preload^--
    buttonsTexture = {}
    if mobile then buttonsTexture.sheet, buttonsTexture.quads = atlasparser.getQuads("assets/preloads/sheets/buttons_" .. meta.settings.theme)
    else buttonsTexture.sheet, buttonsTexture.quads = atlasparser.getQuads("assets/preloads/sheets/buttons_pc") end
    --^timer^--
    timer:after(2.5, function()
        logo:release()
        gs.switch(states.manager)
    end)
    timer:tween(2.5, _G, {alph = 0}, "in-linear") --fov out
    --#dirs manager--
    if not love.filesystem.getInfo(".settings/settings.json") then
        love.filesystem.createDirectory(".settings")
        local _data = love.filesystem.newFile(".settings/settings.json", "w")
        _data:write(love.data.compress("string", "zlib", json.encode(meta.settings)))
        _data:close()
    else meta.settings = json.decode(love.data.decompress("string", "zlib", love.filesystem.read(".settings/settings.json"))) end
    love.filesystem.createDirectory("maps")
    --^buttons color^--
    suit.theme.color.normal = {bg = {1; 1; 1; 0}; fg = {1; 1; 0; 1}}
    suit.theme.color.hovered = {bg = {1; 1; 1; 0}; fg = {1; 1; 0; 1}}
    suit.theme.color.active = {bg = {1; 1; 1; 0}; fg = {1; 1; 0; 1}}
    --^translation^--
    lang = lip.load("src/translation/" .. meta.settings.lang .. ".ini")
end

function loadscreen:draw()
    love.graphics.setColor(1, 1, 1, alph)
    love.graphics.draw(logo, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 4, 4, logo:getWidth() / 2, logo:getHeight() / 2)
    love.graphics.setColor(1, 1, 1, 1)
end

function loadscreen:update(_elapsed) timer:update(_elapsed) end

return loadscreen