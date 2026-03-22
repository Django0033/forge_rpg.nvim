local M = {}

function M.encounter(location)
  local dice = require("forge-nvim.dice")
  local creatures = require("forge-nvim.tables.creatures")
  local misc = require("forge-nvim.tables.misc")

  local location_mod = 0
  if location == "urban" then location_mod = -2
  elseif location == "wilderness" then location_mod = 1
  elseif location == "dungeon" then location_mod = 0
  elseif location == "rural" then location_mod = 2
  end

  local creature_roll = dice.roll(6) + dice.roll(6) + location_mod
  local encounter_type
  if creature_roll <= 6 then
    encounter_type = creatures.get_humanoid("common")
  elseif creature_roll <= 9 then
    encounter_type = creatures.get_beast("earthbound")
  elseif creature_roll <= 12 then
    encounter_type = creatures.get_humanoid("uncommon")
  else
    encounter_type = creatures.get_monster()
  end

  local reaction = misc.get_reaction()

  local distance_roll = dice.roll(6)
  local distances = { "Close (5-15')", "Near (~30')", "Far (~60')", "Very Far (~120')", "Distant (~240')", "Near (~30')" }
  local distance = distances[distance_roll]

  local count_roll = dice.roll(6)
  local count_mod = 0
  if count_roll <= 2 then count_mod = -2
  elseif count_roll <= 4 then count_mod = 0
  elseif count_roll <= 5 then count_mod = 1
  else count_mod = 2
  end

  local count_desc
  local base_count = 1
  if encounter_type.type == "Beast" then
    local beh = creatures.get_beast_behaviour()
    if count_roll <= 2 then
      count_desc = "Solitary (1)"
    elseif count_roll <= 5 then
      count_desc = "A pair (2)"
    else
      count_desc = "A pack (1d6+2: " .. (dice.roll(6) + 2) .. ")"
    end
  elseif encounter_type.type == "Humanoid" then
    if count_roll <= 2 then
      count_desc = "Solo (1)"
    elseif count_roll <= 5 then
      count_desc = "A pair (2)"
    else
      count_desc = "A group (1d6+2: " .. (dice.roll(6) + 2) .. ")"
    end
  else
    if count_roll <= 2 then
      count_desc = "Solo (1)"
    elseif count_roll <= 5 then
      count_desc = "A pair (2)"
    else
      count_desc = "Multiple (1d4: " .. dice.roll(4) .. ")"
    end
  end

  local behaviour = creatures.get_behaviour()
  local motivation = misc.get_motivation()

  return {
    type = encounter_type.type,
    creature = encounter_type,
    reaction = reaction,
    distance = distance,
    distance_roll = distance_roll,
    count = count_desc,
    count_roll = count_roll,
    behaviour = behaviour,
    motivation = motivation,
  }
end

function M.to_markdown(data)
  local lines = {}
  table.insert(lines, "## FORGE: Random Encounter")
  table.insert(lines, "")
  table.insert(lines, "| Category | Detail |")
  table.insert(lines, "|----------|--------|")
  table.insert(lines, "| **Type** | " .. data.type .. " |")
  table.insert(lines, "| **Creature** | " .. data.creature.name .. " |")
  if data.creature.ability then
    table.insert(lines, "| **Ability** | " .. data.creature.ability .. " |")
  end
  table.insert(lines, "| **Reaction Roll** | 2d6 = " .. data.reaction.roll .. " |")
  table.insert(lines, "| **Disposition** | " .. data.reaction.disposition .. " |")
  table.insert(lines, "| **Description** | " .. data.reaction.description .. " |")
  table.insert(lines, "| **Distance** | " .. data.distance .. " |")
  table.insert(lines, "| **Count** | " .. data.count .. " |")
  table.insert(lines, "| **Behaviour** | " .. data.behaviour.action .. " |")
  table.insert(lines, "| **Motivation** | " .. data.motivation.full .. " |")
  table.insert(lines, "")
  return table.concat(lines, "\n")
end

function M.to_float_content(data)
  local lines = {}
  table.insert(lines, "┌─────────────────────────────────────────┐")
  table.insert(lines, "│  FORGE: Random Encounter                │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Type: " .. string.format("%-34s", data.type) .. "│")
  table.insert(lines, "│  Creature: " .. string.format("%-28s", data.creature.name) .. "│")
  if data.creature.ability then
    table.insert(lines, "│  Ability: " .. string.format("%-28s", data.creature.ability) .. "│")
  end
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Reaction: 2d6 = " .. string.format("%-22d", data.reaction.roll) .. "│")
  table.insert(lines, "│  Disposition: " .. string.format("%-25s", data.reaction.disposition) .. "│")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Distance: " .. string.format("%-27s", data.distance) .. "│")
  table.insert(lines, "│  Count: " .. string.format("%-30s", data.count) .. "│")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Behaviour: " .. string.format("%-26s", data.behaviour.action) .. "│")
  table.insert(lines, "│  Motivation: " .. string.format("%-26s", data.motivation.full) .. "│")
  table.insert(lines, "│                                         │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│  [q] close  [r] re-roll  [i] insert    │")
  table.insert(lines, "└─────────────────────────────────────────┘")
  return table.concat(lines, "\n")
end

return M
