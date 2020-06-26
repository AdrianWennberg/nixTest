{
    test = 
    { config, pkgs, ... }:
    {
        deployment.targetEnv = "libvirtd";
        deployment.libvirtd.headless = true;
        imports = [ ./common/sysconfig.nix ];
}