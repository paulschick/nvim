local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
	print("Cannot load null-ls")
	return
end

local form = null_ls.builtins.formatting
local diag = null_ls.builtins.diagnostics

local sources = {
	--form.stylua, -- Installed through Cargo with Rust
	form.black, -- Install locally to python project
	form.prettier, -- Install locally to js/ts project and others
	--form.shfmt.with({ -- Installed using go
	--	extra_args = { "-i", "2", "-bn", "-ci", "-sr" },
	--}),
	--diag.shellcheck, -- Installed with apt (Ubuntu)
	--diag.textlint, -- Installed with npm
	diag.eslint, -- Use locally with js/ts project
	diag.flake8, -- Use with local python project environment
}

null_ls.setup({ sources = sources })