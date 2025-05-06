{ config, pkgs, ... }:

{
  programs.neovim = let
    toLua = str: /*vim*/ "lua << EOF\n${str}\nEOF\n";
    toLuaFile = filename: toLua (builtins.readFile filename);
    theme = import ../../themes/current-theme.nix;
  in {
    enable = true;
    defaultEditor = true;

    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

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

      {
        plugin = blink-cmp;
        config = toLuaFile ./plugins/cmp.lua;
      }

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lsp.lua;
      }
    ];

    extraPackages = with pkgs; [
      xclip
      wl-clipboard

      # LSPs for languages that doesn't need complex version management
      vscode-langservers-extracted
      nodePackages.typescript-language-server
      emmet-ls
      clang-tools
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./keymap.lua}
      ${builtins.readFile ./autocmd.lua}
    '';
  };
}
