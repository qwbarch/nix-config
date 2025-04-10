{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = (builtins.readFile ./init.vim) + ''
      let g:hoogle_fzf_cache_file="$HOME/.cache/oogle_cache.json"
      let g:hoogle_open_link="${pkgs.firefox}/bin/firefox"
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      supertab
      fzf-vim
      nerdtree
    ];
  };
}
