local M = {}

M.beasts = {
  earthbound = {
    { "11", "Ant" }, { "12", "Ape" }, { "13", "Badger" }, { "14", "Bat" },
    { "15", "Bear" }, { "16", "Boar" }, { "21", "Cat" }, { "22", "Centipede" },
    { "23", "Cheetah" }, { "24", "Dog" }, { "25", "Fox" }, { "26", "Horse" },
    { "31", "Lizard" }, { "32", "Mole" }, { "33", "Ox" }, { "34", "Panther" },
    { "35", "Porcupine" }, { "36", "Rat" }, { "41", "Scorpion" }, { "42", "Slug" },
    { "43", "Snail" }, { "44", "Snake" }, { "45", "Spider" }, { "46", "Termite" },
    { "51", "Tick" }, { "52", "Vole" }, { "53", "Weasel" }, { "54", "Worm" },
    { "55", "Beetle" }, { "56", "Spider" }, { "61", "Mole" }, { "62", "Rat" },
    { "63", "Toad" }, { "64", "Frog" }, { "65", "Lizard" }, { "66", "Snake" },
  },
  airborne = {
    { "11", "Bat" }, { "12", "Bee" }, { "13", "Butterfly" }, { "14", "Crow" },
    { "15", "Dragonfly" }, { "16", "Eagle" }, { "21", "Falcon" }, { "22", "Fly" },
    { "23", "Firefly" }, { "24", "Goose" }, { "25", "Hawk" }, { "26", "Moth" },
    { "31", "Parrot" }, { "32", "Owl" }, { "33", "Pelican" }, { "34", "Raven" },
    { "35", "Sparrow" }, { "36", "Swift" }, { "41", "Vulture" }, { "42", "Wasp" },
    { "43", "Wren" }, { "44", "Albatross" }, { "45", "Gull" }, { "46", "Heron" },
    { "51", "Kite" }, { "52", "Locust" }, { "53", "Mantis" }, { "54", "Mosquito" },
    { "55", "Gnat" }, { "56", "Hornet" }, { "61", "Stork" }, { "62", "Swallow" },
    { "63", "Jay" }, { "64", "Magpie" }, { "65", "Rook" }, { "66", "Nighthawk" },
  },
  aquatic = {
    { "11", "Anemone" }, { "12", "Barnacle" }, { "13", "Clam" }, { "14", "Crab" },
    { "15", "Crocodile" }, { "16", "Dolphin" }, { "21", "Eel" }, { "22", "Fish" },
    { "23", "Frog" }, { "24", "Jellyfish" }, { "25", "Leech" }, { "26", "Lobster" },
    { "31", "Octopus" }, { "32", "Oyster" }, { "33", "Pond-skr" }, { "34", "Salamander" },
    { "35", "Seasnail" }, { "36", "Seabird" }, { "41", "Shark" }, { "42", "Squid" },
    { "43", "Turtle" }, { "44", "Walrus" }, { "45", "Whale" }, { "46", "Hammerhead" },
    { "51", "Ray" }, { "52", "Sea-lion" }, { "53", "Sea-urchin" }, { "54", "Seal" },
    { "55", "Seahorse" }, { "56", "Starfish" }, { "61", "Toad" }, { "62", "Crayfish" },
    { "63", " Newt" }, { "64", "Pirana" }, { "65", "Pike" }, { "66", "Catfish" },
  },
}

M.humanoids = {
  common = {
    { "11", "Dwarf" }, { "12", "Elf" }, { "13", "Halfling" }, { "14", "Gnome" },
    { "15", "Human" }, { "16", "Human" }, { "21", "Goblin" }, { "22", "Kobold" },
    { "23", "Orc" }, { "24", "Hobgoblin" }, { "25", "Bugbear" }, { "26", "Gnoll" },
    { "31", "Dwarf" }, { "32", "Elf" }, { "33", "Halfling" }, { "34", "Gnome" },
    { "35", "Human" }, { "36", "Human" }, { "41", "Goblin" }, { "42", "Kobold" },
    { "43", "Orc" }, { "44", "Hobgoblin" }, { "45", "Bugbear" }, { "46", "Gnoll" },
    { "51", "Dwarf" }, { "52", "Elf" }, { "53", "Halfling" }, { "54", "Gnome" },
    { "55", "Human" }, { "56", "Human" }, { "61", "Goblin" }, { "62", "Kobold" },
    { "63", "Orc" }, { "64", "Hobgoblin" }, { "65", "Bugbear" }, { "66", "Gnoll" },
  },
  uncommon = {
    { "11", "Ogre" }, { "12", "Troll" }, { "13", "Centaur" }, { "14", "Minotaur" },
    { "15", "Harpy" }, { "16", "Griffin" }, { "21", "Satyr" }, { "22", "Dryad" },
    { "23", "Naga" }, { "24", "Manticore" }, { "25", "Cockatrice" }, { "26", "Basilisk" },
    { "31", "Ogre" }, { "32", "Troll" }, { "33", "Centaur" }, { "34", "Minotaur" },
    { "35", "Harpy" }, { "36", "Griffin" }, { "41", "Satyr" }, { "42", "Dryad" },
    { "43", "Naga" }, { "44", "Manticore" }, { "45", "Cockatrice" }, { "46", "Basilisk" },
    { "51", "Ogre" }, { "52", "Troll" }, { "53", "Centaur" }, { "54", "Minotaur" },
    { "55", "Harpy" }, { "56", "Griffin" }, { "61", "Satyr" }, { "62", "Dryad" },
    { "63", "Naga" }, { "64", "Manticore" }, { "65", "Cockatrice" }, { "66", "Basilisk" },
  },
}

