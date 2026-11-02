require("blink.cmp").setup({
  signature = {
    enabled = true,
  },
  keymap = {
    preset = "default",
    ["<Tab>"] = { "accept", "fallback" },
    ["<C-Space>"] = { "show" },
    ["J"] = { "select_next", "fallback" },
    ["K"] = { "select_prev", "fallback" },
  },
  fuzzy = {
    implementation = "rust",
  },
  completion = {
    ghost_text = {
      enabled = true,
    },
    menu = {
      auto_show = false,
    },
    documentation = {
      auto_show = true
    },
  },
  cmdline = {
    keymap = { preset = "inherit" },
    completion = { menu = { auto_show = true } },
  },
})
