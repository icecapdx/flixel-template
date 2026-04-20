## Compiling

This is gonna be barebones for now but uh heres the commands after you install Haxe:

```bash
cd 'whereever/this/repo/is'
haxelib --global install hmm
haxelib --global run hmm setup
hmm install
haxelib run lime setup
lime rebuild cpp
lime rebuild switch # ONLY DO THIS IF YOU PLAN TO BUILD FOR NINTENDO SWITCH
lime build [device] -DFEATURE_DISCORD_RPC # ex: linux, switch, & windows 
```