M.monsters = {
  { "11", "Animated Armor", "Armoured" },
  { "12", "Basilisk", "Petrifying" },
  { "13", "Black Pudding", "Absorbing, Acidic" },
  { "14", "Bugbear", "Surprise attack" },
  { "15", "Cockatrice", "Petrifying" },
  { "16", "Displacer Beast", "Camouflaging" },
  { "21", "Gelatinous Cube", "Absorbing" },
  { "22", "Ghost", "Ethereal, Vampiric" },
  { "23", "Ghoul", "Paralyzing" },
  { "24", "Giant Spider", "Poisonous, Entangling" },
  { "25", "Giant Rat", "Disease" },
  { "26", "Harpy", "Charming" },
  { "31", "Hell Hound", "Firer, Tracking" },
  { "32", "Hydra", "Regenerating" },
  { "33", "Lich", "Vampiric, Undead, Magic" },
  { "34", "Mimic", "Camouflaging, Surprise" },
  { "35", "Minotaur", "Tracking" },
  { "36", "Mummy", "Undead, Disease" },
  { "41", "Otyugh", "Parasitic" },
  { "42", "Owlbear", "Fast" },
  { "43", "Phase Spider", "Teleporting, Ethereal" },
  { "44", "Purple Worm", "Burrowing, Engulfing" },
  { "45", "Roper", "Camouflaging, Entangling" },
  { "46", "Shadow", "Ethereal, Vampiric" },
  { "51", "Shambling Mound", "Entangling, Absorbing" },
  { "52", "Skeleton", "Undead" },
  { "53", "Spectre", "Ethereal, Vampiric" },
  { "54", "Tomb Mummy", "Undead, Disease" },
  { "55", "Troll", "Regenerating" },
  { "56", "Vampire", "Vampiric, Shapeshifting" },
  { "61", "Wight", "Vampiric, Undead" },
  { "62", "Will-o-Wisp", "Invisibility, Ethereal" },
  { "63", "Wraith", "Ethereal, Vampiric" },
  { "64", "Wyvern", "Poisonous, Flying" },
  { "65", "Zombie", "Undead" },
  { "66", "Worm", "Petrifying" },
}

M.behaviour = {
  { "1", "Prey", "Fleeing" },
  { "2", "Prey", "Hides" },
  { "3", "Predator", "Stalks" },
  { "4", "Predator", "Ambush" },
  { "5", "Predator", "Pack tactics" },
  { "6", "Scavenger", "Opportunistic" },
}

M.beast_behaviour = {
  { "1", "Always flees" },
  { "2", "Berserk when hurt" },
  { "3", "Fast breeder" },
  { "4", "Hit and run" },
  { "5", "Pack hunter" },
  { "6", "Poison and wait" },
}

function M.get_beast(subtype)
  local dice = require("forge-nvim.dice")
  local roll = dice.roll(6)
  local subtable = M.beasts[subtype] or M.beasts.earthbound
  local d66 = dice.d66()
  for _, entry in ipairs(subtable) do
    if tonumber(entry[1]) == d66 then
      return { type = "Beast", subtype = subtype, name = entry[2], d66 = d66 }
    end
  end
  return { type = "Beast", name = subtable[1][2] }
end

function M.get_humanoid(subtype)
  local dice = require("forge-nvim.dice")
  local d66 = dice.d66()
  local subtable = M.humanoids[subtype] or M.humanoids.common
  for _, entry in ipairs(subtable) do
    if tonumber(entry[1]) == d66 then
      return { type = "Humanoid", subtype = subtype, name = entry[2], d66 = d66 }
    end
  end
  return { type = "Humanoid", name = subtable[1][2] }
end

function M.get_monster()
  local dice = require("forge-nvim.dice")
  local d66 = dice.d66()
  for _, entry in ipairs(M.monsters) do
    if tonumber(entry[1]) == d66 then
      return { type = "Monster", name = entry[2], ability = entry[3], d66 = d66 }
    end
  end
  return { type = "Monster", name = M.monsters[1][2], ability = M.monsters[1][3] }
end

function M.get_behaviour()
  local dice = require("forge-nvim.dice")
  local roll = dice.roll(6)
  local entry = M.behaviour[roll]
  return { type = entry[2], action = entry[3], roll = roll }
end

function M.get_beast_behaviour()
  local dice = require("forge-nvim.dice")
  local roll = dice.roll(6)
  return { behaviour = M.beast_behaviour[roll][2], roll = roll }
end

return M
