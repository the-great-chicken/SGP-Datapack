# How to contribute
## Setup
### VSCode extensions
I suggest using the following VSCode extensions (ordered by importance):
- [Data-pack Helper Plus](https://marketplace.visualstudio.com/items?itemName=SPGoding.datapack-language-server)
- [syntax-mcfunction](https://marketplace.visualstudio.com/items?itemName=MinecraftCommands.syntax-mcfunction)
- [Datapack Icons](https://marketplace.visualstudio.com/items?itemName=SuperAnt.mc-dp-icons)
- [NBT Viewer](https://marketplace.visualstudio.com/items?itemName=Misodee.vscode-nbt)
- [VSCode Progressive Increment](https://marketplace.visualstudio.com/items?itemName=narsenico.vscode-progressive-increment) if your code is bad

### Pull Requests
Every commit to the repository's main branche must be made from a pull request. You can create a branche if you are a member of the organization, or make a fork if you're not.

## Code Conventions :
### Prefix
The datapack's prefix is `sgp.` ; every **namespace**, **objective** or **tag** should start with this prefix

### Entities Tags
When you call @e you shoud not forget to add `tag=!global.ignore` and also `global.ignore.pos`, `global.ignore.gui` and `global.ignore.kill` depending on the action you're doing, to prevent your command from interacting with potential entities from other datapacks.
You should add the necessary tags to custom entities you create, and also add `sgp.marker` to markers for example, so that you can use `@n[tag=sgp.marker,name=<name>]` for example

### Function Documentation
Each fonction should be documented in the following way:
```
#> namespace:path/to/your/function 
# `{macro_param_a: optional_type, macro_param_b}`
# 
# Description of your function stating its purpose, inputs, and outputs. Wrap 
# at 80 characters.
#
# You can have multiple lines!
```

### Language
The datapack is mainly written by French speakers for French speakers, but all new code should be written in English to prepare for future internationalization.