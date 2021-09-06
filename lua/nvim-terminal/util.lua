local Lua = {}

-- Merge content of two table and returns a new table
function Lua.merge_tables(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == 'table') and (type(t1[k] or false) == 'table') then
            Lua.merge_tables(t1[k], t2[k])
        else
            t1[k] = v
        end
    end

    return t1
end

local String = {}

function String.is_not_empty(str) return str ~= nil and str ~= '' or false end

return {Lua = Lua, String = String}
