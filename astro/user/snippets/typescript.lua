local ls = require('luasnip')
local s = ls.snippet;
local text = ls.text_node
local insert = ls.insert_node
local f = ls.function_node

local class_name = function()
    local name = vim.fn.fnamemodify(vim.fn.expand('%'), ':t:r')
    name = name:gsub("[-%.]?(%l)(%w+)", function(a, b)
        return string.upper(a) .. b
    end)
    return name .. 'System'
end

local system = function(trig, extra)
    extra = extra or {}
    return s({
        trig = trig,
        namr = "System",
        dscr = "EACIEST SYSTEM EVAH",
    }, {
        text({ "import { System } from 'eaciest';", "", "" }),
        text({ "export class " }), f(class_name, {}), text(" extends System {"),
        text({ "",
            "",
            "  constructor () {",
            "    super({",
            "      default: [" }), insert(1), text({ "],",
            "    });",
            "  }",
            "",
            "  update() {",
            "    " }), insert(2), text({ "",
            "  }",
            "",
            "}"
        }),
        unpack(extra),
    })
end

return {
    system('sys'),
    system('syst', {
        text({
            "",
            "",
            "// @ts-ignore",
            "window.register_system?.((world: any) => world.addSystemClass("
        }), f(class_name, {}), text({ "));" })
    }),
    s({
        trig = 'foren',
        namr = 'For loop of entities',
        dscr = 'For loop over entities',
    }, {
        text({
            "for (const e of this.getEntities('"
        }), insert(1, 'default'), text({ "')) {",
            "  ", }), insert(2), text({ '',
            "}"
        })
    }),
}
