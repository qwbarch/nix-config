{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "nngceckbapebfimnlniiiahkandclblb" # BitWarden
      "gppongmhjkpfnbhagpmjfkannfbllamg" # Wappalyzer
      "nkbihfbeogaeaoehlefnkodbefgpgknn" # MetaMask
      "bfnaelmomeimhlpmgjnjophhpkkoljpa" # Phantom Wallet
    ];
  };
}
