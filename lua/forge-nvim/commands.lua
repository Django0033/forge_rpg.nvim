local M = {}

local encounter_gen = require("forge-nvim.generators.encounter")
local npc_gen = require("forge-nvim.generators.npc")
local char_gen = require("forge-nvim.generators.character")
local creature_gen = require("forge-nvim.generators.creature")
local treasure_gen = require("forge-nvim.generators.treasure")
local names = require("forge-nvim.tables.names")
local settlements = require("forge-nvim.tables.settlements")
local equip = require("forge-nvim.tables.equipment")
local misc = require("forge-nvim.tables.misc")
local dice = require("forge-nvim.dice")
local floatwin = require("forge-nvim.floatwin")

function M.setup()
  vim.api.nvim_create_user_command("ForgeRoll", function(opts)
    local notation = opts.args or "d20"
    local result, _ = dice.format_roll(notation)
    local float_content = "┌─────────────────────────────────────────┐\n" ..
      "│  FORGE: Dice Roll                        │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│                                         │\n" ..
      "│  Roll: " .. string.format("%-30s", notation) .. "│\n" ..
      "│                                         │\n" ..
      "│  Result: " .. string.format("%-27d", _) .. "│\n" ..
      "│                                         │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│  [q] close  [r] re-roll  [i] copy      │\n" ..
      "└─────────────────────────────────────────┘"
    local gen = {
      generate = function()
        local r, _ = dice.format_roll(notation)
        return { notation = notation, result = _ }
      end,
      to_float_content = function(data)
        return "┌─────────────────────────────────────────┐\n" ..
          "│  FORGE: Dice Roll                        │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│                                         │\n" ..
          "│  Roll: " .. string.format("%-30s", notation) .. "│\n" ..
          "│                                         │\n" ..
          "│  Result: " .. string.format("%-27d", data.result) .. "│\n" ..
          "│                                         │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│  [q] close  [r] re-roll  [i] copy      │\n" ..
          "└─────────────────────────────────────────┘"
      end,
      to_markdown = function(data)
        return "## FORGE: Dice Roll\n\n**Notation:** " .. notation .. "\n\n**Result:** " .. data.result
      end,
    }
    local data = gen.generate()
    floatwin.open(gen.to_float_content(data), data, gen)
  end, { nargs = "?", complete = function() return { "d20", "d6", "d8", "3d6", "2d6+2", "d66" } end })

  vim.api.nvim_create_user_command("ForgeName", function(opts)
    local race = opts.args ~= "" and opts.args or nil
    local name = names.get_name(race)
    race = race or "human"
    local content = "┌─────────────────────────────────────────┐\n" ..
      "│  FORGE: Random Name                      │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│                                         │\n" ..
      "│  Name: " .. string.format("%-30s", name) .. "│\n" ..
      "│  Race: " .. string.format("%-30s", race:gsub("^%l", string.upper)) .. "│\n" ..
      "│                                         │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│  [q] close  [r] re-roll  [i] insert    │\n" ..
      "└─────────────────────────────────────────┘"
    local gen = {
      generate = function() return { name = names.get_name(race), race = race } end,
      to_float_content = function(d) return content end,
      to_markdown = function(d) return "## FORGE: Random Name\n\n**Name:** " .. d.name .. "\n\n**Race:** " .. d.race:gsub("^%l", string.upper) end,
    }
    floatwin.open(content, gen.generate(), gen)
  end, { nargs = "?", complete = function() return { "human", "elf", "dwarf", "halfling", "gnome", "goblin", "orc", "troll" } end })

  vim.api.nvim_create_user_command("ForgeNPC", function()
    local data = npc_gen.npc()
    local content = npc_gen.to_float_content(data)
    local gen = {
      generate = npc_gen.npc,
      to_float_content = npc_gen.to_float_content,
      to_markdown = npc_gen.to_markdown,
    }
    floatwin.open(content, data, gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeCharacter", function()
    local data = char_gen.character()
    local content = char_gen.to_float_content(data)
    local gen = {
      generate = char_gen.character,
      to_float_content = char_gen.to_float_content,
      to_markdown = char_gen.to_markdown,
    }
    floatwin.open(content, data, gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeCreature", function()
    local data = creature_gen.creature()
    local content = creature_gen.to_float_content(data)
    local gen = {
      generate = creature_gen.creature,
      to_float_content = creature_gen.to_float_content,
      to_markdown = creature_gen.to_markdown,
    }
    floatwin.open(content, data, gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeEncounter", function(opts)
    local location = opts.args ~= "" and opts.args or nil
    local data = encounter_gen.encounter(location)
    local content = encounter_gen.to_float_content(data)
    local gen = {
      generate = function() return encounter_gen.encounter(location) end,
      to_float_content = encounter_gen.to_float_content,
      to_markdown = encounter_gen.to_markdown,
    }
    floatwin.open(content, data, gen)
  end, { nargs = "?", complete = function() return { "urban", "wilderness", "dungeon", "rural" } end })

  vim.api.nvim_create_user_command("ForgeTreasure", function(opts)
    local level = tonumber(opts.args) or 1
    local data = treasure_gen.treasure(level)
    local content = treasure_gen.to_float_content(data)
    local gen = {
      generate = function() return treasure_gen.treasure(level) end,
      to_float_content = treasure_gen.to_float_content,
      to_markdown = treasure_gen.to_markdown,
    }
    floatwin.open(content, data, gen)
  end, { nargs = "?", complete = function() return { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" } end })

  vim.api.nvim_create_user_command("ForgeSettlement", function()
    local data = settlements.get_settlement()
    local content = "┌─────────────────────────────────────────┐\n" ..
      "│  FORGE: Random Settlement                │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│                                         │\n" ..
      "│  Name: " .. string.format("%-30s", data.name) .. "│\n" ..
      "│  Government: " .. string.format("%-23s", data.government) .. "│\n" ..
      "│  Population: " .. string.format("%-23s", data.population) .. "│\n" ..
      "│  Industry: " .. string.format("%-25s", data.industry) .. "│\n" ..
      "│  Secret: " .. string.format("%-27s", data.secret) .. "│\n" ..
      "│                                         │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│  [q] close  [r] re-roll  [i] insert    │\n" ..
      "└─────────────────────────────────────────┘"
    local gen = {
      generate = settlements.get_settlement,
      to_float_content = function(d)
        return "┌─────────────────────────────────────────┐\n" ..
          "│  FORGE: Random Settlement                │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│                                         │\n" ..
          "│  Name: " .. string.format("%-30s", d.name) .. "│\n" ..
          "│  Government: " .. string.format("%-23s", d.government) .. "│\n" ..
          "│  Population: " .. string.format("%-23s", d.population) .. "│\n" ..
          "│  Industry: " .. string.format("%-25s", d.industry) .. "│\n" ..
          "│  Secret: " .. string.format("%-27s", d.secret) .. "│\n" ..
          "│                                         │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│  [q] close  [r] re-roll  [i] insert    │\n" ..
          "└─────────────────────────────────────────┘"
      end,
      to_markdown = function(d)
        return "## FORGE: Random Settlement\n\n| Category | Value |\n|----------|-------|\n| **Name** | " .. d.name .. " |\n| **Government** | " .. d.government .. " |\n| **Population** | " .. d.population .. " |\n| **Industry** | " .. d.industry .. " |\n| **Secret** | " .. d.secret .. " |"
      end,
    }
    floatwin.open(content, data, gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeTavern", function()
    local name = settlements.get_tavern_name()
    local content = "┌─────────────────────────────────────────┐\n" ..
      "│  FORGE: Random Tavern                     │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│                                         │\n" ..
      "│  Name: " .. string.format("%-30s", name) .. "│\n" ..
      "│                                         │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│  [q] close  [r] re-roll  [i] insert    │\n" ..
      "└─────────────────────────────────────────┘"
    local gen = {
      generate = function() return { name = settlements.get_tavern_name() } end,
      to_float_content = function(d) return content end,
      to_markdown = function(d) return "## FORGE: Random Tavern\n\n**Name:** " .. d.name end,
    }
    floatwin.open(content, gen.generate(), gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeGear", function()
    local gear = equip.get_adventuring_gear(5)
    local content = "┌─────────────────────────────────────────┐\n" ..
      "│  FORGE: Adventuring Gear                 │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│                                         │\n" ..
      "│  " .. string.format("%-34s", gear[1] or "") .. "│\n" ..
      "│  " .. string.format("%-34s", gear[2] or "") .. "│\n" ..
      "│  " .. string.format("%-34s", gear[3] or "") .. "│\n" ..
      "│  " .. string.format("%-34s", gear[4] or "") .. "│\n" ..
      "│  " .. string.format("%-34s", gear[5] or "") .. "│\n" ..
      "│                                         │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│  [q] close  [r] re-roll  [i] insert    │\n" ..
      "└─────────────────────────────────────────┘"
    local gen = {
      generate = function() return { gear = equip.get_adventuring_gear(5) } end,
      to_float_content = function(d)
        local c = "┌─────────────────────────────────────────┐\n" ..
          "│  FORGE: Adventuring Gear                 │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│                                         │\n"
        for i = 1, 5 do
          c = c .. "│  " .. string.format("%-34s", d.gear[i] or "") .. "│\n"
        end
        c = c .. "│                                         │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│  [q] close  [r] re-roll  [i] insert    │\n" ..
          "└─────────────────────────────────────────┘"
        return c
      end,
      to_markdown = function(d)
        local md = "## FORGE: Adventuring Gear\n\n"
        for _, item in ipairs(d.gear) do
          md = md .. "- " .. item .. "\n"
        end
        return md
      end,
    }
    floatwin.open(content, gen.generate(), gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeWeapon", function()
    local weapon = equip.get_weapon()
    local content = "┌─────────────────────────────────────────┐\n" ..
      "│  FORGE: Random Weapon                    │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│                                         │\n" ..
      "│  Name: " .. string.format("%-30s", weapon.name) .. "│\n" ..
      "│  Type: " .. string.format("%-30s", weapon.type) .. "│\n" ..
      "│  Damage: " .. string.format("%-27s", "d" .. weapon.damage) .. "│\n" ..
      "│  Slots: " .. string.format("%-27s", weapon.slots) .. "│\n" ..
      "│  Cost: " .. string.format("%-29s", weapon.cost) .. "│\n" ..
      "│                                         │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│  [q] close  [r] re-roll  [i] insert    │\n" ..
      "└─────────────────────────────────────────┘"
    local gen = {
      generate = equip.get_weapon,
      to_float_content = function(d)
        return "┌─────────────────────────────────────────┐\n" ..
          "│  FORGE: Random Weapon                    │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│                                         │\n" ..
          "│  Name: " .. string.format("%-30s", d.name) .. "│\n" ..
          "│  Type: " .. string.format("%-30s", d.type) .. "│\n" ..
          "│  Damage: " .. string.format("%-27s", "d" .. d.damage) .. "│\n" ..
          "│  Slots: " .. string.format("%-27s", d.slots) .. "│\n" ..
          "│  Cost: " .. string.format("%-29s", d.cost) .. "│\n" ..
          "│                                         │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│  [q] close  [r] re-roll  [i] insert    │\n" ..
          "└─────────────────────────────────────────┘"
      end,
      to_markdown = function(d)
        return "## FORGE: Random Weapon\n\n| Stat | Value |\n|------|-------|\n| **Name** | " .. d.name .. " |\n| **Type** | " .. d.type .. " |\n| **Damage** | d" .. d.damage .. " |\n| **Slots** | " .. d.slots .. " |\n| **Cost** | " .. d.cost .. " |"
      end,
    }
    floatwin.open(content, weapon, gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeScars", function()
    local scar = misc.get_scar()
    local content = "┌─────────────────────────────────────────┐\n" ..
      "│  FORGE: Random Scar                      │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│                                         │\n" ..
      "│  Scar: " .. string.format("%-29s", scar.name) .. "│\n" ..
      "│  Attribute: " .. string.format("%-24s", scar.attribute) .. "│\n" ..
      "│  Reduction: " .. string.format("%-23s", "-" .. scar.reduction) .. "│\n" ..
      "│                                         │\n" ..
      "├─────────────────────────────────────────┤\n" ..
      "│  [q] close  [r] re-roll  [i] insert    │\n" ..
      "└─────────────────────────────────────────┘"
    local gen = {
      generate = misc.get_scar,
      to_float_content = function(d)
        return "┌─────────────────────────────────────────┐\n" ..
          "│  FORGE: Random Scar                      │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│                                         │\n" ..
          "│  Scar: " .. string.format("%-29s", d.name) .. "│\n" ..
          "│  Attribute: " .. string.format("%-24s", d.attribute) .. "│\n" ..
          "│  Reduction: " .. string.format("%-23s", "-" .. d.reduction) .. "│\n" ..
          "│                                         │\n" ..
          "├─────────────────────────────────────────┤\n" ..
          "│  [q] close  [r] re-roll  [i] insert    │\n" ..
          "└─────────────────────────────────────────┘"
      end,
      to_markdown = function(d)
        return "## FORGE: Random Scar\n\n**Scar:** " .. d.name .. "\n\n**Attribute Affected:** " .. d.attribute .. "\n\n**Reduction:** -" .. d.reduction .. " to " .. d.attribute .. " score"
      end,
    }
    floatwin.open(content, scar, gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeHelp", function()
    local content = [[┌─────────────────────────────────────────┐
│  FORGE: Commands                          │
├─────────────────────────────────────────┤
│                                         │
│  :ForgeRoll <dice>  - Roll dice         │
│  :ForgeName [race]  - Random name       │
│  :ForgeNPC          - Random NPC        │
│  :ForgeCharacter    - Random PC         │
│  :ForgeCreature     - Random creature   │
│  :ForgeEncounter    - Random encounter  │
│  :ForgeTreasure [n] - Treasure level    │
│  :ForgeSettlement   - Random settlement │
│  :ForgeTavern       - Random tavern    │
│  :ForgeGear         - Random gear      │
│  :ForgeWeapon       - Random weapon    │
│  :ForgeScars        - Random scar      │
│  :ForgeHelp         - This help       │
│                                         │
│  Keys: q=close r=reroll i=insert       │
├─────────────────────────────────────────┤
│  [q] close                             │
└─────────────────────────────────────────┘]]
    local gen = {
      generate = function() return {} end,
      to_float_content = function() return content end,
      to_markdown = function() return "## FORGE Commands\n\n```\n" .. content .. "\n```" end,
    }
    floatwin.open(content, {}, gen)
  end, {})
end

return M
