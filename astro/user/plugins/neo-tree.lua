


local function indexOf(arr, el)
  for idx, v in ipairs(arr) do
    if el == v then
      return idx
    end
  end
  return 0
end


return function (config)
  local fs = config.filesystem
  fs.follow_current_file = false
  local idx = indexOf(fs.filtered_items.hide_by_name, 'node_modules')
  table.remove(fs.filtered_items.hide_by_name, idx)

  return config
end




