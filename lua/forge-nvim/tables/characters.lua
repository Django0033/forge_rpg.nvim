local M = {}

M.personality = {
  { "11", "Addicted" }, { "12", "Alluring" }, { "13", "Aloof" }, { "14", "Banal" },
  { "15", "Careful" }, { "16", "Cheery" }, { "21", "Childish" }, { "22", "Chivalrous" },
  { "23", "Coarse" }, { "24", "Compliant" }, { "25", "Conformist" }, { "26", "Confident" },
  { "31", "Conniving" }, { "32", "Conservative" }, { "33", "Corrupt" }, { "34", "Courageous" },
  { "35", "Cultured" }, { "36", "Cunning" }, { "41", "Curious" }, { "42", "Defective" },
  { "43", "Defiant" }, { "44", "Delightful" }, { "45", "Dependable" }, { "46", "Despondent" },
  { "51", "Devoted" }, { "52", "Dignified" }, { "53", "Disciplined" }, { "54", "Eccentric" },
  { "55", "Fickle" }, { "56", "Fanatical" }, { "61", "Focused" }, { "62", "Forthright" },
  { "63", "Glum" }, { "64", "Greedy" }, { "65", "Habitual" }, { "66", "Honest" },
  { "11", "Helpful" }, { "12", "Honourable" }, { "13", "Humble" }, { "14", "Hopeless" },
  { "15", "Idealistic" }, { "16", "Inconsiderate" }, { "21", "Insensitive" }, { "22", "Indifferent" },
  { "23", "Insightful" }, { "24", "Jovial" }, { "25", "Lazy" }, { "26", "Kind" },
  { "31", "Lethargic" }, { "32", "Likable" }, { "33", "Logical" }, { "34", "Meek" },
  { "35", "Liberal" }, { "36", "Lively" }, { "41", "Loyal" }, { "42", "Mindless" },
  { "43", "Miserly" }, { "44", "Naive" }, { "45", "Nefarious" }, { "46", "Needy" },
  { "51", "Neglectful" }, { "52", "Nefarious" }, { "53", "Oblivious" }, { "54", "Optimistic" },
  { "55", "Pessimistic" }, { "56", "Pleasant" }, { "61", "Pious" }, { "62", "Passionate" },
  { "63", "Pushing" }, { "64", "Prying" }, { "65", "Reckless" }, { "66", "Relaxed" },
  { "11", "Rational" }, { "12", "Refined" }, { "13", "Resilient" }, { "14", "Revolting" },
  { "15", "Righteous" }, { "16", "Rude" }, { "21", "Romantic" }, { "22", "Scholarly" },
  { "23", "Sensible" }, { "24", "Shrewd" }, { "25", "Solemn" }, { "26", "Subtle" },
  { "31", "Serene" }, { "32", "Sinful" }, { "33", "Stoic" }, { "34", "Suspicious" },
  { "35", "Thoughtful" }, { "36", "Tactless" }, { "41", "Touchy" }, { "42", "Unconcerned" },
  { "43", "Uncouth" }, { "44", "Unreasonable" }, { "45", "Unsupportive" }, { "46", "Valiant" },
  { "51", "Vain" }, { "52", "Wasteful" }, { "53", "Wild" }, { "54", "Wicked" },
  { "55", "Wise" }, { "56", "Docile" }, { "61", "Foolish" }, { "62", "Unseemly" },
  { "63", "Uneducated" }, { "64", "Romantic" }, { "65", "Sensible" }, { "66", "Serene" },
}

