# lua-watcher
A Lua module to monitor files from a specific directory

## How does it work?
Follow an example:
```lua
  local watcher = require 'watcher'

  watcher('my_directory', function()
    print('Some file was modified now!')
  end)
```
