require '@novarift-core.modules.player'
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
                local org = character.organizations[name]

                if ((org and org.grade >= grade) or name == character.citizen_id) then
                    return true
                end
            end
        elseif (tableType == 'array') then
            for _, name in pairs(filter) do
                if (character.organizations[name] or character.citizen_id == name) then
                    return true
                end
            end
        end
    end

    return character.citizen_id == filter or character.organizations[filter]
end