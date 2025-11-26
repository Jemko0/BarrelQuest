function formatTable(o, seen)
    -- Initialize the 'seen' table for the top-level call if it doesn't exist
    if seen == nil then
        seen = {}
    end

    if type(o) == 'table' then
        -- Cycle Detection: Check if this table has been seen before
        if seen[o] then
            -- If it's a cycle, return a placeholder string instead of recursing
            return '[...]'
        end

        -- Mark this table as seen *before* recursing into its contents
        seen[o] = true 
        
        local s = '{ '
        -- Use pairs for generic iteration (handles both array and hash parts)
        for k, v in pairs(o) do
            -- Format the key
            local k_str = k
            if type(k) ~= 'number' and type(k) ~= 'boolean' then 
                k_str = '"' .. tostring(k) .. '"' 
            end
            
            -- Recursively format the value, passing the 'seen' table
            local v_str = formatTable(v, seen)
            
            s = s .. '[' .. k_str .. '] = ' .. v_str .. ','
        end
        
        return s .. '} '
    else
        -- Base case: Return string representation of non-table values
        -- Handle strings to keep them enclosed in quotes for accurate representation
        if type(o) == 'string' then
            return '"' .. o .. '"'
        end
        return tostring(o)
    end
end

function printTable(o)
    -- Start the process without an initial 'seen' table
    local s = formatTable(o) 
    print(s)
end

function exploreTbl(tbl, exploreList)
    exploreList = exploreList or {}

    for k, v in pairs(tbl) do
        if type(v) == "table" and not exploreList[v] then
            exploreList[v] = true
            exploreTbl(v, exploreList)
        elseif type(v) == "function" and not exploreList[v] then
            exploreList[v] = true
            print(k .."\n")
        else
            print(k, type(v))
        end
    end
end