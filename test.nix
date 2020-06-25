{

    test = 
    { config, pkgs, ... }:
    {
        deployment.targetEnv = "libvirtd";
        nixpkgs.overlays = [ (import ./overlay/nixops.nix) ];

        services.nginx.enable = true;
        services.nginx.virtualHosts."example" = {
            locations."/" = {
                proxyPass = "https://nixos.org";
            };
        };
    };
}