editor = {}
editor.id = ""

function editor:enter()
    --#tables--
    if mobile then
        buttons = {
            {
                --move
                id = "m";
                x = 0; y = love.graphics.getHeight() - 50; w = 52; h = 50;
                active = 1; normal = 2;
                func = function() 
                    if state == "moving" then state = "placing blocks"
                    else state = "moving" end
                end
            };
            {
                --save
                id = "s";
                x = 0; y = 0; w = 52; h = 50;
                active = 4; normal = 3;
                func = function()
                    local _data = love.filesystem.newFile("maps/" .. editor.id .. "/mapbatch.json", "w")
                    _data:write(love.data.compress("string", "zlib", json.encode(meta.map)))
                    _data:close()
                end
            };
            {
                --back
                id = "b";
                stateRequire = {"placing objects"; "changing layer"};
                x = 52; y = 0; w = 52; h = 50;
                active = 6; normal = 5;
                func = function()
                    if state == "placing objects" and objectId > 1 then objectId = objectId - 1
                    elseif state == "changing layer" and layerId > 1 then layerId = layerId - 1 end 
                end
            };
            {
               --next
                id = "n";
                stateRequire = {"placing objects"; "changing layer"};
                x = 104; y = 0; w = 52; h = 50;
                active = 8; normal = 7;
                func = function() 
                    if state == "placing objects" then objectId = objectId + 1 
                    elseif layerId < #meta.map.blocks + 1 then layerId = layerId + 1 end 
                end
            };
            {
                --rotate
                id = "r";
                stateRequire = {"placing blocks"};
                x = 156; y = 0; w = 52; h = 50;
                active = 10; normal = 9;
                func = function() textureR = textureR + math.pi / 2 end
            };
            {
                --undo
                id = "y";
                x = 208; y = 0; w = 52; h = 50;
                active = 12; normal = 11;
                func = function()
                    if meta.map.blocks[layerId] then
                        if #meta.map.blocks[layerId] > 0 then
                            table.insert(trash, 1, meta.map.blocks[layerId][#meta.map.blocks[layerId]])
                            table.remove(meta.map.blocks[layerId], #meta.map.blocks[layerId])
                        end
                    end
                end
            };
            {
                --redo
                id = "z";
                x = 260; y = 0; w = 52; h = 50;
                active = 14; normal = 13;
                func = function()
                    if #trash > 0 then
                            table.insert(meta.map.blocks[layerId], trash[1])
                        table.remove(trash, 1)
                    end
                end
            };
            {
                --vertical
                id = "v";
                stateRequire = {"placing blocks"};
                x = 312; y = 0; w = 52; h = 50;
                active = 25; normal = 26; 
                func = function() 
                    if textureSx == 1 then textureSx = -1 
                    else textureSx = 1 end
                end
            };
            {
                --horizontal
                id = "h";
                stateRequire = {"placing blocks"};
                x = 364; y = 0; w = 52; h = 50;
                active = 24; normal = 23; 
                func = function() 
                    if textureSy == 1 then textureSy = -1 
                    else textureSy = 1 end
                end
            };
            {
                --layer
                id = "t";
                x = 416; y = 0; w = 52; h = 50;
                active = 16; normal = 15; 
                func = function() state = "changing layer" end
            };
            {
                id = "f";
                stateRequire = {"placing blocks"};
                x = 468; y = 0; w = 52; h = 50;
                active = 28; normal = 27;
                func = function() openTileset = inverter(openTileset) end
            };
            {
                --alt
                id = "ralt";
                x = love.graphics.getWidth() - 260; y = 0; w = 78; h = 50;
                active = 20; normal = 19;
                func = function()
                    if state ~= "placing blocks" and state ~= "deleting objects" then state = "placing blocks"
                    else state = "placing objects" end
                end
            };
            {
                --backspace
                id = "backspace";
                stateRequire = {"placing blocks"; "placing objects"; "deleting blocks"; "deleting objects"; "changing layer"};
                x = love.graphics.getWidth() - 182; y = 0; w = 104; h = 50;
                active = 22; normal = 21;
                func = function()
                    if state == "changing layer" then meta.map.blocks[layerId] = {}--!delete layer
                    elseif state ~= "deleting blocks" and state ~= "placing objects" then state = "deleting blocks"
                    else state = "deleting objects" end
                end
            };
            {
                --escape
                id = "escape";
                x = love.graphics.getWidth() - 78; y = 0; w = 78; h = 50;
                active = 17; normal = 18;
                func = function()
                    tileset.sheet:release()
                    mapBatch:release()
                    gs.switch(states.manager)
                end
            }
        }
    else
        buttons = {
            {
                --save
                id = "s";
                x = 0; y = 0; w = 32; h = 32;
                quad = 1;
                func = function()
                    local _data = love.filesystem.newFile("maps/" .. editor.id .. "/mapbatch.json", "w")
                    _data:write(love.data.compress("string", "zlib", json.encode(meta.map)))
                    _data:close()
                end
            };
            {
                --back
                id = "b";
                stateRequire = {"placing objects"; "changing layer"};
                x = 32; y = 0; w = 32; h = 32;
                quad = 4;
                func = function()
                    if state == "placing objects" and objectId > 1 then objectId = objectId - 1
                    elseif state == "changing layer" and layerId > 1 then layerId = layerId - 1 end 
                end
            };
            {
               --next
                id = "n";
                stateRequire = {"placing objects"; "changing layer"};
                x = 64; y = 0; w = 32; h = 32;
                quad = 5;
                func = function() 
                    if state == "placing objects" then objectId = objectId + 1 
                    elseif layerId < #meta.map.blocks + 1 then layerId = layerId + 1 end 
                end
            };
            {
             --rotate
                id = "r";
                stateRequire = {"placing blocks"};
                x = 96; y = 0; w = 32; h = 32;
                quad = 3;
                func = function() textureR = textureR + math.pi / 2 end
            };
            {
                 --undo
                id = "y";
                x = 128; y = 0; w = 32; h = 32;
                quad = 6;
                func = function()
                     if meta.map.blocks[layerId] then
                        if #meta.map.blocks[layerId] > 0 then
                            table.insert(trash, 1, meta.map.blocks[layerId][#meta.map.blocks[layerId]])
                            table.remove(meta.map.blocks[layerId], #meta.map.blocks[layerId])
                        end
                    end
                end
            };
            {
                --redo
                id = "z";
                x = 160; y = 0; w = 32; h = 32;
                quad = 7;
                func = function()
                    if #trash > 0 then
                        table.insert(meta.map.blocks[layerId], trash[1])
                        table.remove(trash, 1)
                    end
                end
            };
            {
                --vertical
                id = "v";
                stateRequire = {"placing blocks"};
                x = 192; y = 0; w = 32; h = 32;
                quad = 9; 
                func = function() 
                    if textureSx == 1 then textureSx = -1 
                    else textureSx = 1 end
                end
            };
            {
                --horizontal
                id = "h";
                stateRequire = {"placing blocks"};
                x = 224; y = 0; w = 32; h = 32;
                quad = 10; 
                func = function() 
                    if textureSy == 1 then textureSy = -1 
                    else textureSy = 1 end
                end
            };
            {
                --layer
                id = "t";
                x = 256; y = 0; w = 32; h = 32;
                quad = 2; 
                func = function() state = "changing layer" end
            };
            {
                id = "f";
                stateRequire = {"placing blocks"};
                x = 288; y = 0; w = 32; h = 32;
                quad = 8;
                func = function() openTileset = inverter(openTileset) end
            };
            {
                --alt
                id = "ralt";
                x = love.graphics.getWidth() - 96; y = 0; w = 32; h = 32;
                quad = 11;
                func = function()
                    if state ~= "placing blocks" and state ~= "deleting objects" then state = "placing blocks"
                    else state = "placing objects" end
                end
            };
            {
                --backspace
                id = "backspace";
                stateRequire = {"placing blocks"; "placing objects"; "deleting blocks"; "deleting objects"; "changing layer"};
                x = love.graphics.getWidth() - 64; y = 0; w = 32; h = 32;
                quad = 12;
                func = function()
                    if state == "changing layer" then meta.map.blocks[layerId] = {}--!delete layer
                    elseif state ~= "deleting blocks" and state ~= "placing objects" then state = "deleting blocks"
                    else state = "deleting objects" end
                end
            };
            {
                --escape
                id = "escape";
                x = love.graphics.getWidth() - 32; y = 0; w = 32; h = 32;
                quad = 13;
                func = function()
                    tileset.sheet:release()
                    mapBatch:release()
                    gs.switch(states.manager)
                end
            }
        }
    end
    tileset = {} --game tiles
    trash = {} --all blocks deleted
    --#variables--
    --^strings^--
    state = "placing blocks"
    --^numbers^--
    --^textures values^--
    textureId = 1 --texture quad
    textureR = 0
    textureSx, textureSy = 1, 1
    --^others^--
    layerId = 1 
    objectId = 1
    editorOffSetX, editorOffSetY = 0, 0
    memoryUsage = 0
    --^bools^--
    openTileset = true
    --#cmds--
    if love.filesystem.getInfo("maps/" .. editor.id .. "/tileset.json") and love.filesystem.getInfo("maps/" .. editor.id .. "/tileset.png") then tileset.sheet, tileset.quads = atlasparser.getQuads("maps/" .. editor.id .. "/tileset")
    else
        tileset.sheet = love.graphics.newImage("assets/images/defaultTexture.png")
        tileset.quads = {love.graphics.newQuad(0, 0, 32, 32, tileset.sheet)}
    end
    mapBatch = love.graphics.newSpriteBatch(tileset.sheet)
end

function editor:draw()
    if meta.settings.theme == "light" then love.graphics.setBackgroundColor(.5, .5, .5, 1) --background color
    elseif meta.settings.theme == "carmin" then 
        local background = love.graphics.newGradient("vertical", {102 / 255; 19 / 255; 46 / 255; 1}, {60 / 255; 179 / 255; 113 / 255; 1})
        love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    elseif meta.settings.theme == "curruption" then
        local background = love.graphics.newGradient("vertical", {0; 82 / 255; 185 / 255; 1}, {139 / 255; 0; 139 / 255; 1})
        love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    elseif meta.settings.theme == "platnium" then
        local background = love.graphics.newGradient("horizontal", {0, 0, 0, 1}, {.5, .5, .5, 1})
        love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    elseif meta.settings.theme == "fox11" then love.graphics.setBackgroundColor(162 / 255, 112 / 255, 87 / 255, 1)
    else love.graphics.setBackgroundColor(0, 0, 0, 1) end--background color
    --#map parser--
    --^spritebatch update^--
    mapBatch:clear()--clean the spritebatch
    for _, layer in ipairs(meta.map.blocks) do for _, block in ipairs(layer) do mapBatch:add(tileset.quads[block.textureId], block.x - editorOffSetX * meta.map.gridSize, block.y - editorOffSetY * meta.map.gridSize, block.r, block.sx, block.sy, block.ox, block.oy) end end
    love.graphics.draw(mapBatch)--spritebatch draw--
    --^objects--
    for _, object in ipairs(meta.map.objects) do
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", object.x - object.ox - editorOffSetX * meta.map.gridSize, object.y - object.oy - editorOffSetY * meta.map.gridSize, object.w, object.h)
        love.graphics.print(object.id, object.x + object.w / 2 - font:getWidth(object.id) / 2 - editorOffSetX * meta.map.gridSize, object.y + object.h / 2 - font:getHeight(object.id) / 2 - editorOffSetY * meta.map.gridSize, 0, 1, 1, object.ox, object.oy)
        love.graphics.setColor(1, 1, 1, .2)
        love.graphics.rectangle("fill", object.x - object.ox - editorOffSetX * meta.map.gridSize, object.y - object.oy - editorOffSetY * meta.map.gridSize, object.w, object.h)
    end
    --#GUI--
    --^grid^--
    love.graphics.setColor(meta.settings.grid.color[1] / 255, meta.settings.grid.color[2] / 255, meta.settings.grid.color[3] / 255, meta.settings.grid.color[4] / 100)
    for _x = -meta.map.gridSize / 2, love.graphics.getWidth(), meta.map.gridSize do for _y = -meta.map.gridSize / 2, love.graphics.getHeight(), meta.map.gridSize do love.graphics.rectangle("line", _x, _y, meta.map.gridSize, meta.map.gridSize) end end
    --^show touch^--
    if meta.settings.touch.show and cx and cy then
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.rectangle("line", cx - meta.map.gridSize / 2 - editorOffSetX * meta.map.gridSize, cy - meta.map.gridSize / 2 - editorOffSetY * meta.map.gridSize, meta.map.gridSize, meta.map.gridSize)
    end
    --^select texture^--
    if state == "placing blocks" and openTileset then
        love.graphics.setColor(.75, .75, .75, 1)
        love.graphics.rectangle("fill", love.graphics.getWidth() - 180 , 0, 180, love.graphics.getHeight())
        love.graphics.setColor(.25, .25, .25, 1)
        love.graphics.setLineWidth(16)
        love.graphics.line(love.graphics.getWidth() - 180, 0, love.graphics.getWidth() - 180, love.graphics.getHeight())
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1, 1, 1, 1)
        local _spriteX, _spriteY = love.graphics.getWidth() - 164, 52
        for _, quad in ipairs(tileset.quads) do
            local _spriteW, _spriteH = quad:getTextureDimensions()
            if _spriteX + _spriteW > love.graphics.getWidth() then
                _spriteX = love.graphics.getWidth() - 164
                _spriteY = _spriteY + _spriteH
            end
            if _spriteY + _spriteH > love.graphics.getHeight() then _spriteY = 52 end
            love.graphics.draw(tileset.sheet, quad, _spriteX, _spriteY)
            if suit.Button("", {id = _}, _spriteX, _spriteY, _spriteW, _spriteH).hit then textureId = _ end
            love.graphics.rectangle("line", _spriteX, _spriteY, _spriteW, _spriteH)
            _spriteX = _spriteX + _spriteW
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
    --^buttons--
    for _, _button in ipairs(buttons) do
        if not _button.stateRequire or table.content(_button.stateRequire, state) then
            if mobile then
                if suit.isActive(_button.id) then love.graphics.draw(buttonsTexture.sheet, buttonsTexture.quads[_button.active], _button.x, _button.y, 0, 2, 2)
                else love.graphics.draw(buttonsTexture.sheet, buttonsTexture.quads[_button.normal], _button.x, _button.y, 0, 2, 2) end
            else
                if suit.isActive(_button.id) then love.graphics.setColor(.5, .5, .5, 1) end
                love.graphics.draw(buttonsTexture.sheet, buttonsTexture.quads[_button.quad], _button.x, _button.y, 0, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)
            end
        end
    end
    --^text and infos^--
    love.graphics.draw(tileset.sheet, tileset.quads[textureId], 256 + meta.map.gridSize / 2, 52 + meta.map.gridSize / 2, textureR, textureSx, textureSy, meta.map.gridSize / 2, meta.map.gridSize / 2)
    if meta.settings.theme == "light" then love.graphics.setColor(.25, .25, .25, 1)
    elseif meta.settings.theme == "curruption" then love.graphics.setColor(1, 1, 0, 1)
    elseif meta.settings.theme == "carmin" then love.graphics.setColor(0, 1, 1, 1)
    elseif meta.settings.theme == "platnium" then love.graphics.setColor(.5, .5, .5, 1)
    elseif meta.settings.theme == "fox11" then love.graphics.setColor(255 / 255, 221 / 255, 204 / 255, 1)
    else love.graphics.setColor(1, 1, 1, 1) end
    love.graphics.rectangle("line", 256, 52, meta.map.gridSize, meta.map.gridSize)
    love.graphics.print(lang.editor.mode .. state .. "\n" .. lang.editor.objectId .. objectId .. "\n" .. lang.editor.layer .. layerId .. "\nx: " .. editorOffSetX .. " y: " .. editorOffSetY, 0, 52)
    if meta.settings.gui.optinalInfos then love.graphics.print(lang.editor.mapName .. editor.id .. "\nFPS: " .. love.timer.getFPS() .. " RAM: " .. memoryUsage, 0, font:getHeight() * 4 + 50) end
    love.graphics.setColor(1, 1, 1, 1)
end

function editor:update(_elapsed)
    memoryUsage = math.byteToSize(love.graphics.getStats().texturememory)--memory usage
    --#buttons--
    for _, _button in ipairs(buttons) do if suit.Button("", {id = _button.id}, _button.x, _button.y, _button.w, _button.h).hit and (not _button.stateRequire or table.content(_button.stateRequire, state)) then _button.func() end end
    --#cam
    --x--
    if love.keyboard.isDown("d") then editorOffSetX = editorOffSetX - math.floor(meta.settings.touch.sensitivity / 100 * 3)
    elseif love.keyboard.isDown("a") then editorOffSetX = editorOffSetX + math.floor(meta.settings.touch.sensitivity / 100 * 3) end
    --y
    if love.keyboard.isDown("w") then editorOffSetY = editorOffSetY - math.floor(meta.settings.touch.sensitivity / 100 * 3)
    elseif love.keyboard.isDown("s") then editorOffSetY = editorOffSetY + math.floor(meta.settings.touch.sensitivity / 100 * 3) end
    --touch
    for _, touch in ipairs(love.touch.getTouches()) do tx, ty = love.touch.getPosition(touch) end
    if love.mouse.isDown(1) then tx, ty = love.mouse.getPosition() end
    if tx and ty then
        --#center touch update--
        cx, cy = math.multiply(tx + meta.map.gridSize / 2 + editorOffSetX * meta.map.gridSize, meta.map.gridSize), math.multiply(ty + meta.map.gridSize / 2 + editorOffSetY * meta.map.gridSize, meta.map.gridSize)  --center the touch
        --placing blocks and objects
        if (ty > 50 and not (tx < 50 and ty > love.graphics.getHeight() - 52)) and (tx < love.graphics.getWidth() - 180 or state ~= "placing blocks" or not openTileset) then 
            if state == "placing blocks" and not canPlaceBlock() then createBlock()
            elseif state == "deleting blocks" then deleteBlock()
            elseif state == "placing objects" and not canPlaceObjects() then createObject()
            elseif state == "deleting objects" then deleteObject() end
        end
        tx, ty = nil, nil
    end
end

function editor:touchmoved(_id, _x, _y, _dx, _dy, _pressure)
    --#placing blocks and objects--
    if (_x > 50 and _y > 52) and (_x < love.graphics.getWidth() - 180 or state ~= "placing blocks" or not openTileset) and meta.settings.touch.swipe then 
        --#cam--
        if state == "moving" then
            --x
            if _dx > 0 and math.abs(_dx) > math.abs(_dy) then editorOffSetX = editorOffSetX - math.floor(meta.settings.touch.sensitivity / 100 * 3)
            elseif _dx < 0 and math.abs(_dx) > math.abs(_dy) then editorOffSetX = editorOffSetX + math.floor(meta.settings.touch.sensitivity / 100 * 3) end
            --y
            if _dy > 0 and math.abs(_dy) > math.abs(_dx) then editorOffSetY = editorOffSetY - math.floor(meta.settings.touch.sensitivity / 100 * 3)
            elseif _dy < 0 and math.abs(_dy) > math.abs(_dx) then editorOffSetY = editorOffSetY + math.floor(meta.settings.touch.sensitivity / 100 * 3) end
        end
    end
end

----------------object orientation--------------------
--#blocks--
function createBlock()
    local _block = {}
    _block.x, _block.y, _block.w, _block.h = cx, cy, meta.map.gridSize, meta.map.gridSize
    _block.r = textureR
    _block.sx, _block.sy = textureSx, textureSy
    _block.ox, _block.oy = meta.map.gridSize / 2, meta.map.gridSize / 2
    _block.textureId = textureId
    if not meta.map.blocks[layerId] then meta.map.blocks[layerId] = {} end
    table.insert(meta.map.blocks[layerId], _block)
end

function canPlaceBlock()
    if meta.map.blocks[layerId] then
        for _, block in ipairs(meta.map.blocks[layerId]) do
            if block.x == cx and block.y == cy then
                if block.textureId ~= textureId then block.TextureId = textureId end
                if block.r ~= textureR then block.r = textureR end
                if block.sx ~= textureSx then block.sx = textureSx end
                if block.sy ~= textureSy then block.sy = textureSy end
                return true
            end
        end
    end
end 

function deleteBlock()
    if meta.map.blocks[layerId] then
        for _, block in ipairs(meta.map.blocks[layerId]) do
            if block.x == cx and block.y == cy then
                table.insert(trash, 1, block)
                table.remove(meta.map.blocks[layerId], _)
                break
            end
        end
    end
end

--#objects--
function createObject()
    local _object = {}
    _object.x, _object.y, _object.w, _object.h = cx, cy, meta.map.gridSize, meta.map.gridSize
    _object.ox, _object.oy = meta.map.gridSize / 2, meta.map.gridSize / 2
    _object.id = objectId
    table.insert(meta.map.objects, _object)
end

function canPlaceObjects()
    for _, object in ipairs(meta.map.objects) do
        if object.x == cx and object.y == cy then
            if object.id ~= objectId then object.id = objectId end
            return true
        end
    end
end

function deleteObject()
    for _, object in ipairs(meta.map.objects) do
        if object.x == cx and object.y == cy then
            table.remove(meta.map.objects, _)
            break
        end
    end
end

return editor