M.occupation = {
  { "11", "Acrobat" }, { "12", "Alchemist" }, { "13", "Apothecary" }, { "14", "Architect" },
  { "15", "Aristocrat" }, { "16", "Armorer" }, { "21", "Acolyte" }, { "22", "Blacksmith" },
  { "23", "Builder" }, { "24", "Butcher" }, { "25", "Carpenter" }, { "26", "Charlatan" },
  { "31", "Cook" }, { "32", "Courier" }, { "33", "Driver" }, { "34", "Duellist" },
  { "35", "Fisherman" }, { "36", "Gambler" }, { "41", "Herald" }, { "42", "Hitman" },
  { "43", "Innkeeper" }, { "44", "Jeweler" }, { "45", "Merchant" }, { "46", "Messenger" },
  { "51", "Miner" }, { "52", "Musician" }, { "53", "Philosopher" }, { "54", "Pickpocket" },
  { "55", "Poet" }, { "56", "Sailor" }, { "61", "Scholar" }, { "62", "Scribe" },
  { "63", "Servant" }, { "64", "Shepherd" }, { "65", "Smuggler" }, { "66", "Soldier" },
  { "11", "Barber" }, { "12", "Beggar" }, { "13", "Brewer" }, { "14", "Carter" },
  { "15", "Clerk" }, { "16", "Cobbler" }, { "21", "Courtesan" }, { "22", "Dancer" },
  { "23", "Falconer" }, { "24", "Farmer" }, { "25", "Ferryman" }, { "26", "Fortune Teller" },
  { "31", "Glassblower" }, { "32", "Gravedigger" }, { "33", "Herbalist" }, { "34", "Hunter" },
  { "35", "Jester" }, { "36", "Locksmith" }, { "41", "Miller" }, { "42", "Minstrel" },
  { "43", "Night Watch" }, { "44", "Painter" }, { "45", "Sculptor" }, { "46", "Stablehand" },
  { "51", "Tanner" }, { "52", "Tax Collector" }, { "53", "Teamster" }, { "54", "Torchbearer" },
  { "55", "Weaver" }, { "56", "Woodcutter" }, { "61", "Zookeeper" }, { "62", "Astrologer" },
  { "63", "Cartographer" }, { "64", "Chronicler" }, { "65", "Alchemist" }, { "66", "Herbalist" },
}

M.appearance = {
  { "11", "Angular" }, { "12", "Athletic" }, { "13", "Bony" }, { "14", "Brawny" },
  { "15", "Broad" }, { "16", "Chubby" }, { "21", "Burly" }, { "22", "Compact" },
  { "23", "Corpulent" }, { "24", "Delicate" }, { "25", "Flabby" }, { "26", "Gaunt" },
  { "31", "Handsome" }, { "32", "Hideous" }, { "33", "Hulking" }, { "34", "Lanky" },
  { "35", "Nimble" }, { "36", "Pudgy" }, { "41", "Petite" }, { "42", "Ripped" },
  { "43", "Rotund" }, { "44", "Scrawny" }, { "45", "Rugged" }, { "46", "Skeletal" },
  { "51", "Statuesque" }, { "52", "Stocky" }, { "53", "Stout" }, { "54", "Taut" },
  { "55", "Short" }, { "56", "Towering" }, { "61", "Weathered" }, { "62", "Wiry" },
  { "63", "Bald" }, { "64", "Battle-scarred" }, { "65", "Birthmark" }, { "66", "Big-nosed" },
  { "11", "Braided-hair" }, { "12", "Broken-nose" }, { "13", "Curly-hair" }, { "14", "Dishevelled" },
  { "15", "Bristly-chin" }, { "16", "Burn-scar" }, { "21", "Dark-skin" }, { "22", "Dreadlocks" },
  { "23", "Hairy" }, { "24", "One-eyed" }, { "25", "Pale-skin" }, { "26", "Pierced-ear" },
  { "31", "Ponytail" }, { "32", "Red-hair" }, { "33", "Scarred-face" }, { "34", "Tattooed" },
  { "35", "Veiled" }, { "36", "War-paint" }, { "41", "White-hair" }, { "42", "Wild-hair" },
  { "43", "Wrinkled" }, { "44", "Missing-teeth" }, { "45", "Missing-finger" }, { "46", "Hunchback" },
  { "51", "Paralysed" }, { "52", "Blind" }, { "53", "Deaf" }, { "54", "Mutant" },
  { "55", "Possessed" }, { "56", "Transformed" }, { "61", "Cursed" }, { "62", "Possessed" },
  { "63", "Glowing-eyes" }, { "64", "Hollow-cheeks" }, { "65", "Muscular" }, { "66", "Emaciated" },
}

