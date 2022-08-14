-- Helpers
local function get_dir(filepath)
   return filepath:match("(.*/)")
end
local function cmd(str)
  vim.api.nvim_input(str)
end

local function is_array(t)
  if type(t) == "string" then return false end
  local i = 0
  for _ in pairs(t) do
      i = i + 1
      if t[i] == nil then return false end
  end
  return true
end


local M = {
  v = {},
  i = {},
  n = {},
  t = {},
  [""] = {}
}
local function map (mode, binding, action)
  if is_array(mode) then
    for _, m in ipairs(mode) do map(m, binding, action) end
    return
  end
  M[mode][binding] = action;
end


-- For my Ctrl skills are lacking -_-
map("i", "[:w<CR>", "<C-[>:w<CR>")

-- multiple cursors
map("n", "^D", "<C-n>")
map("", "<C-D>", "<C-n>")
map("n", "<a-d>", "<C-d>")

-- Comments
if not vim.g.neovide then
  map("n", "<C-_>", "<cmd> :lua require('Comment.api').toggle_current_linewise()<CR>j")
  map("v", "<C-_>", "<esc><cmd> :lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")

  -- Ctrl+Shift+/ gives <BS> for some reason
  map("n", "<BS>", "viw<esc><cmd> :lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>j")
  map("v", "<BS>", "<esc><cmd> :lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>")
else
  map("n", "<C-/>", "<cmd> :lua require('Comment.api').toggle_current_linewise()<CR>j")
  map("v", "<C-/>", "<esc><cmd> :lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")

  map("n", "<C-?>", "viw<esc><cmd> :lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>j")
  map("v", "<C-?>", "<esc><cmd> :lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>")
end


-- move line with proper tabbing
map("n", "<a-j>", '$v^d"_ddoa<C-[>p^"_x')
map("n", "<a-k>", '$v^d"_ddkOa<C-[>p^"_x')

-- tree
map("n", "<a-1>", ":Neotree toggle<CR>")
map("n", "<a-w>", ":Neotree reveal<CR>")

-- Tab close. TODO: ensure that this doesn't close nvim
map("n", "<C-w>", "<C-w>:bd<CR>")
map("i", "<C-w>", "<C-[><C-w>:bd<CR>")

-- poor man's insert
map("n", "<C-v>", "<C-[>P")
map("i", "<C-v>", "<C-[>P")

-- What is dis? togoogle
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- Restores cursor after reopen
vim.cmd([[autocmd BufRead * call setpos(".", getpos("'\""))]])

if 'Change color on mode' and false then
  local color = nil
  vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	  callback = function()
		  if color == nil then
		    local hl = vim.api.nvim_get_hl_by_name('Normal', true)
		    print('init with', hl)
		    print(hl.background)
		    print(hl.bg)
		    -- for k,v in pairs(r) do
		      -- print(k,r[k], v)
		    -- end
		    color = 'kek';
		  end
		  vim.api.nvim_set_hl(0, "Normal", {bg="#110000"})
	  end
  })

  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	  callback = function()
		  if not color then return end
		  vim.api.nvim_set_hl(0, "Normal", {bg="#001100"})
	  end
  })
end

-- horizontal window movement
map({"n", "i"}, "<C-j>", "<C-w>h")
map({"n", "i"}, "<C-k>", "<C-w>l")

-- horizontal window movement from input mode
map({"i"}, "<C-j>", "<C-[><C-w>h")
map({"i"}, "<C-k>", "<C-[><C-w>l")

-- Split vertically
map("", "<a-t>", "<C-w>v");

-- bufferline (tabs)
map({"n", "v"}, "K", "<C-[>:BufferLineCycleNext<CR>")
map({"n", "v"}, "J", "<C-[>:BufferLineCyclePrev<CR>")

-- space->w to map for Ctrl+w
map("n", "<leader>w", "<C-w>")

-- insert line inplace
map({"n", "v"}, "<C-o>", "ddO")

-- map("", '<C-j>', '<DOWN>')
-- map("", '<C-k>', '<UP>')

-- do not 
M.n["x"] = '"_x'
M.n["X"] = '"_X'
M.n["d"] = '"_d'
M.n["D"] = '"_D'
M.v["x"] = 'd'
M.v["d"] = '"_d'

-- config related
map('n', '\\e', ':!gnome-terminal -- /bin/bash -c "cd ~/.config/nvim/lua && nvim user/mappings.lua"<CR>')
map('n', '\\r', function ()
  require('user.custom.reload').ReloadConfig()
end)


-- History jumps
map('n', 'H', '<C-o>')
map('n', 'L', '<C-i>')

-- Recent files
M.n["<C-e>"] = function() require("telescope.builtin").oldfiles() end

-- LSP things
map('', '<F2>', function() vim.lsp.buf.rename() end)
map('i', '<F2>', function() vim.lsp.buf.rename() end)
map('', '<C-q>', function() vim.lsp.buf.signature_help() end)
map('', '<M-CR>', function() vim.lsp.buf.code_action() end)
map('n', 'gi', function() vim.lsp.buf.implementation() end)

-- diagnostics
map('n', "<a-.>", function() vim.diagnostic.goto_next() end)
map('n', "<a-,>", function() vim.diagnostic.goto_prev() end)


-- New file
map({'n', 'i'}, '<a-n>', function ()
  local dir = get_dir(vim.fn.expand('%'))
  if dir == nil then
    dir = './'
  end
  local fname = vim.fn.input("Create file: ", dir, "file")
  local target_dir = get_dir(fname)

  if not fname or not target_dir then return end

  cmd('<-[>:!mkdir -p '..target_dir..'<CR>:e '..fname..'<CR>:w<CR>')
end)

-- Terminal
map({'n', 'v', 'i'}, '<C-Space>', '<C-[><cmd>ToggleTerm size=10 direction=horizontal<cr>')
map({'n', 'v', 'i'}, '<M-Space>', '<C-[><cmd>ToggleTerm direction=float<cr>')
map('t', "<C-Space>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
map('t', "<M-Space>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
map('t', "<Esc>", "<C-\\><C-n><C-w>k")

-- cmd chortcuts
map('n', '\\w', '<cmd>w<cr>')


return M

