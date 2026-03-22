local M = {}

M.name_prefix = {
  { "11", "Ash" }, { "12", "Barn" }, { "13", "Black" }, { "14", "Bourn" },
  { "15", "Bright" }, { "16", "Cinder" }, { "21", "Craw" }, { "22", "Dusk" },
  { "23", "East" }, { "24", "Elk" }, { "25", "Fern" }, { "26", "Frost" },
  { "31", "Gloom" }, { "32", "Green" }, { "33", "High" }, { "34", "Iron" },
  { "35", "Kings" }, { "36", "Lost" }, { "41", "Mist" }, { "42", "Moon" },
  { "43", "North" }, { "44", "Oak" }, { "45", "Ox" }, { "46", "Raven" },
  { "51", "Silver" }, { "52", "Storm" }, { "53", "Sun" }, { "54", "Thorn" },
  { "55", "West" }, { "56", "White" }, { "61", "Gold" }, { "62", "Grey" },
  { "63", "Hal" }, { "64", "Rock" }, { "65", "Shadow" }, { "66", "Stone" },
}

M.name_suffix = {
  { "11", "-bridge" }, { "12", "-bury" }, { "13", "-burn" }, { "14", "-cradle" },
  { "15", "-cross" }, { "16", "-dale" }, { "21", "-den" }, { "22", "-fell" },
  { "23", "-fen" }, { "24", "-field" }, { "25", "-ford" }, { "26", "-gate" },
  { "31", "-guard" }, { "32", "-haven" }, { "33", "-hold" }, { "34", "-hill" },
  { "35", "-keep" }, { "36", "-march" }, { "41", "-moor" }, { "42", "-peak" },
  { "43", "-reach" }, { "44", "-shaw" }, { "45", "-spire" }, { "46", "-stead" },
  { "51", "-stone" }, { "52", "-thorpe" }, { "53", "-tower" }, { "54", "-veil" },
  { "55", "-watch" }, { "56", "-wick" }, { "61", "-wood" }, { "62", "-worth" },
  { "63", "-ford" }, { "64", "-ton" }, { "65", "-ham" }, { "66", "-port" },
}

M.descriptor = {
  { "11", "Ageless" }, { "12", "Barbed" }, { "13", "Bloodied" }, { "14", "Boundless" },
  { "15", "Celestial" }, { "16", "Crumbling" }, { "21", "Dark" }, { "22", "Deathly" },
  { "23", "Desolate" }, { "24", "Echoing" }, { "25", "Eternal" }, { "26", "Fabled" },
  { "31", "Forsaken" }, { "32", "Fractured" }, { "33", "Glacial" }, { "34", "Gilded" },
  { "35", "Glimmering" }, { "36", "Hollow" }, { "41", "Luminous" }, { "42", "Radiant" },
  { "43", "Sacred" }, { "44", "Scarlet" }, { "45", "Shattered" }, { "46", "Silent" },
  { "51", "Sunken" }, { "52", "Sworn" }, { "53", "Verdant" }, { "54", "Whispering" },
  { "55", "Wicked" }, { "56", "Cursed" }, { "61", "Blessed" }, { "62", "Forgotten" },
  { "63", "Golden" }, { "64", "Haunted" }, { "65", "Holy" }, { "66", "Fallen" },
}

M.government = {
  { "1", "Autocracy" }, { "2", "Democracy" }, { "3", "Monarchy" },
  { "4", "Oligarchy" }, { "5", "Theocracy" }, { "6", "Anarchy" },
}

M.population = {
  { "1", "Ruin" }, { "2", "Hamlet (1d6 x 10)" }, { "3", "Village (1d6 x 50)" },
  { "4", "Town (1d6 x 500)" }, { "5", "City (1d6 x 2000)" }, { "6", "Capital (1d10 x 5000)" },
}

