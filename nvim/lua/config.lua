require('nvim_comment').setup()
-- compe
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
	border = "single", -- the border option is the same as `|help nvim_open_win|`
	winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
	max_width = 120,
	min_width = 60,
	max_height = math.floor(vim.o.lines * 0.3),
	min_height = 1,
  },
  source = {
	  path = { kind = "   (Path)" },
	  buffer = { kind = "   (Buffer)" },
	  calc = { kind = "   (Calc)" },
	  vsnip = { kind = "   (Snippet)" },
	  nvim_lsp = { kind = "ea" },
	  nvim_lua = false,
	  spell = { kind = "   (Spell)" },
	  tags = false,
	  vim_dadbod_completion = false,
	  snippets_nvim = false,
	  ultisnips = false,
	  treesitter = false,
	  emoji = { kind = " ﲃ  (Emoji)", filetypes = { "markdown", "text" } },
	  -- for emoji press : (idk if that in compe tho)
	},
}

-- compe navigation 
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
	return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
	return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
	return t "<Tab>"
  else
	return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
	return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
	return t "<Plug>(vsnip-jump-prev)"
  else
	-- If <S-Tab> is not working in your terminal, change it to <C-h>
	return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
	require'lspconfig'[server].setup{}
  end
end

setup_servers()
-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- Snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
	'documentation',
	'detail',
	'additionalTextEdits',
  }
}

  require('vim.lsp.protocol').CompletionItemKind = {
	"   (Text) ",
	    "   (Method)",
	    "   (Function)",
	    "   (Constructor)",
	    " ﴲ  (Field)",
	    "[] (Variable)",
	    "   (Class)",
	    " ﰮ  (Interface)",
	    "   (Module)",
	    " 襁 (Property)",
	    "   (Unit)",
	    "   (Value)",
	    " 練 (Enum)",
	    "   (Keyword)",
	    "   (Snippet)",
	    "   (Color)",
	    "   (File)",
	    "   (Reference)",
	    "   (Folder)",
	    "   (EnumMember)",
	    " ﲀ  (Constant)",
	    " ﳤ  (Struct)",
	    "   (Event)",
	    "   (Operator)",
	    "   (TypeParameter)",
  }

require'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
}

-- whichkey
require("which-key").setup {
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
				},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				},
		},
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
			c = {"k"},
	  },
}

-- autopairs
require('nvim-autopairs').setup{}

	local disable_filetype = { "TelescopePrompt" }
	local ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "")
	local enable_moveright = true
	local enable_afterquote = true  -- add bracket pairs after quote
	local enable_check_bracket_line = true  --- check bracket in same line
	local check_ts = false
	
require("nvim-autopairs.completion.compe").setup({
	map_cr = true, --  map <CR> on insert mode
	map_complete = true, -- it will auto insert `(` after select function or method item
	auto_select = false,  -- auto select first item
})

-- nvimtree
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    -- default mappings
    vim.g.nvim_tree_bindings = {
      { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
      { key = "<C-v>",                        cb = tree_cb("vsplit") },
      { key = "<C-x>",                        cb = tree_cb("split") },
	  { key = "<",                            cb = tree_cb("prev_sibling") },
      { key = ">",                            cb = tree_cb("next_sibling") },
      { key = "P",                            cb = tree_cb("parent_node") },
      { key = "<BS>",                         cb = tree_cb("close_node") },
      { key = "<S-CR>",                       cb = tree_cb("close_node") },
      { key = "<Tab>",                        cb = tree_cb("preview") },
      { key = "K",                            cb = tree_cb("first_sibling") },
      { key = "J",                            cb = tree_cb("last_sibling") },
      { key = "I",                            cb = tree_cb("toggle_ignored") },
      { key = "H",                            cb = tree_cb("toggle_dotfiles") },
      { key = "R",                            cb = tree_cb("refresh") },
      { key = "a",                            cb = tree_cb("create") },
      { key = "d",                            cb = tree_cb("remove") },
      { key = "r",                            cb = tree_cb("rename") },
      { key = "<C-r>",                        cb = tree_cb("full_rename") },
      { key = "x",                            cb = tree_cb("cut") },
      { key = "c",                            cb = tree_cb("copy") },
      { key = "p",                            cb = tree_cb("paste") },
      { key = "y",                            cb = tree_cb("copy_name") },
      { key = "Y",                            cb = tree_cb("copy_path") },
      { key = "gy",                           cb = tree_cb("copy_absolute_path") },
      { key = "[c",                           cb = tree_cb("prev_git_item") },
      { key = "]c",                           cb = tree_cb("next_git_item") },
      { key = "-",                            cb = tree_cb("dir_up") },
      { key = "s",                            cb = tree_cb("system_open") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
    }
    
 