M.quirk = {
  { "11", "Breathy" }, { "12", "Bloody" }, { "13", "Ceremonial" }, { "14", "Chews-nails" },
  { "15", "Clumsy" }, { "16", "Cryptic" }, { "21", "Chuckling" }, { "22", "Cracks-joints" },
  { "23", "Deep-voice" }, { "24", "Eye-contact" }, { "25", "Hugs" }, { "26", "Interrupts" },
  { "31", "Knows-it-all" }, { "32", "Long-pauses" }, { "33", "Motionless" }, { "34", "Mumbles" },
  { "35", "Puffs-chest" }, { "36", "Smiley" }, { "41", "Fidgets" }, { "42", "Sweats" },
  { "43", "Trembles" }, { "44", "Whispers" }, { "45", "Yells" }, { "46", "Argues" },
  { "51", "Flatulent" }, { "52", "Hiccup" }, { "53", "Stutters" }, { "54", "Snores" },
  { "55", "Hums" }, { "56", "Whistles" }, { "61", "Laughs" }, { "62", "Cries" },
  { "63", "Spits" }, { "64", "Bites-nails" }, { "65", "Taps" }, { "66", "Sighs" },
}

M.clothing = {
  { "11", "Battle-worn" }, { "12", "Bloody" }, { "13", "Ceremonial" }, { "14", "Decaying" },
  { "15", "Dated" }, { "16", "Decorated" }, { "21", "Elegant" }, { "22", "Eccentric" },
  { "23", "Embroidered" }, { "24", "Exotic" }, { "25", "Fashionable" }, { "26", "Filthy" },
  { "31", "Frayed" }, { "32", "Gaudy" }, { "33", "Homespun" }, { "34", "Livery" },
  { "35", "Mud-splattered" }, { "36", "Occult" }, { "41", "Oversized" }, { "42", "Patched" },
  { "43", "Perfumed" }, { "44", "Pious" }, { "45", "Ripped" }, { "46", "Robes" },
  { "51", "Royal" }, { "52", "Rusted" }, { "53", "Spectral" }, { "54", "Stained" },
  { "55", "Uniform" }, { "56", "Warlike" }, { "61", "Tattered" }, { "62", "Tight" },
  { "63", "Travel-worn" }, { "64", "Wet" }, { "65", "Military" }, { "66", "Peasant" },
}

M.motivation = {
  { "11", "Seeking redemption" }, { "12", "Revenge" }, { "13", "Power" }, { "14", "Wealth" },
  { "15", "Knowledge" }, { "16", "Love" }, { "21", "Freedom" }, { "22", "Justice" },
  { "23", "Glory" }, { "24", "Safety" }, { "25", "Belonging" }, { "26", "Purpose" },
  { "31", "Acceptance" }, { "32", "Recognition" }, { "33", "Protection" }, { "34", "Pleasure" },
  { "35", "Order" }, { "36", "Chaos" }, { "41", "Legacy" }, { "42", "Truth" },
  { "43", "Peace" }, { "44", "Honor" }, { "45", "Family" }, { "46", "Adventure" },
  { "51", "Escape" }, { "52", "Discovery" }, { "53", "Control" }, { "54", "Service" },
  { "55", "Betrayal" }, { "56", "Loyalty" }, { "61", "Survival" }, { "62", "Duty" },
  { "63", "Ambition" }, { "64", "Greed" }, { "65", "Mercy" }, { "66", "Curiosity" },
}

function M.get_personality()
  local d66 = require("forge-nvim.dice").d66()
  for _, entry in ipairs(M.personality) do
    if tonumber(entry[1]) == d66 then return entry[2] end
  end
  return M.personality[1][2]
end

function M.get_occupation()
  local d66 = require("forge-nvim.dice").d66()
  for _, entry in ipairs(M.occupation) do
    if tonumber(entry[1]) == d66 then return entry[2] end
  end
  return M.occupation[1][2]
end

function M.get_appearance()
  local d66 = require("forge-nvim.dice").d66()
  for _, entry in ipairs(M.appearance) do
    if tonumber(entry[1]) == d66 then return entry[2] end
  end
  return M.appearance[1][2]
end

function M.get_quirk()
  local d66 = require("forge-nvim.dice").d66()
  for _, entry in ipairs(M.quirk) do
    if tonumber(entry[1]) == d66 then return entry[2] end
  end
  return M.quirk[1][2]
end

function M.get_clothing()
  local d66 = require("forge-nvim.dice").d66()
  for _, entry in ipairs(M.clothing) do
    if tonumber(entry[1]) == d66 then return entry[2] end
  end
  return M.clothing[1][2]
end

function M.get_motivation()
  local d66 = require("forge-nvim.dice").d66()
  for _, entry in ipairs(M.motivation) do
    if tonumber(entry[1]) == d66 then return entry[2] end
  end
  return M.motivation[1][2]
end

return M
