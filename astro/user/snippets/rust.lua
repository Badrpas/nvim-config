local ls = require('luasnip')
local s = ls.snippet;
local text = ls.text_node
local insert = ls.insert_node
local f = ls.function_node

local module_name = function()
    local name = vim.fn.fnamemodify(vim.fn.expand('%'), ':t:r')
    if name == 'mod' then
        name = vim.fn.fnamemodify(vim.fn.expand('%'), ':p:h:t')
    end
    return name
end

local plugin_name = function()
    local name = module_name()
    name = name:gsub("[-%.]?(%l)(%w+)", function(a, b)
        return string.upper(a) .. b
    end)
    name = name:gsub("_", "")
    return name .. 'Plugin'
end

local system_name = function()
    local name = module_name()
    return name .. '_system'
end

return {
  s({
      trig = 'plugin',
      namr = 'Bevy Plugin',
      dscr = 'Bevy Plugin',
  }, {
      text({
        "use bevy::prelude::*;", "",
        "pub struct " }), f(plugin_name, {}), text({ ";", "",
          "impl Plugin for "
      }), f(plugin_name, {}), text({ " {",
          "    fn build(&self, app: &mut App) {",
          "        app.add_systems(Update, "}), f(system_name, {}), text({");",
          "    }",
          "}",
          "",
          ""}), insert(1), text({ '',
          "",
          "pub fn "}), f(system_name, {}), text({ "(",
          "",
          ") {",
          "",
          "}"
      })
  }),
}


