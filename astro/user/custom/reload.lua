local M = {}

M.ReloadConfig = function ()
  for name, _ in pairs(package.loaded) do
    if (name:match('^user') or name:match('^core')) and not name:match('nvim-tree') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end


return M
