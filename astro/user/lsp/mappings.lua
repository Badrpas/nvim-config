

return function (M)

  M.n["<c-q>"] = M.n['K']
  print(M.n["<c-q>"]['desc'])
  M.n.K = nil

  return M
end



