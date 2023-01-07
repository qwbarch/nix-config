{ pkgs, ... }:

let
  fzf-hoogle-vim = pkgs.vimUtils.buildVimPlugin {
    name = "fzf-hoogle-vim";
    src = pkgs.fetchFromGitHub {
      owner = "monkoose";
      repo = "fzf-hoogle.vim";
      rev = "16c08d1534aea2cd1cea1a1e20783bd22f634c77";
      sha256 = "0k7cdi00ixqdkqmyqnapn5aplyn0w78iwvm7ifyi9j3smz57hzhf";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = (builtins.readFile ./init.vim) + ''
      let g:hoogle_fzf_cache_file="$HOME/.cache/hoogle_cache.json"
      let g:hoogle_open_link="${pkgs.chromium}/bin/chromium"
    '';
    plugins = with pkgs.vimPlugins; [
      coc-pyright
      coc-tsserver
      coc-eslint
      vim-airline
      vim-gitgutter
      vim-nix
      #vim-prettier
      supertab
      fzf-vim
      fzf-hoogle-vim
      nord-vim
      nerdtree
      haskell-vim
      purescript-vim
    ];
    coc = {
      enable = true;
      settings = {
        coc.preferences = {
          formatOnSaveFiletypes = [
            "haskell"
            "purescript"
            "nix"
            "javascript"
            "typescript"
            "html"
            "css"
          ];
        };
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
            settings.haskell.formatter = "ormolu";
          };
          nix = {
            command = "${pkgs.rnix-lsp}/bin/rnix-lsp";
            filetypes = [ "nix" ];
          };
          purescript = {
            command = "purescript-language-server";
            args = [ "--stdio" ];
            filetypes = [ "purescript" "purs" ];
            trace.server = "off";
            rootPatterns = [ "bower.json" "psc-package.json" "spago.dhall" ];
            settings = {
              purescript = {
                addSpagoSources = true;
                formatter = "purty";
              };
            };
          };
        };
      };
    };
  };
}