M.industry = {
  { "1", "Agriculture" }, { "2", "Fishing" }, { "3", "Mining" },
  { "4", "Crafts" }, { "5", "Trade" }, { "6", "Military" },
  { "1", "Religious" }, { "2", "Entertainment" }, { "3", "Education" },
  { "4", "Piracy" }, { "5", "Smuggling" }, { "6", "Exploration" },
}

M.secret = {
  { "1", "Corrupt leader" }, { "2", "Hidden cult" }, { "3", "Smuggling operation" },
  { "4", "Ancient artifact" }, { "5", "Secret passage" }, { "6", "Monster infestation" },
  { "1", "Missing heir" }, { "2", "Plague outbreak" }, { "3", "Political spy" },
  { "4", "Haunted location" }, { "5", "Drug trade" }, { "6", "Forbidden magic" },
}

M.tavern_subject = {
  { "11", "Barrel" }, { "12", "Bear" }, { "13", "Boar" }, { "14", "Brew" },
  { "15", "Buckler" }, { "16", "Candle" }, { "21", "Crow" }, { "22", "Dragon" },
  { "23", "Eagle" }, { "24", "Flagon" }, { "25", "Fox" }, { "26", "Gargoyle" },
  { "31", "Goblet" }, { "32", "Griffin" }, { "33", "Harp" }, { "34", "Hound" },
  { "35", "King" }, { "36", "Knight" }, { "41", "Lion" }, { "42", "Maiden" },
  { "43", "Moon" }, { "44", "Owl" }, { "45", "Pegasus" }, { "46", "Phoenix" },
  { "51", "Quill" }, { "52", "Rose" }, { "53", "Sword" }, { "54", "Shield" },
  { "55", "Stag" }, { "56", "Star" }, { "61", "Unicorn" }, { "62", "Wolf" },
  { "63", "Wyvern" }, { "64", "Basilisk" }, { "65", "Manticore" }, { "66", "Sphinx" },
}

M.faction = {
  { "11", "Thieves Guild" }, { "12", "Merchant Guild" }, { "13", "Mages Guild" },
  { "14", "Temple" }, { "15", "Noble House" }, { "16", "Military Order" },
  { "21", "Hunting Lodge" }, { "22", "Scholars Academy" }, { "23", "Assassin Brotherhood" },
  { "24", "Traders Consortium" }, { "25", "Arena Fighters" }, { "26", "Bard's College" },
  { "31", "Artisan Guild" }, { "32", "Herbalist Circle" }, { "33", "Black Market" },
  { "34", "Secret Society" }, { "35", "Adventuring Company" }, { "36", "Mercenary Band" },
}

function M.get_settlement_name()
  local dice = require("forge-nvim.dice")
  local prefix = M.name_prefix[dice.roll(#M.name_prefix)][2]
  local suffix = M.name_suffix[dice.roll(#M.name_suffix)][2]
  return prefix .. suffix
end

function M.get_settlement()
  local dice = require("forge-nvim.dice")
  local name = M.get_settlement_name()
  local gov = M.government[dice.roll(6)]
  local pop = M.population[dice.roll(6)]
  local ind = M.industry[dice.roll(#M.industry)]
  local secret = M.secret[dice.roll(#M.secret)]
  return {
    name = name,
    government = gov[2],
    population = pop[2],
    industry = ind[2],
    secret = secret[2],
  }
end

function M.get_tavern_name()
  local dice = require("forge-nvim.dice")
  local format = dice.roll(2)
  if format == 1 then
    local desc = M.descriptor[dice.roll(#M.descriptor)][2]
    local subj = M.tavern_subject[dice.roll(#M.tavern_subject)][2]
    return "The " .. desc .. " " .. subj
  else
    local subj1 = M.tavern_subject[dice.roll(#M.tavern_subject)][2]
    local subj2 = M.tavern_subject[dice.roll(#M.tavern_subject)][2]
    return "The " .. subj1 .. " and " .. subj2
  end
end

return M
