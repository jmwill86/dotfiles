vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "120"

vim.keymap.set("n", "<C-h>", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>-/gI<LEFT><LEFT><LEFT><BS>");
vim.keymap.set('x', '<C-h>', 'y:%s/<C-R>"/<C-R>"-/gI<LEFT><LEFT><LEFT><BS>');

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv");
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv");

-- show line diagnostics automatically in hover window
vim.diagnostic.config({
  virtual_text = false
})

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "rust", "lua", "vim", "help" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  --ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    --[[disable = function(lang, buf)]]
        --[[local max_filesize = 100 * 1024 -- 100 KB]]
        --[[local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))]]
        --[[if ok and stats and stats.size > max_filesize then]]
            --[[return true]]
        --[[end]]
    --[[end,]]

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}






-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
    'phpactor',
    'rust_analyzer'
});

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()







--local null_ls = require("null-ls")

--null_ls.setup({
    --sources = {
        --null_ls.builtins.diagnostics.phpcs,
        --null_ls.builtins.diagnostics.php,
        --null_ls.builtins.formatting.phpcsfixer,
    --},
--})


local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.phpcs.with({
            extra_args = {"--standard=PSR12"}
        }),
        null_ls.builtins.diagnostics.php,
        null_ls.builtins.formatting.phpcsfixer,
    },
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.format({ bufnr = bufnr});
                end,
            })
        end
    end,
})


































