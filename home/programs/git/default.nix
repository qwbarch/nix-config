{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "qwbarch@gmail.com";
    userName = "qwbarch";
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
      "filter \"lfs\"" = {
        clean = "${pkgs.git-lfs}/bin/git-lfs clean -- %f";
        smudge = "${pkgs.git-lfs}/bin/git-lfs smudge --skip -- %f";
        process = "${pkgs.git-lfs}/bin/git-lfs filter-process --skip";
        required = true;
      };
    };
  };
}
