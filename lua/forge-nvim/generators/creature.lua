local M = {}

function M.creature()
  local dice = require("forge-nvim.dice")
  local creatures = require("forge-nvim.tables.creatures")
  local names = require("forge-nvim.tables.names")
  local misc = require("forge-nvim.tables.misc")

  local encounter_type_roll = dice.roll(6) + dice.roll(6)
  local creature

  if encounter_type_roll <= 6 then
    creature = creatures.get_beast("earthbound")
    creature.level = dice.roll(4)
    creature.ac = 10 + dice.roll(6)
    creature.hp = dice.roll(6) * creature.level
    creature.morale = 6 + dice.roll(6)
    creature.damage = "1d" .. (dice.roll(6) + 2)
  elseif encounter_type_roll <= 9 then
    creature = creatures.get_beast("earthbound")
    creature.level = dice.roll(4)
    creature.ac = 10 + dice.roll(6)
    creature.hp = dice.roll(6) * creature.level
    creature.morale = 6 + dice.roll(6)
    creature.damage = "1d" .. (dice.roll(6) + 2)
  elseif encounter_type_roll <= 11 then
    creature = creatures.get_humanoid("common")
    creature.level = dice.roll(4)
    creature.ac = 10 + dice.roll(6)
    creature.hp = dice.roll(6) * creature.level
    creature.morale = 6 + dice.roll(6)
    creature.damage = "1d" .. (dice.roll(6) + 2)
  else
    creature = creatures.get_monster()
    creature.level = dice.roll(8)
    creature.ac = 10 + dice.roll(8)
    creature.hp = dice.roll(8) * creature.level
    creature.morale = 8 + dice.roll(6)
    creature.damage = "1d" .. (dice.roll(8) + 4)
  end

  local behaviour = creatures.get_behaviour()
  local reaction = misc.get_reaction()

  return {
    creature = creature,
    behaviour = behaviour,
    reaction = reaction,
    roll = encounter_type_roll,
  }
end

function M.to_markdown(data)
  local c = data.creature
  local lines = {}
  table.insert(lines, "## FORGE: Random Creature")
  table.insert(lines, "")
  table.insert(lines, "| Stat | Value |")
  table.insert(lines, "|------|-------|")
  table.insert(lines, "| **Type** | " .. c.type .. " |")
  table.insert(lines, "| **Name** | " .. c.name .. " |")
  table.insert(lines, "| **Level** | " .. c.level .. " |")
  table.insert(lines, "| **AC** | " .. c.ac .. " |")
  table.insert(lines, "| **HP** | " .. c.hp .. " |")
  table.insert(lines, "| **Morale** | " .. c.morale .. " |")
  table.insert(lines, "| **Damage** | " .. c.damage .. " |")
  if c.ability then
    table.insert(lines, "| **Ability** | " .. c.ability .. " |")
  end
  table.insert(lines, "| **Behaviour** | " .. data.behaviour.action .. " |")
  table.insert(lines, "| **Reaction** | " .. data.reaction.disposition .. " (" .. data.reaction.roll .. ") |")
  table.insert(lines, "")
  return table.concat(lines, "\n")
end

function M.to_float_content(data)
  local c = data.creature
  local lines = {}
  table.insert(lines, "┌─────────────────────────────────────────┐")
  table.insert(lines, "│  FORGE: Random Creature                 │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Name: " .. string.format("%-30s", c.name) .. "│")
  table.insert(lines, "│  Type: " .. string.format("%-30s", c.type) .. "│")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Level: " .. c.level .. "  AC: " .. c.ac .. "  HP: " .. c.hp .. "        │")
  table.insert(lines, "│  Morale: " .. c.morale .. "  Damage: " .. c.damage .. "           │")
  if c.ability then
    table.insert(lines, "│                                         │")
    table.insert(lines, "│  Ability: " .. string.format("%-25s", c.ability) .. "│")
  end
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Behaviour: " .. string.format("%-23s", data.behaviour.action) .. "│")
  table.insert(lines, "│  Reaction: " .. string.format("%-24s", data.reaction.disposition) .. "│")
  table.insert(lines, "│                                         │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│  [q] close  [r] re-roll  [i] insert    │")
  table.insert(lines, "└─────────────────────────────────────────┘")
  return table.concat(lines, "\n")
end

return M
