require '@novarift-core.modules.player'

local types = require '@novarift-organizations.shared.config'.types
local utils = require 'client.utils'

function utils.hasPlayerGotGroup(filter)
    local player = Novarift.Player
    if (not player) then return false end

    local character = player.Character
    if (not character) then return false end

    if (type(filter) == 'table') then
        local tableType = table.type(filter)

        if (tableType == 'hash') then
            for name, grade in pairs(filter) do
                if (name == character.citizen_id) then return true end

                if (types[name]) then
                    for _, data in pairs(character.organizations) do
                        if (data.type == name and data.grade >= grade) then return true end
                    end
                else
                    local data = character.organizations[name]

                    if (data and data.grade >= grade) then return true end
                end
            end
        elseif (tableType == 'array') then
            for _, name in pairs(filter) do
                if (name == character.citizen_id) then return true end

                if (types[name]) then
                    for _, data in pairs(character.organizations) do
                        if (data.type == name) then return true end
                    end
                elseif (character.organizations[name]) then
                    return true
                end
            end
        end
    end

    return character.citizen_id == filter or character.organizations[filter]
end