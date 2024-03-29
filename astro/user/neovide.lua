if not vim.g.neovide then return end

vim.g.neovide_cursor_trail_length = 0.01
vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_transparency = 0.85
vim.g.neovide_cursor_vfx_mode = 'railgun'

vim.g.winblend = 50
vim.g.pumblend = 50

vim.g.neovide_floating_opacity = 70
vim.g.neovide_floating_blur = 70

print('THIS IS NEOVIDE')

vim.g.gui_font_default_size = 8
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "FiraCode Nerd Font Mono"


RefreshGuiFont = function()
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
end

ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'i' }, "<C-+>", function() ResizeGuiFont(1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<C-->", function() ResizeGuiFont(-1) end, opts)
