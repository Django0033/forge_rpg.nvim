local M = {}

function M.npc()
  local dice = require("forge-nvim.dice")
  local names = require("forge-nvim.tables.names")
  local chars = require("forge-nvim.tables.characters")
  local misc = require("forge-nvim.tables.misc")

  local races = { "human", "elf", "dwarf", "halfling", "gnome", "goblin", "orc" }
  local race = races[dice.roll(#races)]
  local name = names.get_name(race)

  local occupation = chars.get_occupation()
  local personality = chars.get_personality()
  local appearance = chars.get_appearance()
  local quirk = chars.get_quirk()
  local clothing = chars.get_clothing()
  local motivation = misc.get_motivation()

  return {
    name = name,
    race = race,
    occupation = occupation,
    personality = personality,
    appearance = appearance,
    quirk = quirk,
    clothing = clothing,
    motivation = motivation,
  }
end

function M.to_markdown(data)
  local lines = {}
  table.insert(lines, "## FORGE: Random NPC")
  table.insert(lines, "")
  table.insert(lines, "| Category | Detail |")
  table.insert(lines, "|----------|--------|")
  table.insert(lines, "| **Name** | " .. data.name .. " (" .. data.race:gsub("^%l", string.upper) .. ") |")
  table.insert(lines, "| **Occupation** | " .. data.occupation .. " |")
  table.insert(lines, "| **Personality** | " .. data.personality .. " |")
  table.insert(lines, "| **Appearance** | " .. data.appearance .. " |")
  table.insert(lines, "| **Quirk** | " .. data.quirk .. " |")
  table.insert(lines, "| **Clothing** | " .. data.clothing .. " |")
  table.insert(lines, "| **Motivation** | " .. data.motivation.full .. " |")
  table.insert(lines, "")
  return table.concat(lines, "\n")
end

function M.to_float_content(data)
  local lines = {}
  table.insert(lines, "┌─────────────────────────────────────────┐")
  table.insert(lines, "│  FORGE: Random NPC                     │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Name: " .. string.format("%-30s", data.name) .. "│")
  table.insert(lines, "│  Race: " .. string.format("%-30s", data.race:gsub("^%l", string.upper)) .. "│")
  table.insert(lines, "│  Occupation: " .. string.format("%-25s", data.occupation) .. "│")
  table.insert(lines, "│  Personality: " .. string.format("%-24s", data.personality) .. "│")
  table.insert(lines, "│  Appearance: " .. string.format("%-25s", data.appearance) .. "│")
  table.insert(lines, "│  Quirk: " .. string.format("%-30s", data.quirk) .. "│")
  table.insert(lines, "│  Clothing: " .. string.format("%-26s", data.clothing) .. "│")
  table.insert(lines, "│  Motivation: " .. string.format("%-25s", data.motivation.full) .. "│")
  table.insert(lines, "│                                         │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│  [q] close  [r] re-roll  [i] insert    │")
  table.insert(lines, "└─────────────────────────────────────────┘")
  return table.concat(lines, "\n")
end

return M
