# lua-watcher
A Lua module to monitor files from a specific directory

# Installation
To install lua-watcher, run:
```sh
$ luarocks install watcher
```

## How does it work?
Follow an example:
```lua
  local watcher = require 'watcher'

  watcher('my_directory/', function()
    print('Some file was modified now!')
  end)
```
