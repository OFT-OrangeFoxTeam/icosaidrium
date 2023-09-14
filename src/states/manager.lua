manager = {}

function manager:enter()
    --#tables--
    buttons = {
        {
            text = lang.manager.map;
            id = "map";
            x = 32; y = 32; w = 256; h = 20;
            func = function() opitionSelected = "map" end
        };
        {
            text = lang.manager.settings;
            id = "settings";
            x = 32; y = 64; w = 256; h = 20;
            func = function() opitionSelected = "settings" end
        };
        {
            text = lang.manager.language;
            id = "language";
            x = 32; y = 96; w = 256; h = 20;
            func = function() opitionSelected = "language" end
        };
        {
            text = lang.manager.themes;
            id = "theme";
            x = 32; y = 128; w = 256; h = 20;
            func = function() opitionSelected = "theme" end
        };
        {
            text = lang.manager.help;
            id = "help";
            x = 32; y = 160; w = 256; h = 20;
            func = function() love.system.openURL("https://github.com/AyanoTheFox/Icosaidrium") end
        };
        {
            text = lang.manager.credits;
            id = "credits";
            x = 32; y = 192; w = 256; h = 20;
            func = function() gs.switch(states.credits) end
        };
        {
            text = lang.manager_map.newOrLoadMap;
            id = "new / load";
            requirement = "map";
            x = love.graphics.getWidth() / 2 + 32; y = 64; w = 256; h = 20;
            func = function() mapOptions = "new/load" end
        };
        {
            text = lang.manager_map.renameMap;
            id = "rename";
            requirement = "map";
            x = love.graphics.getWidth() / 2 + 32; y = 128; w = 256; h = 20;
            func = function() mapOptions = "rename" end
        };
        {
            text = lang.manager_map.deleteMap;
            id = "delete";
            requirement = "map";
            x = love.graphics.getWidth() / 2 + 32; y = 160; w = 256; h = 20;
            func = function() mapOptions = "delete" end
        };
        {
            text = lang.manager_settings.show;
            id = "show touch";
            requirement = "settings";
            x = love.graphics.getWidth() / 2 + 32; y = 160; w = 160; h = 20;
            func = function()
                if meta.settings.touch.show then meta.settings.touch.show = false
                else meta.settings.touch.show = true end
            end
        };
        {
            text = lang.manager_settings.optionalInfos;
            id = "optional infos";
            requirement = "settings";
            x = love.graphics.getWidth() / 2 + 32; y = 266; w = 256; h = 20;
            func = function() 
                if meta.settings.gui.optinalInfos then meta.settings.gui.optinalInfos = false
                else meta.settings.gui.optinalInfos = true end
            end
        };
        {
            text = "deutch";
            id = "deutch";
            requirement = "language";
            x = love.graphics.getWidth() / 2 + 32; y = 32; w = 128; h = 20;
            func = function() meta.settings.lang = "deutch" end
        };
        {
            text = "espanol";
            id = "espanol";
            requirement = "language";
            x = love.graphics.getWidth() / 2 + 32; y = 64; w = 128; h = 20;
            func = function() meta.settings.lang = "espanol" end
        };
        {
            text = "englsh";
            id = "englsh";
            requirement = "language";
            x = love.graphics.getWidth() / 2 + 32; y = 96; w = 128; h = 20;
            func = function() meta.settings.lang = "englsh" end
        };
        {
            text = "francais";
            id = "francais";
            requirement = "language";
            x = love.graphics.getWidth() / 2 + 32; y = 128; w = 128; h = 20;
            func = function() meta.settings.lang = "francais" end
        };
        {
            text = "portugues";
            id = "portugues";
            requirement = "language";
            x = love.graphics.getWidth() / 2 + 32; y = 160; w = 128; h = 20;
            func = function() meta.settings.lang = "portugues" end
        };
        {
            text = "light";
            id = "light";
            requirement = "theme";
            x = love.graphics.getWidth() / 2 + 32; y = 32; w = 128; h = 20;
            func = function() meta.settings.theme = "light" end
        };
        {
            text = "dark";
            id = "dark";
            requirement = "theme";
            x = love.graphics.getWidth() / 2 + 32; y = 64; w = 128; h = 20;
            func = function() meta.settings.theme = "dark" end
        };
        {
            text = "carmin";
            id = "carmin";
            requirement = "theme";
            x = love.graphics.getWidth() / 2 + 32; y = 96; w = 128; h = 20;
            func = function() meta.settings.theme = "carmin" end
        };
        {
            text = "curruption";
            id = "curruption";
            requirement = "theme";
            x = love.graphics.getWidth() / 2 + 32; y = 128; w = 128; h = 20;
            func = function() meta.settings.theme = "curruption" end
        };
        {
            text = "platnium";
            id = "platnium";
            requirement = "theme";
            x = love.graphics.getWidth() / 2 + 32; y = 160; w = 128; h = 20;
            func = function() meta.settings.theme = "platnium" end
        };
        {
            text = "fox11";
            id = "fox11";
            requirement = "theme";
            x = love.graphics.getWidth() / 2 + 32; y = 192; w = 128; h = 20;
            func = function() meta.settings.theme = "fox11" end
        }
    }
    windowButtons = {
        {
            text = lang.manager_map.newOrLoadMap;
            id = "new";
            requirement = "new/load";
            x = love.graphics.getWidth() / 2 + 224 - font:getWidth(lang.manager_map.newOrLoadMap); y = love.graphics.getHeight() / 2 + 92; w = nil; h = 20;
            func = function() 
                editor.id = inputs.mapName.text
                if not love.filesystem.getInfo("maps/" .. inputs.mapName.text) then
                    meta.map.gridSize = tonumber(inputs.gridSize.text)
                    love.filesystem.createDirectory("maps/" .. inputs.mapName.text)
                    local _data = love.filesystem.newFile("maps/" .. editor.id .. "/mapbatch.json", "w")
                    _data:write(love.data.compress("string", "zlib", json.encode(meta.map)))
                    _data:close()
                else meta.map = json.decode(love.data.decompress("string", "zlib", love.filesystem.read("maps/" .. inputs.mapName.text .. "/mapbatch.json"))) end
                gs.switch(states.editor)
            end
        };
        {
            text = lang.manager_map.deleteMap;
            id = "delete";
            requirement = "delete";
            x = love.graphics.getWidth() / 2 + 218 - font:getWidth(lang.manager_map.deleteMap) + 14; y = love.graphics.getHeight() / 2 + 92; w = nil; h = 20;
            func = function() if love.filesystem.exists('maps/' .. inputs.mapName.text) then love.filesystem.remove('maps/' .. inputs.mapName.text) end end
        };
        {
            text = lang.manager_map.renameMap;
            id = "rename";
            requirement = "rename";
            x = love.graphics.getWidth() / 2 + 218 - font:getWidth(lang.manager_map.deleteMap) + 14; y = love.graphics.getHeight() / 2 + 92; w = nil; h = 20;
            func = function() if love.filesystem.exists("maps/" .. inputs.mapName.text) then os.rename(love.filesystem.getSaveDirectory() .. "/maps/" .. inputs.mapName.text, love.filesystem.getSaveDirectory() .. "/maps/" .. inputs.newMapName.text) end end
        };
        {
            text = "x";
            id = "exit";
            x = love.graphics.getWidth() / 2 + 212; y = love.graphics.getHeight() / 2 - 114; w = 32; h = 32;
            func = function() mapOptions = "" end
        }
    }
    inputs = {}
    inputs.gridR = {
        --type = "number";
        --min = 0; max = 255;
        --x = love.graphics.getWidth() / 2 + 32; y = 64;
        text = tostring(meta.settings.grid.color[1])
    }
    inputs.gridG = {text = tostring(meta.settings.grid.color[2])}
    inputs.gridB = {text = tostring(meta.settings.grid.color[3])}
    inputs.gridA = {text = tostring(meta.settings.grid.color[4])}
    inputs.touchSensitivity = {text = tostring(meta.settings.touch.sensitivity)}
    inputs.gridSize = {text = "32"}
    inputs.mapName = {text = "untituled"}
    inputs.newMapName = {text = "new name"}
    --#variables--
    opitionSelected = ""
    mapOptions = ""
