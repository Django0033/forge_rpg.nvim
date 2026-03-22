local M = {}

function M.roll(sides, count)
  count = count or 1
  local total = 0
  for _ = 1, count do
    total = total + math.random(1, sides)
  end
  return total
end

function M.parse(notation)
  local pattern = "([%dd%+%-]+)"
  local parts = {}
  for part in notation:gmatch("[^%s]+") do
    table.insert(parts, part)
  end

  local total = 0
  local rolls = {}

  for _, part in ipairs(parts) do
    local count, sides, modifier = part:match("^(%d*)d(%d+)([%+%-%d]*)$")
    if sides then
      count = tonumber(count) or 1
      modifier = tonumber(modifier) or 0
      local results = {}
      for _ = 1, count do
        table.insert(results, math.random(1, tonumber(sides)))
      end
      local subtotal = 0
      for _, v in ipairs(results) do
        subtotal = subtotal + v
      end
      subtotal = subtotal + modifier
      table.insert(rolls, { dice = part, results = results, modifier = modifier, subtotal = subtotal })
      total = total + subtotal
    end
  end

  return total, rolls
end

function M.roll_d66()
  return self and self:roll(6) * 10 + self:roll(6) or M.roll(6) * 10 + M.roll(6)
end

function M.d66()
  local d1 = M.roll(6)
  local d2 = M.roll(6)
  return d1 * 10 + d2
end

function M.advantage(count)
  count = count or 2
  local results = {}
  for _ = 1, count do
    table.insert(results, math.random(1, 20))
  end
  table.sort(results, function(a, b) return a > b end)
  return results[1], results
end

function M.disadvantage(count)
  count = count or 2
  local results = {}
  for _ = 1, count do
    table.insert(results, math.random(1, 20))
  end
  table.sort(results)
  return results[1], results
end

function M.format_roll(notation)
  local total, rolls = M.parse(notation)
  local parts = {}
  for _, r in ipairs(rolls) do
    local dice_str = table.concat(r.results, "+")
    if r.modifier ~= 0 then
      local sign = r.modifier > 0 and "+" or ""
      dice_str = dice_str .. sign .. r.modifier
    end
    table.insert(parts, string.format("%s=%s", r.dice, dice_str))
  end
  return table.concat(parts, " ") .. " => " .. total, total
end

return M
