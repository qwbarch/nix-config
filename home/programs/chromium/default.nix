{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    commandLineArgs = [ "--restore-last-session" ];
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "nngceckbapebfimnlniiiahkandclblb" # BitWarden
      "gppongmhjkpfnbhagpmjfkannfbllamg" # Wappalyzer
      "nkbihfbeogaeaoehlefnkodbefgpgknn" # MetaMask
      "bfnaelmomeimhlpmgjnjophhpkkoljpa" # Phantom Wallet
      "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
      "lebddibgdgkjheglmfpannlomiobdbhm" # Chrome History Cleaner
    ];
  };
}
