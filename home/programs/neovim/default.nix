{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = (builtins.readFile ./init.vim) + ''
      let g:ormolu_command="${pkgs.ormolu}/bin/ormolu"
    '';
    plugins = with pkgs.vimPlugins; [
      coc-pyright
      coc-tsserver
      vim-airline
      vim-gitgutter
      vim-ormolu
      vim-nix
      vim-autoformat
      supertab
      fzf-vim
      nord-vim
      nerdtree
    ];
    coc = {
      enable = true;
      settings = {
        suggest = {
          noselect = true;
          enablePreview = true;
          enablePreselect = true;
          disableKind = true;
        };
        languageserver = {
          haskell = {
            command = "haskell-language-server";
            args = [ "--lsp" ];
            rootPatterns = [
              "*.cabal"
              "stack.yaml"
              "cabal.project"
              "package.yaml"
              "hie.yaml"
            ];
            filetypes = [ "haskell" "lhaskell" "hs" "lhs" ];
          };
          nix = {
            command = "${pkgs.rnix-lsp}/bin/rnix-lsp";
            filetypes = [ "nix" ];
          };
        };
      };
    };
  };
}
