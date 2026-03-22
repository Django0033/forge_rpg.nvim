local M = {}

M.gems = {
  { "11", "Azurite", "1d6 gp" }, { "12", "Blue Quartz", "1d6 gp" }, { "13", "Eye Agate", "1d6 gp" },
  { "14", "Hematite", "1d6 gp" }, { "15", "Lapis Lazuli", "1d6 gp" }, { "16", "Malachite", "1d6 gp" },
  { "21", "Moss Agate", "1d6 gp" }, { "22", "Obsidian", "1d6 gp" }, { "23", "Rhodochrosite", "1d6 gp" },
  { "24", "Tiger Eye", "1d6 gp" }, { "25", "Turquoise", "1d6 gp" }, { "26", "Pearl", "1d6 gp" },
  { "31", "Bloodstone", "2d6 gp" }, { "32", "Carnelian", "2d6 gp" }, { "33", "Chalcedony", "2d6 gp" },
  { "34", "Chrysoprase", "2d6 gp" }, { "35", "Citrine", "2d6 gp" }, { "36", "Jasper", "2d6 gp" },
  { "41", "Moonstone", "2d6 gp" }, { "42", "Onyx", "2d6 gp" }, { "43", "Quartz", "2d6 gp" },
  { "44", "Star Rose Quartz", "2d6 gp" }, { "45", "Zircon", "2d6 gp" }, { "46", "Amber", "2d6 gp" },
  { "51", "Jade", "2d6 x10 gp" }, { "52", "Turquoise", "2d6 x10 gp" }, { "53", "Garnet", "2d6 x10 gp" },
  { "54", "Pearl (Orient)", "2d6 x10 gp" }, { "55", "Topaz", "2d6 x10 gp" }, { "56", "Spinel", "2d6 x10 gp" },
  { "61", "Amethyst", "2d6 x10 gp" }, { "62", "Chrysoberyl", "2d6 x10 gp" }, { "63", "Coral", "2d6 x10 gp" },
  { "64", "Black Pearl", "2d6 x10 gp" }, { "65", "Golden Pearl", "2d6 x10 gp" }, { "66", "Fire Opal", "2d6 x10 gp" },
}

M.jewelry = {
  { "11", "Gold Ring", "2d6 x10 gp" }, { "12", "Silver Ring", "2d6 gp" },
  { "13", "Copper Bracelet", "1d6 gp" }, { "14", "Bronze Amulet", "1d6 x10 gp" },
  { "15", "Iron Pendant", "1d6 gp" }, { "16", "Crystal Necklace", "2d6 x10 gp" },
  { "21", "Jade Earrings", "2d6 x10 gp" }, { "22", "Ruby Studs", "3d6 x10 gp" },
  { "23", "Emerald Brooch", "4d6 x10 gp" }, { "24", "Diamond Circlet", "5d6 x100 gp" },
  { "25", "Sapphire Tiara", "6d6 x100 gp" }, { "26", "Platinum Crown", "10d6 x100 gp" },
}

M.treasure_by_level = {
  { level = 1, coins = "6d6 x100 cp", gems = "1d6", jewelry = 0, magic = "1d6: 10%" },
  { level = 2, coins = "2d6 x100 sp", gems = "1d6", jewelry = "1d6: 20%", magic = "1d6: 15%" },
  { level = 3, coins = "2d6 x100 ep", gems = "2d6", jewelry = "1d6: 25%", magic = "1d6: 20%" },
  { level = 4, coins = "2d6 x100 gp", gems = "2d6", jewelry = "1d6: 30%", magic = "1d6: 25%" },
  { level = 5, coins = "3d6 x100 gp", gems = "3d6", jewelry = "1d6: 35%", magic = "1d6: 30%" },
  { level = 6, coins = "4d6 x100 gp", gems = "3d6", jewelry = "2d6: 40%", magic = "1d6: 35%" },
  { level = 7, coins = "5d6 x100 gp", gems = "4d6", jewelry = "2d6: 45%", magic = "2d6: 40%" },
  { level = 8, coins = "6d6 x100 gp", gems = "4d6", jewelry = "2d6: 50%", magic = "2d6: 45%" },
  { level = 9, coins = "8d6 x100 gp", gems = "5d6", jewelry = "3d6: 55%", magic = "2d6: 50%" },
  { level = 10, coins = "10d6 x100 gp", gems = "6d6", jewelry = "3d6: 60%", magic = "3d6: 55%" },
}

