{
  programs.git = {
    enable = true;
    userEmail = "qwbarch@gmail.com";
    userName = "qwbarch";
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
