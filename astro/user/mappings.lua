-- Helpers
local function get_dir(filepath)
  return filepath:match("(.*/)")
end

local function cmd_async(str)
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
local function map(mode, binding, action)
  if is_array(mode) then
    for _, m in ipairs(mode) do map(m, binding, action) end
    return
  end
  M[mode][binding] = action;
end

local function remap(from, to)

end


remap({ 'n', "<leader>db" }, { 'n', "<leader>db" })
remap({ 'n', "<leader>dB" }, { 'n', "<leader>dB" })
remap({ 'n', "<leader>dc" }, { 'n', "<leader>dc" })
remap({ 'n', "<leader>di" }, { 'n', "<leader>di" })
remap({ 'n', "<leader>do" }, { 'n', "<leader>do" })
remap({ 'n', "<leader>dO" }, { 'n', "<leader>dO" })
remap({ 'n', "<leader>dq" }, { 'n', "<leader>dq" })
remap({ 'n', "<leader>dQ" }, { 'n', "<leader>dQ" })
remap({ 'n', "<leader>dp" }, { 'n', "<leader>dp" })
remap({ 'n', "<leader>dr" }, { 'n', "<leader>dr" })
remap({ 'n', "<leader>dR" }, { 'n', "<leader>dR" })
remap({ 'n', "<leader>du" }, { 'n', "<leader>du" })
remap({ 'n', "<leader>dh" }, { 'n', "<leader>dh" })

-- For my Ctrl skills are lacking -_-
map("i", "[:w<CR>", "<C-[>:w<CR>")

-- multiple cursors
map("n", "<C-d>", "<C-n>")
map("v", "<C-d>", "<C-n>")
map("", "<C-d>", "<C-n>")
map("n", "<a-d>", "<C-d>")

-- Comments
if not vim.g.neovide then
  map("n", "<C-_>", "<cmd> :lua require('Comment.api').toggle.linewise.current()<CR>j")
  map("v", "<C-_>", "<esc><cmd> :lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

  -- Ctrl+Shift+/ gives <BS> for some reason
  map("n", "<BS>", "viw<esc><cmd> :lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>j")
  map("v", "<BS>", "<esc><cmd> :lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>")
else
  map("n", "<C-/>", "<cmd> :lua require('Comment.api').toggle.linewise()<CR>j")
  map("v", "<C-/>", "<esc><cmd> :lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")

  map("n", "<C-?>", "viw<esc><cmd> :lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>j")
  map("v", "<C-?>", "<esc><cmd> :lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>")
end


-- Wrap in quotes
map('v', "'", "c''<C-[>P");

-- move line with proper tabbing
map("n", "<a-j>", '$v^d"_ddoa<C-[>p^"_x')
map("n", "<a-k>", '$v^d"_ddkOa<C-[>p^"_x')

-- tree
map("n", "<a-1>", ":Neotree toggle<CR>")
map("n", "<a-w>", ":Neotree reveal<CR>")

-- Tab close. TODO: ensure that this doesn't close nvim
map("n", "<C-w>", "<CMD>:Neotree close<CR><C-w>:bd<CR>")
map("i", "<C-w>", "<C-[><C-w>:bd<CR>")

-- poor man's insert
map("n", "<C-v>", "<C-[>P")
map("i", "<C-v>", "<C-[>p")

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
      vim.api.nvim_set_hl(0, "Normal", { bg = "#110000" })
    end
  })

  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
      if not color then return end
      vim.api.nvim_set_hl(0, "Normal", { bg = "#001100" })
    end
  })
end

map({ "t" }, "hh", "<C-\\><C-n>")

-- horizontal window movement
map({ "n", "i" }, "<C-j>", "<C-w>h")
map({ "n", "i" }, "<C-k>", "<C-w>l")

map({ "n" }, "<leader>;w", "<cmd>w<CR>")
-- map({ "i" }, ":w<CR>", "<cmd>w<CR>")

map({ "n" }, "<C-[>", "<C-[>:w<CR>");

map("n", "gf", function()
  print("YOBABA", require("obsidian").util.cursor_on_markdown_link())
  if require("obsidian").util.cursor_on_markdown_link() then
    return cmd_async("<cmd>ObsidianFollowLink<CR>")
  else
    return cmd_async("gf")
  end
end)

map("n", "<leader>r", "<cmd>ToggleTerm direction=float<cr><C-c><CR><UP><CR><cmd>ToggleTerm<cr>")


-- horizontal window movement from input mode
map({ "i" }, "<C-j>", "<C-[><C-w>h")
map({ "i" }, "<C-k>", "<C-[><C-w>l")

-- vertical window movement
map({ "n", "i" }, "<C-h>", "<C-w>j")
map({ "n", "i" }, "<C-l>", "<C-w>k")

-- vertical window movement from input mode
map({ "i" }, "<C-h>", "<C-[><C-w>j")
map({ "i" }, "<C-l>", "<C-[><C-w>k")

