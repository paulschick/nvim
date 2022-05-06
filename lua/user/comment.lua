require("Comment").setup {
  opleader = {
    line = "gc",
    block = "gb"
  },

  mappings = {
    -- operator-pending mapping
    -- Includes:
    --  `gcc`               -> line-comment  the current line
    --  `gcb`               -> block-comment the current line
    --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
    --  `gb[count]{motion}` -> block-comment the region contained in {motion}
    basic = true,

    -- extra mapping
    -- Includes `gco`, `gcO`, `gcA`
    extra = true,

    -- extended mapping
    -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = true,
  },

  toggler = {
    -- LHS toggle mapping in normal + visual mode
    line = "gcc",
    block = "gbc"
  },

  pre_hook = nil,
  post_hook = nil,
  ignore = nil,
}
