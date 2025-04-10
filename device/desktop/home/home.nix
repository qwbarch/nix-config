{ pkgs, home-manager, system, username, stateVersion, ...}:

let
    packages = with pkgs; [
        # Programming
        git
        vscode
    ];
{
    ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs system username stateVersion;
        homeDirectory = "/home/${username}";
        configuration = {
            programs.home-manager.enable = true;
            systemd.user.startServices = "sd-switch";
            home.packages = packages;
        };
    };
}