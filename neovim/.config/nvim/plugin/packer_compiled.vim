" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/pta2002/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/pta2002/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/pta2002/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/pta2002/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/pta2002/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  chadtree = {
    loaded = true,
    path = "/home/pta2002/.local/share/nvim/site/pack/packer/start/chadtree"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n¤\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\14highlight\fdisable\1\0\1\venable\2\1\3\0\0\vledger\bnix\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/pta2002/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  }
}

-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\n¤\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\14highlight\fdisable\1\0\1\venable\2\1\3\0\0\vledger\bnix\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
