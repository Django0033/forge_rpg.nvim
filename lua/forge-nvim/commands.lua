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

local function make_gen(opts)
  return {
    generate = opts.generate,
    to_float_content = opts.to_float_content,
    to_markdown = opts.to_markdown,
  }
end

function M.setup()
  vim.api.nvim_create_user_command("ForgeRoll", function(opts)
    local notation = opts.args ~= "" and opts.args or "d20"
    local gen = make_gen({
      generate = function() return { notation = notation, result = dice.parse(notation) } end,
      to_float_content = function(d)
        return "FORGE: Dice Roll\n\nRoll: " .. notation .. "\n\nResult: " .. d.result .. "\n\n[q] close  [r] re-roll  [i] insert"
      end,
      to_markdown = function(d)
        return "## FORGE: Dice Roll\n\n**Notation:** " .. notation .. "\n\n**Result:** " .. d.result
      end,
    })
    floatwin.open(gen.to_float_content(gen.generate()), gen.generate(), gen)
  end, { nargs = "?", complete = function() return { "d20", "d6", "d8", "3d6", "2d6+2", "d66" } end })

  vim.api.nvim_create_user_command("ForgeName", function(opts)
    local race = opts.args ~= "" and opts.args or "human"
    local name = names.get_name(race)
    local gen = make_gen({
      generate = function() return { name = names.get_name(race), race = race } end,
      to_float_content = function(d)
        return "FORGE: Random Name\n\nName: " .. d.name .. "\nRace: " .. d.race:gsub("^%l", string.upper) .. "\n\n[q] close  [r] re-roll  [i] insert"
      end,
      to_markdown = function(d)
        return "## FORGE: Random Name\n\n**Name:** " .. d.name .. "\n\n**Race:** " .. d.race:gsub("^%l", string.upper)
      end,
    })
    floatwin.open(gen.to_float_content(gen.generate()), gen.generate(), gen)
  end, { nargs = "?", complete = function() return { "human", "elf", "dwarf", "halfling", "gnome", "goblin", "orc", "troll" } end })

  vim.api.nvim_create_user_command("ForgeNPC", function()
    local data = npc_gen.npc()
    floatwin.open(npc_gen.to_float_content(data), data, npc_gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeCharacter", function()
    local data = char_gen.character()
    floatwin.open(char_gen.to_float_content(data), data, char_gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeCreature", function()
    local data = creature_gen.creature()
    floatwin.open(creature_gen.to_float_content(data), data, creature_gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeEncounter", function(opts)
    local location = opts.args ~= "" and opts.args or nil
    local data = encounter_gen.encounter(location)
    local gen = make_gen({
      generate = function() return encounter_gen.encounter(location) end,
      to_float_content = encounter_gen.to_float_content,
      to_markdown = encounter_gen.to_markdown,
    })
    floatwin.open(encounter_gen.to_float_content(data), data, gen)
  end, { nargs = "?", complete = function() return { "urban", "wilderness", "dungeon", "rural" } end })

  vim.api.nvim_create_user_command("ForgeTreasure", function(opts)
    local level = tonumber(opts.args) or 1
    local data = treasure_gen.treasure(level)
    local gen = make_gen({
      generate = function() return treasure_gen.treasure(level) end,
      to_float_content = treasure_gen.to_float_content,
      to_markdown = treasure_gen.to_markdown,
    })
    floatwin.open(treasure_gen.to_float_content(data), data, gen)
  end, { nargs = "?", complete = function() return { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" } end })

  vim.api.nvim_create_user_command("ForgeSettlement", function()
    local data = settlements.get_settlement()
    local gen = make_gen({
      generate = settlements.get_settlement,
      to_float_content = function(d)
        return "FORGE: Random Settlement\n\nName: " .. d.name .. "\nGovernment: " .. d.government .. "\nPopulation: " .. d.population .. "\nIndustry: " .. d.industry .. "\nSecret: " .. d.secret .. "\n\n[q] close  [r] re-roll  [i] insert"
      end,
      to_markdown = function(d)
        return "## FORGE: Random Settlement\n\n| Category | Value |\n|----------|-------|\n| **Name** | " .. d.name .. " |\n| **Government** | " .. d.government .. " |\n| **Population** | " .. d.population .. " |\n| **Industry** | " .. d.industry .. " |\n| **Secret** | " .. d.secret .. " |"
      end,
    })
    floatwin.open(gen.to_float_content(data), data, gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeTavern", function()
    local name = settlements.get_tavern_name()
    local gen = make_gen({
      generate = function() return { name = settlements.get_tavern_name() } end,
      to_float_content = function(d)
        return "FORGE: Random Tavern\n\nName: " .. d.name .. "\n\n[q] close  [r] re-roll  [i] insert"
      end,
      to_markdown = function(d)
        return "## FORGE: Random Tavern\n\n**Name:** " .. d.name
      end,
    })
    floatwin.open(gen.to_float_content(gen.generate()), gen.generate(), gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeGear", function()
    local gear = equip.get_adventuring_gear(5)
    local gen = make_gen({
      generate = function() return { gear = equip.get_adventuring_gear(5) } end,
      to_float_content = function(d)
        local lines = { "FORGE: Adventuring Gear", "" }
        for _, item in ipairs(d.gear) do
          table.insert(lines, "- " .. item)
        end
        table.insert(lines, "")
        table.insert(lines, "[q] close  [r] re-roll  [i] insert")
        return table.concat(lines, "\n")
      end,
      to_markdown = function(d)
        local md = "## FORGE: Adventuring Gear\n\n"
        for _, item in ipairs(d.gear) do
          md = md .. "- " .. item .. "\n"
        end
        return md
      end,
    })
    floatwin.open(gen.to_float_content(gen.generate()), gen.generate(), gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeWeapon", function()
    local weapon = equip.get_weapon()
    local gen = make_gen({
      generate = equip.get_weapon,
      to_float_content = function(d)
        return "FORGE: Random Weapon\n\nName: " .. d.name .. "\nType: " .. d.type .. "\nDamage: d" .. d.damage .. "\nSlots: " .. d.slots .. "\nCost: " .. d.cost .. "\n\n[q] close  [r] re-roll  [i] insert"
      end,
      to_markdown = function(d)
        return "## FORGE: Random Weapon\n\n| Stat | Value |\n|------|-------|\n| **Name** | " .. d.name .. " |\n| **Type** | " .. d.type .. " |\n| **Damage** | d" .. d.damage .. " |\n| **Slots** | " .. d.slots .. " |\n| **Cost** | " .. d.cost .. " |"
      end,
    })
    floatwin.open(gen.to_float_content(weapon), weapon, gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeScars", function()
    local scar = misc.get_scar()
    local gen = make_gen({
      generate = misc.get_scar,
      to_float_content = function(d)
        return "FORGE: Random Scar\n\nScar: " .. d.name .. "\nAttribute: " .. d.attribute .. "\nReduction: -" .. d.reduction .. "\n\n[q] close  [r] re-roll  [i] insert"
      end,
      to_markdown = function(d)
        return "## FORGE: Random Scar\n\n**Scar:** " .. d.name .. "\n\n**Attribute Affected:** " .. d.attribute .. "\n\n**Reduction:** -" .. d.reduction .. " to " .. d.attribute .. " score"
      end,
    })
    floatwin.open(gen.to_float_content(scar), scar, gen)
  end, {})

  vim.api.nvim_create_user_command("ForgeHelp", function()
    local gen = make_gen({
      generate = function() return {} end,
      to_float_content = function()
        return "FORGE Commands\n\n" ..
          ":ForgeRoll <dice>  - Roll dice\n" ..
          ":ForgeName [race]  - Random name\n" ..
          ":ForgeNPC          - Random NPC\n" ..
          ":ForgeCharacter    - Random PC\n" ..
          ":ForgeCreature     - Random creature\n" ..
          ":ForgeEncounter    - Random encounter\n" ..
          ":ForgeTreasure [n] - Treasure level\n" ..
          ":ForgeSettlement   - Random settlement\n" ..
          ":ForgeTavern       - Random tavern\n" ..
          ":ForgeGear         - Random gear\n" ..
          ":ForgeWeapon       - Random weapon\n" ..
          ":ForgeScars        - Random scar\n" ..
          ":ForgeHelp         - This help\n\n" ..
          "Keys: q=close r=reroll i=insert"
      end,
      to_markdown = function()
        return "## FORGE Commands\n\n| Command | Description |\n|---------|-------------|\n" ..
          "| `:ForgeRoll <dice>` | Roll dice |\n" ..
          "| `:ForgeName [race]` | Random name |\n" ..
          "| `:ForgeNPC` | Random NPC |\n" ..
          "| `:ForgeCharacter` | Random PC |\n" ..
          "| `:ForgeCreature` | Random creature |\n" ..
          "| `:ForgeEncounter` | Random encounter |\n" ..
          "| `:ForgeTreasure [n]` | Treasure level |\n" ..
          "| `:ForgeSettlement` | Random settlement |\n" ..
          "| `:ForgeTavern` | Random tavern |\n" ..
          "| `:ForgeGear` | Random gear |\n" ..
          "| `:ForgeWeapon` | Random weapon |\n" ..
          "| `:ForgeScars` | Random scar |\n" ..
          "| `:ForgeHelp` | This help |"
      end,
    })
    floatwin.open(gen.to_float_content(), {}, gen)
  end, {})
end

return M
