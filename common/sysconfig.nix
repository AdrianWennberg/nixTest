{config, pkgs, ...}:
let
    common = import ./variables.nix;
in {
    time.timeZone = "Europe/Dublin";
    i18n.defaultLocale = "en_IE.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        keyMap = "uk";
    };

    # Set sensible kernel parameters
    boot.kernelParams = [
        "boot.shell_on_fail"
        "panic=30" "boot.panic_on_fail" # reboot the machine upon fatal boot issues
    ];

    # Enable LDAP
    users.ldap.enable = true;
    users.ldap.timeLimit = 20;
    users.ldap.server = "ldap://${common.ldapHost}/";
    users.ldap.base = "cn=users,cn=accounts,${common.ldapBase}";
    users.ldap.daemon.enable = true;

    # Creathe home dir if not exists on SSH login
    security.pam.services.sshd.makeHomeDir = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        wget vim git
    ];


    services.nginx.enable = true;
    services.nginx.virtualHosts."example" = {
        locations."/" = {
            proxyPass = "https://ipa.demo1.freeipa.org";
        };
    };
    networking.firewall.allowedTCPPorts = [ 80 ];

}