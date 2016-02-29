local lfs  = require 'lfs'

local last_modified = 0
local function _check_modification(directory, _last_modified, callback)

    last_modified = _last_modified
    local file

    for _file in lfs.dir(directory) do
        if _file ~= '..' and _file ~= '.' then
            file = directory .. _file 

            if lfs.attributes(file, 'mode') == 'file' and
               lfs.attributes(file, 'modification') > last_modified then
                last_modified = lfs.attributes(file, 'modification')
                callback(last_modified)
            elseif lfs.attributes(file, 'mode') == 'directory' then
                _check_modification(file .. '/', last_modified, callback)
            end
        end
    end
end

local function _get_last_modified(directory)

    local last = 0

    _check_modification(directory, last_modified, function(_last_modified)
        last = _last_modified
    end)

    return last
end

local function watcher(directory, callback)

    local last = _get_last_modified(directory)
    callback()

    while true do
        _check_modification(directory, last_modified, function(_last_modified)
            last = _last_modified
            callback()
        end)
    end
end

return watcher
