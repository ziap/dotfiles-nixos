{ config, pkgs, ... }:

{
  programs.neovim = let
    to_lua = str: "lua << EOF\n${str}\nEOF\n";
    to_lua_file = filename: to_lua (builtins.readFile filename);
    theme = import ../../themes/current-theme.nix;
  in {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons

      {
        plugin = pkgs.vimPlugins.${theme.nvim.plugin};
        config = ''
          colorscheme ${theme.nvim.colorscheme}
          set background=dark
        '';
      }

      {
        plugin = lualine-nvim;
        config = to_lua_file ./plugins/lualine.lua;
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
          p.tree-sitter-fish
          p.tree-sitter-jsdoc
          p.tree-sitter-glsl
          p.tree-sitter-nix
          p.tree-sitter-nu
          p.tree-sitter-toml
          p.tree-sitter-json
          p.tree-sitter-jsonc
          p.tree-sitter-rasi
        ]));
        config = to_lua_file ./plugins/treesitter.lua;
      }

      cmp-nvim-lsp
      vim-vsnip
      vim-vsnip-integ
      cmp-buffer
      cmp-path
      cmp-cmdline
      {
        plugin = nvim-cmp;
        config = to_lua_file ./plugins/cmp.lua;
      }

      {
        plugin = nvim-lspconfig;
        config = to_lua_file ./plugins/lsp.lua;
      }

      {
        plugin = nvim-autopairs;
        config = to_lua "require'nvim-autopairs'.setup {}";
      }

      {
        plugin = nvim-ts-autotag;
        config = to_lua "require'nvim-ts-autotag'.setup {}";
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

      # Pyright and rust analyzer can be install with development shells
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./keymap.lua}
      ${builtins.readFile ./autocmd.lua}
    '';
  };
}
