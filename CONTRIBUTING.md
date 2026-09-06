# How to contribute
## Setup
### VSCode extensions
I suggest using the following VSCode extensions (ordered by importance):
- [Data-pack Helper Plus](https://marketplace.visualstudio.com/items?itemName=SPGoding.datapack-language-server)
- [syntax-mcfunction](https://marketplace.visualstudio.com/items?itemName=MinecraftCommands.syntax-mcfunction)
- [Datapack Optimization Helper](https://marketplace.visualstudio.com/items?itemName=TheSalt.datapack-optimization)
- [Datapack Icons](https://marketplace.visualstudio.com/items?itemName=SuperAnt.mc-dp-icons)
- [NBT Viewer](https://marketplace.visualstudio.com/items?itemName=Misodee.vscode-nbt)
- [VSCode Progressive Increment](https://marketplace.visualstudio.com/items?itemName=narsenico.vscode-progressive-increment) if your code is bad

### Pull Requests
Every commit to the repository's main branche must be made from a pull request. You can create a branche if you are a member of the organization, or make a fork if you're not.

## Code Conventions :
### Prefix
The datapack's prefix is `sgp.` ; every **namespace**, **objective** or **tag** should start with this prefix

### Entities Tags
When you call @e you shoud not forget to add `tag=!smithed.entity` to prevent your command from interacting with potential entities from other datapacks (if you don't add `tag=sgp.<something>` of course).
You should add `smithed.entity` to custom vanilla-like entities you create (not markers or mannequins for ex), and also add `sgp.marker` to markers for example, so that you can use `@n[type=marker,tag=sgp.marker,name=<name>]`

### Function Documentation
Each fonction should be documented in the following way:
```
#> namespace:path/to/your/function 
# `{macro_param_a: optional_type, macro_param_b}`
# 
# Description of your function stating its purpose, inputs, and outputs.
#
# You can have multiple lines!
```

### World <-> Datapack separation
Do NOT ever hardcode coordinates even if you're working on the official SGP server. Always reference markers instead.

### Optional plugin integrations

Plugin commands must stay inside one of the removable `sgp.integration.*` namespaces. Core functions call them only through tags in `sgp.hooks`, and every integration entry in those tags must use `"required": false`.

Do not call an integration function directly from core code, including from macro strings or scheduled commands. If a change adds a plugin command, add an optional hook and keep the handler in the matching integration namespace. Run `python3 .github/scripts/prepare_core.py . <new-directory>` to check the boundaries without starting Minecraft.

### Tests

Add [PackTest](https://github.com/misode/packtest) tests under `data/<namespace>/test/<subsystem>/`, named after the behavior they check. CI discovers tests recursively and runs them against the plugin-free core. Keep CI-specific fixtures under `.github/packtest/data/`.

Test files do not support `\` line continuations. Put directives such as `# @dummy` in the initial comment block, before any blank line or command.

Share an `@environment` when tests can coexist, including after failures: setup and teardown run around the batch, not each test. Keep separate IDs for asynchronous global-state tests or tests requiring an isolated player roster. The Lootdrop CI fixture replaces its random loot table with a full chest of diamonds so inventory loss is deterministic.

PackTest only auto-removes dummies on success and near the structure. Roster-sensitive tests use environment cleanup to disconnect leftover dummies; damage tests also wait for client-loading protection to expire.

PackTest runs dummy interactions inside a command function, which defers loot advancement callbacks. Lootdrop's menu timing therefore needs playtesting; CI covers generation, close effects, restart cleanup, and sharing.

Call the production entry point and assert its observable results with explicit expected values. Use test-specific tags and storage paths, and establish each test's inputs independently. Tests share scoreboards and storage; a failed `assert` ends the test immediately, so later cleanup will not run. Keep synchronous setup, calls, and assertions together when using shared scratch state, and scope entity selectors to the test's entities and area.

Do not run tests on the live Minecraft server. The preparation command above validates resources and stages a fresh CI copy without starting Minecraft; gameplay assertions are checked by the GitHub action.

### Language
The datapack is mainly written by French speakers for French speakers, but all new code should be written in English to prepare for future internationalization.
Pour les messages en français, il faut toujours tutoyer le joueur, et accorder avec `(e)` ou `/` les mots. Exemple: `"Tu es devenu(e) un(e) chasseur/euse !"`