M.magic_items_arcane = {
  { "11", "Potion of Healing" }, { "12", "Scroll of Magic Missile (1st)" },
  { "13", "Wand of Magic Missile (20 charges)" }, { "14", "Ring of Protection" },
  { "15", "Cloak of Elvenkind" }, { "16", "Boots of Elvenkind" },
  { "21", "Rope of Climbing" }, { "22", "Bag of Holding" },
  { "23", "Crystal Ball" }, { "24", "Staff of Fire (10 charges)" },
  { "25", "Wand of Lightning (15 charges)" }, { "26", "Amulet of Health" },
}

M.magic_items_divine = {
  { "11", "Potion of Healing" }, { "12", "Scroll of Cure Light Wounds" },
  { "13", "Holy Symbol (Silver)" }, { "14", "Shield +1" },
  { "15", "Mace +1" }, { "16", "Helm of Telepathy" },
  { "21", "Vestments of the Priest" }, { "22", "Boots of Speed" },
  { "23", "Ring of Regeneration" }, { "24", "Staff of Curing (15 charges)" },
  { "25", "Cloak of Protection +1" }, { "26", "Amulet of Life Saving" },
}

function M.roll_dice_string(str)
  local count, sides = str:match("(%d*)d(%d+)")
  count = tonumber(count) or 1
  sides = tonumber(sides)
  local total = 0
  for _ = 1, count do
    total = total + math.random(1, sides)
  end
  return total
end

function M.get_gem()
  local dice = require("forge-nvim.dice")
  local d66 = dice.d66()
  for _, entry in ipairs(M.gems) do
    if tonumber(entry[1]) == d66 then
      return { name = entry[2], value = entry[3], d66 = d66 }
    end
  end
  return { name = M.gems[1][2], value = M.gems[1][3] }
end

function M.get_jewelry()
  local dice = require("forge-nvim.dice")
  local d66 = dice.d66()
  for _, entry in ipairs(M.jewelry) do
    if tonumber(entry[1]) == d66 then
      return { name = entry[2], value = entry[3], d66 = d66 }
    end
  end
  return { name = M.jewelry[1][2], value = M.jewelry[1][3] }
end

function M.get_treasure(level)
  level = level or 1
  local treasure_data = M.treasure_by_level[level] or M.treasure_by_level[1]
  local result = {
    level = level,
    coins = M.roll_dice_string(treasure_data.coins),
    gems = {},
    jewelry = {},
    magic = {},
  }

  local gem_count = M.roll_dice_string(treasure_data.gems)
  for _ = 1, gem_count do
    table.insert(result.gems, M.get_gem())
  end

  local jewelry_chance = tonumber(treasure_data.jewelry:match("%d+")) or 0
  if math.random(1, 100) <= jewelry_chance then
    local jewelry_count = M.roll_dice_string(treasure_data.jewelry:match("%d*d%d") or "1d6")
    for _ = 1, jewelry_count do
      table.insert(result.jewelry, M.get_jewelry())
    end
  end

  local magic_chance = tonumber(treasure_data.magic:match("%d+") or "0")
  if math.random(1, 100) <= magic_chance then
    local magic_count = M.roll_dice_string(treasure_data.magic:match("%d*d%d") or "1d6")
    for _ = 1, magic_count do
      local item = M.magic_items_arcane[math.random(#M.magic_items_arcane)]
      table.insert(result.magic, item[2])
    end
  end

  return result
end

return M
