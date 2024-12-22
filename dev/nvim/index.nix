{ config, pkgs, ... }:

{
  programs.neovim = let
    toLua = str: /*vim*/ "lua << EOF\n${str}\nEOF\n";
    toLuaFile = filename: toLua (builtins.readFile filename);
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
        config = toLuaFile ./plugins/lualine.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLua /*lua*/ "require'telescope'.setup {}";
      }

      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ./plugins/treesitter.lua;
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
        config = toLuaFile ./plugins/cmp.lua;
      }

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lsp.lua;
      }

      {
        plugin = nvim-autopairs;
        config = toLua /*lua*/ "require'nvim-autopairs'.setup {}";
      }

      {
        plugin = nvim-ts-autotag;
        config = toLua /*lua*/ "require'nvim-ts-autotag'.setup {}";
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
