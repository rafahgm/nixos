local ai = require("mini.ai")
ai.setup({
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
  },
})

require("mini.align").setup()

require("mini.indentscope").setup({
  symbol = "│",
  draw = {
    animation = require("mini.indentscope").gen_animation.none(),
  }
})

require("mini.pairs").setup()

require("mini.surround").setup()

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.jump").setup()

require("mini.splitjoin").setup({
  mappings = {
    toggle = "<leader>m",
  }
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
    fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
    hack = { pattern = "HACK", group = "MiniHipatternsHack" },
    todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
    note = { pattern = "NOTE", group = "MiniHipatternsNote" },
  }
})