end

function manager:draw()
    lang = lip.load('src/translation/' .. meta.settings.lang .. ".ini")
    --#GUI--
    --^polygons^--
    love.graphics.setBackgroundColor(0, 0, 200 / 255, 1) --background color
    love.graphics.line(10, love.graphics.getHeight() - 64, love.graphics.getWidth() - 10, love.graphics.getHeight() - 64)
    love.graphics.line(10, love.graphics.getHeight() - 112, love.graphics.getWidth() - 10, love.graphics.getHeight() - 112)
    love.graphics.setLineWidth(8)
    love.graphics.rectangle("line", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.line(love.graphics.getWidth() / 2 - 4, 0, love.graphics.getWidth() / 2 - 4, love.graphics.getHeight() - 112)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("line", 10, 10, love.graphics.getWidth() - 20, love.graphics.getHeight() - 20)
    --^texts--
    love.graphics.setColor(1, 1, 0, 1)
    love.graphics.print("icosaidrium", love.graphics.getWidth() / 2, love.graphics.getHeight() - 32, 0, 1, 1, font:getWidth("icosaidrium") / 2, font:getHeight() / 2)
    love.graphics.print(lang.manager.tip, love.graphics.getWidth() / 2, love.graphics.getHeight() - 96, 0, 1, 1, font:getWidth(lang.manager.tip) / 2, font:getHeight() / 2)
    if opitionSelected == "" then
        love.graphics.print("*" .. lang.manager_null.nilOption, love.graphics.getWidth() / 2 + 32, 32)
    elseif opitionSelected == "map" then
        love.graphics.print("--" .. lang.manager_map.load .. "--", love.graphics.getWidth() / 2 + 32, 32)
        love.graphics.print("--" .. lang.manager_map.dangerZone .. "--", love.graphics.getWidth() / 2 + 32, 96)
    elseif opitionSelected == "settings" then
        love.graphics.print("--" .. lang.manager_settings.grid .. "--", love.graphics.getWidth() / 2 + 32, 32)
        love.graphics.print("> R:", love.graphics.getWidth() / 2 + 32, 64)
        love.graphics.print("> G:", love.graphics.getWidth() / 2 + 256, 64)
        love.graphics.print("> B:", love.graphics.getWidth() / 2 + 32, 96)
        love.graphics.print("> A:", love.graphics.getWidth() / 2 + 256, 96)
        love.graphics.print("%", love.graphics.getWidth() / 2 + 322, 96)
        love.graphics.print("--" .. lang.manager_settings.touch .. "--", love.graphics.getWidth() / 2 + 32, 128)
        love.graphics.print("> " .. lang.manager_settings.sensitivity, love.graphics.getWidth() / 2 + 32, 196)
        love.graphics.print("%", love.graphics.getWidth() / 2 + 322, 192)
        love.graphics.print("--GUI--", love.graphics.getWidth() / 2 + 32, 234)
    end
    --^buttons^--
    for _, button in ipairs(buttons) do
        if button.id == opitionSelected or (button.requirement and (button.requirement == opitionSelected and (button.id == meta.settings.lang or button.id == meta.settings.theme))) then
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.rectangle("fill", button.x, button.y - font:getHeight() / 2 + 2, button.w, button.h, math.pi * 3 / 2)
        end
        if button.requirement == opitionSelected or not button.requirement then
            local _complement = ""
            if button.id == "optional infos" then
                if meta.settings.gui.optinalInfos then _complement = " On"
                else _complement = " Off" end
            elseif button.id == "show touch" then
                if meta.settings.touch.show then _complement = " On"
                else _complement = " Off" end
            end
            love.graphics.setColor(1, 1, 0, 1)
            love.graphics.print("> " .. button.text .. _complement, button.x, button.y)
        end
    end
    --#window--
    if mapOptions ~= "" then
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", love.graphics.getWidth() / 2 - 240, love.graphics.getHeight() / 2 - 112, 512, 256)
        love.graphics.setColor(.5, .5, .5, 1)
        love.graphics.rectangle("fill", love.graphics.getWidth() / 2 - 256, love.graphics.getHeight() / 2 - 128, 512, 256)
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.rectangle("line", love.graphics.getWidth() / 2 - 240, love.graphics.getHeight() / 2 - 112, 480, 224)
        love.graphics.print(lang.editor.mapName, love.graphics.getWidth() / 2 - 232, love.graphics.getHeight() / 2 - 104)
        if mapOptions == "new/load" then love.graphics.print(lang.manager_settings.grid .. ":", love.graphics.getWidth() / 2 - 232, love.graphics.getHeight() / 2 - 40)
        elseif mapOptions == "rename" then love.graphics.print("new name:", love.graphics.getWidth() / 2 - 232, love.graphics.getHeight() / 2 - 40) end
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function manager:update(_elapsed)
    lang = lip.load("src/translation/" .. meta.settings.lang .. ".ini")
    if mobile then buttonsTexture.sheet, buttonsTexture.quads = atlasparser.getQuads("assets/preloads/sheets/buttons_" .. meta.settings.theme)
    else buttonsTexture.sheet, buttonsTexture.quads = atlasparser.getQuads("assets/preloads/sheets/buttons_pc") end
    --#string format--
--    for _, inputTbl in ipairs(inputs) do
--        if inputTbl.type == "number" then
--            if inputTbl.text ~= "" then inputTbl.text = tostring(math.clamp(tonumber(string.match(inputTbl.text, "%d+")), inputTbl.min, inputTbl.max))
--            else inputTbl.text = "0" end
--        end
--    end
    if inputs.gridR.text ~= "" then inputs.gridR.text = tostring(math.clamp(tonumber(string.match(inputs.gridR.text, "%d+")), 0, 255))
    else inputs.gridR.text = "0" end
    if inputs.gridG.text ~= "" then inputs.gridG.text = tostring(math.clamp(tonumber(string.match(inputs.gridG.text, "%d+")), 0, 255))
    else inputs.gridG.text = "0" end
    if inputs.gridB.text ~= "" then inputs.gridB.text = tostring(math.clamp(tonumber(string.match(inputs.gridB.text, "%d+")), 0, 255))
    else inputs.gridB.text = "0" end
    if inputs.gridA.text ~= "" then inputs.gridA.text = tostring(math.clamp(tonumber(string.match(inputs.gridA.text, "%d+")), 0, 100))
    else inputs.gridA.text = "0" end
    if inputs.touchSensitivity.text ~= "" then inputs.touchSensitivity.text = tostring(math.clamp(tonumber(string.match(inputs.touchSensitivity.text, "%d+")), 0, 100))
    else inputs.touchSensitivity.text = "0" end
    if inputs.gridSize.text ~= "" then inputs.gridSize.text = tostring(math.clamp(tonumber(string.match(inputs.gridSize.text, "%d+")), 0, 999))
    else inputs.gridSize.text = "0" end
    --#save--
    meta.settings.grid.color[1] = tonumber(inputs.gridR.text)
    meta.settings.grid.color[2] = tonumber(inputs.gridG.text)
    meta.settings.grid.color[3] = tonumber(inputs.gridB.text)
    meta.settings.grid.color[4] = tonumber(inputs.gridA.text)
    meta.settings.touch.sensitivity = tonumber(inputs.touchSensitivity.text)
    local _data = love.filesystem.newFile(".settings/settings.json", "w")
    _data:write(love.data.compress("string", "zlib", json.encode(meta.settings)))
    _data:close()
    --#GUI--
    --^inputs^--
    if opitionSelected == "settings" then
        suit.Input(inputs.gridR, love.graphics.getWidth() / 2 + 68, 60, 34, 20)
        suit.Input(inputs.gridG, love.graphics.getWidth() / 2 + 290, 60, 34, 20)
        suit.Input(inputs.gridB, love.graphics.getWidth() / 2 + 68, 92, 34, 20)
        suit.Input(inputs.gridA, love.graphics.getWidth() / 2 + 290, 92, 34, 20)
        suit.Input(inputs.touchSensitivity, love.graphics.getWidth() / 2 + 290, 188, 34, 20)
    end
    if mapOptions == "new/load" then suit.Input(inputs.gridSize, love.graphics.getWidth() / 2 - 233, love.graphics.getHeight() / 2 - 18)
    elseif mapOptions == "rename" then suit.Input(inputs.newMapName, love.graphics.getWidth() / 2 - 233, love.graphics.getHeight() / 2 - 18) end
    --^buttons^--
    if mapOptions ~= "" then
        suit.Input(inputs.mapName, love.graphics.getWidth() / 2 - 232, love.graphics.getHeight() / 2 - 82)
        for _, button in ipairs(windowButtons) do if (button.requirement == mapOptions or not button.requirement) and suit.Button(button.text, {id = button.id}, button.x, button.y, button.w, button.h).hit then button.func() end end
    else for _, button in ipairs(buttons) do if (button.requirement == opitionSelected or button.requirement == mapOptions or not button.requirement) and suit.Button("", {id = button.id}, button.x, button.y, button.w, button.h).hit then button.func() end end end
end

return manager