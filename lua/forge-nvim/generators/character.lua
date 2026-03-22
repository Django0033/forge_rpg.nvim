local M = {}

local ATTRIBUTE_NAMES = { "STR", "DEX", "CON", "INT", "WIS", "CHA" }

function M.character()
  local dice = require("forge-nvim.dice")
  local names = require("forge-nvim.tables.names")
  local equip = require("forge-nvim.tables.equipment")
  local chars = require("forge-nvim.tables.characters")

  local attributes = {}
  for _, name in ipairs(ATTRIBUTE_NAMES) do
    local score = dice.roll(6) + dice.roll(6) + dice.roll(6)
    attributes[name] = {
      score = score,
      modifier = math.floor((score - 10) / 2),
    }
  end

  local primary = {
    ATTRIBUTE_NAMES[dice.roll(6)],
    ATTRIBUTE_NAMES[dice.roll(6)],
  }

  for _, attr in ipairs(ATTRIBUTE_NAMES) do
    local level = 1
    local is_primary = false
    for _, p in ipairs(primary) do
      if p == attr then is_primary = true break end
    end
    attributes[attr].check_bonus = is_primary and level or math.floor(level / 2)
  end

  local con_is_primary = false
  for _, p in ipairs(primary) do
    if p == "CON" then con_is_primary = true break end
  end

  local hd = con_is_primary and 8 or 6
  local hp = dice.roll(hd) + attributes.CON.modifier

  local races = { "human", "elf", "dwarf", "halfling", "gnome" }
  local race = races[dice.roll(#races)]
  local name = names.get_name(race)

  local weapon = equip.get_weapon()
  local gear = equip.get_adventuring_gear(3)

  local personality = chars.get_personality()
  local occupation = chars.get_occupation()
  local appearance = chars.get_appearance()

  return {
    name = name,
    race = race,
    level = 1,
    attributes = attributes,
    primary = primary,
    hd = hd,
    hp = hp,
    weapon = weapon,
    gear = gear,
    personality = personality,
    occupation = occupation,
    appearance = appearance,
  }
end

function M.to_markdown(data)
  local lines = {}
  table.insert(lines, "## FORGE: Random Character")
  table.insert(lines, "")
  table.insert(lines, "### Attributes")
  table.insert(lines, "")
  table.insert(lines, "| Attr | Score | Mod | Check |")
  table.insert(lines, "|------|-------|-----|-------|")
  for _, attr in ipairs(ATTRIBUTE_NAMES) do
    local a = data.attributes[attr]
    local is_primary = false
    for _, p in ipairs(data.primary) do
      if p == attr then is_primary = true break end
    end
    local primary_mark = is_primary and " (P)" or ""
    table.insert(lines, "| " .. attr .. primary_mark .. " | " .. a.score .. " | " .. string.format("%+d", a.modifier) .. " | +" .. a.check_bonus .. " |")
  end
  table.insert(lines, "")
  table.insert(lines, "### Details")
  table.insert(lines, "")
  table.insert(lines, "| Category | Value |")
  table.insert(lines, "|----------|-------|")
  table.insert(lines, "| **Name** | " .. data.name .. " |")
  table.insert(lines, "| **Race** | " .. data.race:gsub("^%l", string.upper) .. " |")
  table.insert(lines, "| **Level** | " .. data.level .. " |")
  table.insert(lines, "| **Hit Die** | d" .. data.hd .. " |")
  table.insert(lines, "| **HP** | " .. data.hp .. " |")
  table.insert(lines, "| **Primary** | " .. table.concat(data.primary, ", ") .. " |")
  table.insert(lines, "| **Weapon** | " .. data.weapon.name .. " (" .. data.weapon.damage .. ") |")
  table.insert(lines, "| **Occupation** | " .. data.occupation .. " |")
  table.insert(lines, "| **Personality** | " .. data.personality .. " |")
  table.insert(lines, "| **Appearance** | " .. data.appearance .. " |")
  table.insert(lines, "")
  table.insert(lines, "### Gear")
  for _, item in ipairs(data.gear) do
    table.insert(lines, "- " .. item)
  end
  table.insert(lines, "")
  return table.concat(lines, "\n")
end

function M.to_float_content(data)
  local lines = {}
  table.insert(lines, "┌─────────────────────────────────────────┐")
  table.insert(lines, "│  FORGE: Random Character               │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  " .. string.format("%-34s", data.name) .. "│")
  table.insert(lines, "│  " .. string.format("%-34s", data.race:gsub("^%l", string.upper) .. " - Level " .. data.level) .. "│")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  HP: " .. data.hp .. "  |  HD: d" .. data.hd .. "            │")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Primary: " .. table.concat(data.primary, ", ") .. "       │")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  STR: " .. string.format("%+d", data.attributes.STR.modifier) .. "  DEX: " .. string.format("%+d", data.attributes.DEX.modifier) .. "  CON: " .. string.format("%+d", data.attributes.CON.modifier) .. "  │")
  table.insert(lines, "│  INT: " .. string.format("%+d", data.attributes.INT.modifier) .. "  WIS: " .. string.format("%+d", data.attributes.WIS.modifier) .. "  CHA: " .. string.format("%+d", data.attributes.CHA.modifier) .. "  │")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Weapon: " .. string.format("%-22s", data.weapon.name .. " (" .. data.weapon.damage .. ")") .. "│")
  table.insert(lines, "│  Occupation: " .. string.format("%-23s", data.occupation) .. "│")
  table.insert(lines, "│  Personality: " .. string.format("%-22s", data.personality) .. "│")
  table.insert(lines, "│                                         │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│  [q] close  [r] re-roll  [i] insert    │")
  table.insert(lines, "└─────────────────────────────────────────┘")
  return table.concat(lines, "\n")
end

return M
