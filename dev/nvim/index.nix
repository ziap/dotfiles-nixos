{ config, pkgs, ... }:

{
  programs.neovim = let
    to_lua = str: /*vim*/ "lua << EOF\n${str}\nEOF\n";
    to_lua_file = filename: to_lua (builtins.readFile filename);
    theme = import ../../themes/current-theme.nix;
  in {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons

      {
        plugin = pkgs.vimPlugins.${theme.nvim.plugin};
        config = /*vim*/ ''
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
        config = to_lua /*lua*/ "require'telescope'.setup {}";
      }

      {
        plugin = nvim-treesitter.withAllGrammars;
        config = to_lua_file ./plugins/treesitter.lua;
      }

      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      vim-vsnip
      cmp-vsnip
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
        config = to_lua /*lua*/ "require'nvim-autopairs'.setup {}";
      }

      {
        plugin = nvim-ts-autotag;
        config = to_lua /*lua*/ "require'nvim-ts-autotag'.setup {}";
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
