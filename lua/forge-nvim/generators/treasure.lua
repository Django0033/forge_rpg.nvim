local M = {}

function M.treasure(level)
  local treasure = require("forge-nvim.tables.treasure")
  return treasure.get_treasure(level or 1)
end

function M.to_markdown(data)
  local lines = {}
  table.insert(lines, "## FORGE: Treasure (Level " .. data.level .. ")")
  table.insert(lines, "")
  table.insert(lines, "| Category | Value |")
  table.insert(lines, "|----------|-------|")
  table.insert(lines, "| **Coins** | " .. data.coins .. " gp |")
  table.insert(lines, "")

  if #data.gems > 0 then
    table.insert(lines, "### Gems")
    table.insert(lines, "")
    for _, gem in ipairs(data.gems) do
      table.insert(lines, "- " .. gem.name .. " (" .. gem.value .. ")")
    end
    table.insert(lines, "")
  end

  if #data.jewelry > 0 then
    table.insert(lines, "### Jewelry")
    table.insert(lines, "")
    for _, item in ipairs(data.jewelry) do
      table.insert(lines, "- " .. item.name .. " (" .. item.value .. ")")
    end
    table.insert(lines, "")
  end

  if #data.magic > 0 then
    table.insert(lines, "### Magic Items")
    table.insert(lines, "")
    for _, item in ipairs(data.magic) do
      table.insert(lines, "- " .. item)
    end
    table.insert(lines, "")
  end

  return table.concat(lines, "\n")
end

function M.to_float_content(data)
  local lines = {}
  table.insert(lines, "┌─────────────────────────────────────────┐")
  table.insert(lines, "│  FORGE: Treasure (Level " .. data.level .. ")             │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│                                         │")
  table.insert(lines, "│  Coins: " .. string.format("%-25d gp", data.coins) .. "│")

  if #data.gems > 0 then
    table.insert(lines, "│                                         │")
    table.insert(lines, "│  Gems:                                  │")
    for i, gem in ipairs(data.gems) do
      if i <= 3 then
        table.insert(lines, "│    - " .. string.format("%-30s", gem.name .. " (" .. gem.value .. ")") .. "│")
      end
    end
    if #data.gems > 3 then
      table.insert(lines, "│    ... and " .. (#data.gems - 3) .. " more                      │")
    end
  end

  if #data.jewelry > 0 then
    table.insert(lines, "│                                         │")
    table.insert(lines, "│  Jewelry:                                │")
    for i, item in ipairs(data.jewelry) do
      if i <= 2 then
        table.insert(lines, "│    - " .. string.format("%-30s", item.name .. " (" .. item.value .. ")") .. "│")
      end
    end
  end

  if #data.magic > 0 then
    table.insert(lines, "│                                         │")
    table.insert(lines, "│  Magic Items:                            │")
    for i, item in ipairs(data.magic) do
      if i <= 2 then
        table.insert(lines, "│    - " .. string.format("%-30s", item) .. "│")
      end
    end
    if #data.magic > 2 then
      table.insert(lines, "│    ... and " .. (#data.magic - 2) .. " more                       │")
    end
  end

  table.insert(lines, "│                                         │")
  table.insert(lines, "├─────────────────────────────────────────┤")
  table.insert(lines, "│  [q] close  [r] re-roll  [i] insert    │")
  table.insert(lines, "└─────────────────────────────────────────┘")
  return table.concat(lines, "\n")
end

return M
