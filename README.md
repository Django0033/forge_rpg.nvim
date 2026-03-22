# forge-nvim

Random Tables Generator for [FORGE RPG](https://zap-forge.itch.io/forge) - Anniversary Edition

## Installation

### Using packer.nvim
```lua
use 'Django0033/forge-nvim'
```

### Using vim-plug
```vim
Plug 'Django0033/forge-nvim'
```

## Setup

```lua
lua require('forge-nvim').setup()
```

## Commands

| Command | Description |
|---------|-------------|
| `:ForgeRoll <dice>` | Roll dice (e.g., d20, 3d6, 2d8+2, d66) |
| `:ForgeName [race]` | Random name (human, elf, dwarf, etc.) |
| `:ForgeNPC` | Complete random NPC |
| `:ForgeCharacter` | Random player character (Level 1) |
| `:ForgeCreature` | Random creature with stats |
| `:ForgeEncounter` | Random encounter with reaction |
| `:ForgeTreasure [level]` | Treasure by dungeon level (1-10) |
| `:ForgeSettlement` | Random settlement |
| `:ForgeTavern` | Random tavern name |
| `:ForgeGear` | 5 pieces of adventuring gear |
| `:ForgeWeapon` | Random weapon |
| `:ForgeScars` | Permanent scar generator |
| `:ForgeHelp` | Command reference |

## Usage

1. Open any buffer (markdown file recommended)
2. Run a `:ForgeXXX` command
3. View results in floating window
4. Press `i` or `<CR>` to insert as Markdown into your file
5. Press `r` to re-roll
6. Press `q` to close

## Example Output

```markdown
## FORGE: Random Encounter

| Category | Detail |
|----------|--------|
| **Type** | Humanoid |
| **Creature** | Goblin |
| **Reaction Roll** | 2d6 = 10 |
| **Disposition** | Helpful |
| **Distance** | Near (~30') |
| **Count** | A pair (2) |
| **Motivation** | Seeking treasure |
```

## Credits

FORGE RPG by Oliver Fradgley
Licensed under CC BY 4.0

## License

CC BY 4.0