-- Split vertically
map("", "<a-t>", "<C-w>v");

-- bufferline (tabs)
-- map({ "n" }, "K", "<C-[>:BufferLineCycleNext<CR>")
-- map({ "n" }, "J", "<C-[>:BufferLineCyclePrev<CR>")
map({ "n" }, "K", { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" })
map({ "n" }, "J", { function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Previous buffer" })


map("v", "<", "<gv")
map("v", ">", ">gv")


map("v", "J", "j")
map("v", "K", "k")

-- space->w to map for Ctrl+w
map("n", "<leader>w", "<C-w>")

-- insert line inplace
map({ "n", "v" }, "<C-o>", '"_ddO')

-- map("", '<C-j>', '<DOWN>')
-- map("", '<C-k>', '<UP>')

-- do not put to the register
M.n["x"] = '"_x'
M.n["X"] = '"_X'
M.n["d"] = '"_d'
M.n["D"] = '"_D'
M.v["x"] = 'd'
M.v["d"] = '"_d'

M.n['ce'] = '"_ce'
M.n['cw'] = '"_cw'
M.n['cb'] = '"_cb'
M.n['cW'] = '"_cW'
M.n['cB'] = '"_cB'
M.n['ciw'] = '"_ciw'
M.n['caw'] = '"_caw'
M.n['cc'] = '"_cc'
M.v['c'] = '"_c'

-- config related
map('n', '\\e', ':!gnome-terminal -- /bin/bash -c "cd ~/.config/nvim/lua && nvim user/mappings.lua"<CR>')
map('n', '\\r', function()
  require('user.custom.reload').ReloadConfig()
end)


-- History jumps
map('n', '<S-h>', '<C-o>')
map('n', '<S-l>', '<C-i>')

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
map({ 'n', 'i' }, '<a-n>', function()
  local dir = get_dir(vim.fn.expand('%'))
  if dir == nil then
    dir = './'
  end
  vim.ui.input({ prompt = "Create file: ", default = dir, completion = "file" }, function(fname)
    if not fname then return end

    local target_dir = get_dir(fname)

    if not fname or not target_dir then return end

    cmd_async('<-[>:!mkdir -p ' .. target_dir .. '<CR>:e ' .. fname .. '<CR>:w<CR>')
  end)
end)


_G.bibo = {}

local U = require('user.util')

_G.bibo.do_alt_m = function()
  -- local mode = vim.api.nvim_get_mode()
  -- print('mode: ' .. mode['mode'] .. ' blocking: ' .. tostring(mode['blocking']))
  local str = U.get_visual_selection()
  -- print(str)

  vim.ui.select({ 'component', 'feat' }, {
    prompt = 'Select tabs or spaces:',
    format_item = function(item)
      return "Move it as " .. item
    end,
  }, function(strata)
    if not strata then return end
    -- print('strata:'..strata)
    local file = vim.fn.expand('%')
    if strata == 'component' then
      local fs = io.open(vim.fn.getcwd() .. '/scripts/move/selection.tmp', 'w')
      if fs then
        fs:write(str)
        fs:close()
      else
        print('no file')
        return
      end

      -- cmd_async("gv")
      cmd_async('<-[>:!node ' .. vim.fn.getcwd() .. '/scripts/move/moveit.js ' .. strata .. ' ' .. file .. '  <CR>')
    elseif strata == 'feat' then
      if vim.fn.fnamemodify(vim.fn.expand('%'), ':t:r') == 'mod' then
        file = get_dir(file)
      end
      cmd_async('<-[>:!node ' .. vim.fn.getcwd() .. '/scripts/feat/mkfeat.js ' .. file .. '<CR>')
    end
  end)
end


map({ 'n' }, '<a-m>', function()
  local file = vim.fn.expand('%')
  if vim.fn.fnamemodify(vim.fn.expand('%'), ':t:r') == 'mod' then
    file = get_dir(file)
  end
  vim.ui.select({'refactor into feature pkg: '..file}, { prompt = "Confirm dat shi" }, function (kek)
    if not kek then return end
    cmd_async('<-[>:!node ' .. vim.fn.getcwd() .. '/scripts/feat/mkfeat.js ' .. file .. '<CR>')
  end)
end)

--
-- refactor thingy
map({ 'v' }, '<a-m>', [[:<C-u>call v:lua.bibo.do_alt_m()<CR>]])

-- Terminal
-- map({ 'n', 'v', 'i' }, '<C-Space>', '<C-[><cmd>ToggleTerm size=10 direction=horizontal<cr>')
map({ 'n', 'v', 'i' }, '<M-Space>', '<C-[><cmd>ToggleTerm direction=float<cr>')
-- map('t', "<C-Space>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
map('t', "<M-Space>", "<cmd>ToggleTerm<cr>")
map('t', "<Esc>", "<C-\\><C-n><C-w>k")

-- cmd chortcuts
map('n', '\\w', '<cmd>w<cr>')

return M
