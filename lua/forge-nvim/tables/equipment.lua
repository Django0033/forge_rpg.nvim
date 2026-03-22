local M = {}

M.weapons = {
  { "1", "Light Melee", "Dagger", "d6", "1", "10 gp" },
  { "2", "Light Melee", "Shortsword", "d6", "1", "10 gp" },
  { "3", "Light Melee", "Cudgel", "d6", "1", "10 gp" },
  { "4", "Light Melee", "Sickle", "d6", "1", "10 gp" },
  { "5", "Light Melee", "Rapier", "d6", "1", "10 gp" },
  { "6", "Medium Melee", "Longsword", "d8", "2", "30 gp" },
  { "7", "Medium Melee", "Spear", "d8", "2", "30 gp" },
  { "8", "Medium Melee", "Mace", "d8", "2", "30 gp" },
  { "9", "Medium Melee", "Axe", "d8", "2", "30 gp" },
  { "10", "Medium Melee", "Flail", "d8", "2", "30 gp" },
  { "11", "Heavy Melee", "Greatsword", "d10", "3", "50 gp" },
  { "12", "Heavy Melee", "Greataxe", "d10", "3", "50 gp" },
  { "13", "Heavy Melee", "Halberd", "d10", "3", "50 gp" },
  { "14", "Heavy Melee", "Maul", "d10", "3", "50 gp" },
  { "15", "Ranged Light", "Sling", "d4", "1", "30 gp" },
  { "16", "Ranged Light", "Hand Crossbow", "d4", "1", "30 gp" },
  { "17", "Ranged Light", "Shortbow", "d4", "1", "30 gp" },
  { "18", "Ranged Heavy", "Longbow", "d6", "2", "50 gp" },
  { "19", "Ranged Heavy", "Crossbow", "d6", "2", "50 gp" },
  { "20", "Improvised", "Table Leg", "d4", "1", "-" },
}

M.armour = {
  { "1", "None", "10", "0", "0" },
  { "2", "Padded/Cloth", "11", "1", "5 gp" },
  { "3", "Leather", "12", "1", "15 gp" },
  { "4", "Studded Leather", "13", "2", "25 gp" },
  { "5", "Chain", "14", "2", "40 gp" },
  { "6", "Scale", "15", "3", "50 gp" },
  { "7", "Plate", "16", "3", "200 gp" },
  { "8", "Shield", "+1", "1", "10 gp" },
  { "9", "Helmet", "+1", "1", "5 gp" },
}

M.gear = {
  { "11", "Backpack" }, { "12", "Bedroll" }, { "13", "Rope (Far)" },
  { "14", "Torch" }, { "15", "Rations (3)" }, { "16", "Waterskin" },
  { "21", "Tinderbox" }, { "22", "Lantern" }, { "23", "Oil Flask" },
  { "24", "Grappling Hook" }, { "25", "Crowbar" }, { "26", "Hammer" },
  { "31", "Spikes (x5)" }, { "32", "Chalk" }, { "33", "Mirror" },
  { "34", "Iron Tongs" }, { "35", "Bucket" }, { "36", "Block and Tackle" },
  { "41", "Thieves' Tools" }, { "42", "Manacles" }, { "43", "Bear Trap" },
  { "44", "Net" }, { "45", "Holy Symbol" }, { "46", "Arcane Focus" },
  { "51", "Spyglass" }, { "52", "Hourglass" }, { "53", "Compass" },
  { "54", "Map Scroll" }, { "55", "Quill and Ink" }, { "56", "Parchment (5)" },
  { "61", "Healing Potion" }, { "62", "Antidote" }, { "63", "Poison" },
  { "64", "Acid Vial" }, { "65", "Alchemist Fire" }, { "66", "Holy Water" },
}

M.lighting = {
  { "1", "Candle (Close)", "1 gp" },
  { "2", "Torch (Near)", "2 gp" },
  { "3", "Lantern (Near)", "30 gp" },
  { "4", "Lantern Oil (4 hrs)", "5 gp" },
}

M.adventuring_gear = {
  { "11", "Air Bladder" }, { "12", "Antidote" }, { "13", "Bear Trap" },
  { "14", "Bedroll" }, { "15", "Block and Tackle" }, { "16", "Candles (x5)" },
  { "21", "Chain (Close)" }, { "22", "Chalk (x10)" }, { "23", "Crowbar" },
  { "24", "Grappling Hook" }, { "25", "Hammer" }, { "26", "Holy Water (vial)" },
  { "31", "Horn" }, { "32", "Incense (packet)" }, { "33", "Lantern" },
  { "34", "Mirror (hand)" }, { "35", "Net" }, { "36", "Oil Flask" },
  { "41", "Padlock and Key" }, { "42", "Pole (10ft)" }, { "43", "Rations (3)" },
  { "44", "Rope (Far)" }, { "45", "Sack / Pouch" }, { "46", "Saw" },
  { "51", "Shovel" }, { "52", "Spikes (x5)" }, { "53", "Spyglass" },
  { "54", "Tent (personal)" }, { "55", "Thieves' Tools" }, { "56", "Tinderbox" },
  { "61", "Torch" }, { "62", "Waterskin" }, { "63", "Whistle" },
  { "64", "Wolfsbane (bunch)" }, { "65", "Manacles" }, { "66", "Mason's Tools" },
}

function M.get_weapon()
  local dice = require("forge-nvim.dice")
  local roll = dice.roll(#M.weapons)
  local entry = M.weapons[roll]
  return {
    type = entry[2],
    name = entry[3],
    damage = entry[4],
    slots = entry[5],
    cost = entry[6],
    roll = roll,
  }
end

function M.get_armour()
  local dice = require("forge-nvim.dice")
  local roll = dice.roll(#M.armour)
  local entry = M.armour[roll]
  return {
    name = entry[2],
    ac = entry[3],
    slots = entry[4],
    cost = entry[5],
    roll = roll,
  }
end

function M.get_gear(count)
  count = count or 1
  local result = {}
  local dice = require("forge-nvim.dice")
  for _ = 1, count do
    local d66 = dice.d66()
    for _, entry in ipairs(M.gear) do
      if tonumber(entry[1]) == d66 then
        table.insert(result, entry[2])
        break
      end
    end
  end
  return result
end

function M.get_adventuring_gear(count)
  count = count or 1
  local result = {}
  local dice = require("forge-nvim.dice")
  for _ = 1, count do
    local roll = dice.roll(#M.adventuring_gear)
    table.insert(result, M.adventuring_gear[roll][2])
  end
  return result
end

return M
