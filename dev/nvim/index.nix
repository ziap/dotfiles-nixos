{ config, pkgs, ... }:

{
  programs.neovim = let
    to_lua = str: "lua << EOF\n${str}\nEOF\n";
    to_lua_file = filename: "lua << EOF\n${builtins.readFile filename}\nEOF\n";
    theme = import ../themes/current-theme.nix;
  in {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = pkgs.vimPlugins.${theme.nvim.plugin};
        config = ''
          colorscheme ${theme.nvim.colorscheme}
          set background=dark
        '';
      }
      {
        plugin = lualine-nvim;
        config = to_lua_file ./nvim/plugins/lualine.lua;
      }
      {
        plugin = nvim-ts-autotag;
        config = to_lua "require'nvim-ts-autotag'.setup {}";
      }
      {
        plugin = telescope-nvim;
        config = to_lua "require'telescope'.setup {}";
      }
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-python
          p.tree-sitter-lua
          p.tree-sitter-c
          p.tree-sitter-cpp
          p.tree-sitter-rust
          p.tree-sitter-zig
          p.tree-sitter-javascript
          p.tree-sitter-typescript
          p.tree-sitter-html
          p.tree-sitter-css
          p.tree-sitter-markdown
          p.tree-sitter-markdown-inline
          p.tree-sitter-bash
          p.tree-sitter-jsdoc
          p.tree-sitter-glsl
          p.tree-sitter-nix
          p.tree-sitter-toml
          p.tree-sitter-json
          p.tree-sitter-jsonc
        ]));
        config = to_lua_file ./nvim/plugins/treesitter.lua;
      }
      {
        plugin = nvim-lspconfig;
        config = to_lua_file ./nvim/plugins/lsp.lua;
      }
      cmp-nvim-lsp
      vim-vsnip
      vim-vsnip-integ
      cmp-buffer
      cmp-path
      cmp-cmdline
      {
        plugin = nvim-cmp;
        config = to_lua_file ./nvim/plugins/cmp.lua;
      }
      {
        plugin = nvim-autopairs;
        config = to_lua "require'nvim-autopairs'.setup {}";
      }
    ];

    extraPackages = with pkgs; [
      xclip
      wl-clipboard

      # LSPs
      vscode-langservers-extracted
      nodePackages.typescript-language-server
      emmet-ls
      clang-tools
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
      ${builtins.readFile ./nvim/keymap.lua}
      ${builtins.readFile ./nvim/autocmd.lua}
    '';
  };
}
