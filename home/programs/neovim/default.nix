{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      coc-pyright
      coc-tsserver
    ];
    coc = {
      enable = true;
      settings = {
        suggest = {
	  noselect = true;
	  enablePreview = true;
	  enablePreselect = true;
	  disableKind = true ;
	};
	languageserver = {
          haskell = {
            command = "haskell-language-server-wrapper";
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
	};
      };
    };
  };
}
