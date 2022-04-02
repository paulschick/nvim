local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then
  print('Cannot load null-ls')
  return
end

local form = null_ls.builtins.formatting
local diag = null_ls.builtins.diagnostics

local sources = {
  form.stylua,
  form.black,
  form.prettier,
  form.shfmt.with({
    extra_args = { '-i', '2', '-bn', '-ci', '-sr' },
  }),

  diag.shellcheck,
  diag.markdownlint,
  diag.eslint,
}

null_ls.setup({ sources = sources })
