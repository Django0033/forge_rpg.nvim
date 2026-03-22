local M = {}

M.reactions = {
  { { min = 2, max = 2 }, "Hostile", "Will attack immediately", true },
  { { min = 3, max = 5 }, "Unfriendly", "May attack if provoked", true },
  { { min = 6, max = 8 }, "Uncertain", "Neutral, cautious", false },
  { { min = 9, max = 11 }, "Indifferent", "Goes about business", false },
  { { min = 12, max = 12 }, "Helpful", "Friendly, may assist", false },
}

M.scars = {
  { "1", "Head Injury", "INT", "1d6" },
  { "2", "Nasty Scar", "CHA", "1d6" },
  { "3", "Leg Injury", "DEX", "1d6" },
  { "4", "Muscle Injury", "STR", "1d6" },
  { "5", "Organ Injury", "CON", "1d6" },
  { "6", "Eye Injury", "WIS", "1d6" },
}

M.motivation_verb = {
  { "11", "Seeking" }, { "12", "Hunting" }, { "13", "Protecting" }, { "14", "Avoiding" },
  { "15", "Destroying" }, { "16", "Finding" }, { "21", "Delivering" }, { "22", "Stealing" },
  { "23", "Escorting" }, { "24", "Escaping" }, { "25", "Attacking" }, { "26", "Observing" },
  { "31", "Recovering" }, { "32", "Trading" }, { "33", "Hiding" }, { "34", "Exploring" },
  { "35", "Building" }, { "36", "Worshipping" }, { "41", "Researching" }, { "42", "Guarding" },
  { "43", "Sabotaging" }, { "44", "Organizing" }, { "45", "Leading" }, { "46", "Following" },
  { "51", "Fleeing" }, { "52", "Chasing" }, { "53", "Cooking" }, { "54", "Crafting" },
  { "55", "Training" }, { "56", "Resting" }, { "61", "Negotiating" }, { "62", "Fighting" },
  { "63", "Spying" }, { "64", "Mining" }, { "65", "Farming" }, { "66", "Camping" },
}

M.motivation_noun = {
  { "11", "revenge" }, { "12", "the party" }, { "13", "a secret" }, { "14", "freedom" },
  { "15", "power" }, { "16", "wealth" }, { "21", "knowledge" }, { "22", "love" },
  { "23", "safety" }, { "24", "glory" }, { "25", "peace" }, { "26", "justice" },
  { "31", "the enemy" }, { "32", "an artifact" }, { "33", "a cure" }, { "34", "a cure" },
  { "35", "supplies" }, { "36", "information" }, { "41", "a settlement" }, { "42", "a map" },
  { "43", "a monster" }, { "44", "a rumor" }, { "45", "evidence" }, { "46", "a relic" },
  { "51", "the wilderness" }, { "52", "a dungeon" }, { "53", "gold" }, { "54", "gems" },
  { "55", "the treasure" }, { "56", "an escort" }, { "61", "a guide" }, { "62", "a teacher" },
  { "63", "the temple" }, { "64", "the castle" }, { "65", "the quest" }, { "66", "adventure" },
}

M.verbs = {
  { "11", "Seeking" }, { "12", "Hunting" }, { "13", "Protecting" }, { "14", "Avoiding" },
  { "15", "Destroying" }, { "16", "Finding" }, { "21", "Delivering" }, { "22", "Stealing" },
  { "23", "Escorting" }, { "24", "Escaping from" }, { "25", "Attacking" }, { "26", "Observing" },
  { "31", "Recovering" }, { "32", "Trading with" }, { "33", "Hiding from" }, { "34", "Exploring" },
  { "35", "Building" }, { "36", "Worshipping" }, { "41", "Researching" }, { "42", "Guarding" },
  { "43", "Sabotaging" }, { "44", "Organizing" }, { "45", "Leading" }, { "46", "Following" },
}

M.nouns = {
  { "11", "revenge" }, { "12", "the party" }, { "13", "a secret" }, { "14", "freedom" },
  { "15", "power" }, { "16", "wealth" }, { "21", "knowledge" }, { "22", "love" },
  { "23", "safety" }, { "24", "glory" }, { "25", "peace" }, { "26", "justice" },
  { "31", "the enemy" }, { "32", "an artifact" }, { "33", "a cure" }, { "34", "the party" },
  { "35", "supplies" }, { "36", "information" }, { "41", "a settlement" }, { "42", "a map" },
  { "43", "a monster" }, { "44", "a rumor" }, { "45", "evidence" }, { "46", "a relic" },
}

function M.get_reaction(roll)
  roll = roll or (require("forge-nvim.dice").roll(6) + require("forge-nvim.dice").roll(6))
  for _, entry in ipairs(M.reactions) do
    if roll >= entry[1].min and roll <= entry[1].max then
      return { roll = roll, disposition = entry[2], description = entry[3], intelligent = entry[4] }
    end
  end
  return { roll = roll, disposition = "Uncertain", description = "Neutral, cautious" }
end

function M.get_scar()
  local dice = require("forge-nvim.dice")
  local roll = dice.roll(6)
  local entry = M.scars[roll]
  local reduction = dice.roll(tonumber(entry[4]:match("%d")))
  return {
    name = entry[2],
    attribute = entry[3],
    reduction = reduction,
    description = entry[2] .. " - " .. entry[3] .. " reduced by " .. reduction,
  }
end

function M.get_motivation()
  local dice = require("forge-nvim.dice")
  local verb_d66 = dice.d66()
  local noun_d66 = dice.d66()
  local verb = M.motivation_verb[verb_d66] and M.motivation_verb[verb_d66][2] or "Seeking"
  local noun = M.motivation_noun[noun_d66] and M.motivation_noun[noun_d66][2] or "adventure"
  return { verb = verb, noun = noun, full = verb .. " " .. noun }
end

function M.get_verb_noun()
  local dice = require("forge-nvim.dice")
  local verb_d66 = dice.d66()
  local noun_d66 = dice.d66()
  local verb = M.verbs[verb_d66] and M.verbs[verb_d66][2] or "Seeking"
  local noun = M.nouns[noun_d66] and M.nouns[noun_d66][2] or "adventure"
  return { verb = verb, noun = noun, full = verb .. " " .. noun }
end

return M
