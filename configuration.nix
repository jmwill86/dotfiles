# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc.automatic = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 80;
  };

  
  networking.extraHosts =
  ''
    127.0.0.1 localhost.com
  '';

  networking.hostName = "jw-nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.userControlled.enable = true;
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.libinput.touchpad.disableWhileTyping = true;

  services.gvfs.enable = true;
  services.udev.enable = true;

  # services.xserver.windowManager.i3.configFile = /home/john/dotfiles/i3/config;
  # services.xserver.windowManager.i3.extraPackages = with pkgs; [
  #   dmenu
  # ];

services.blueman.enable = true;

virtualisation.docker.enable = true; 
virtualisation.docker.rootless = { 
	enable = true;
	setSocketVariable = true;
};


services.udisks2.enable = true;


  # Configure keymap in X11
   services.xserver.layout = "us";
   # services.xserver.xkbOptions = "caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
 users.users.john = {
   isNormalUser = true;
   extraGroups = [ "wheel" "networkmanager" "docker" ]; 
#   packages = with pkgs; [
#     firefox
#     thunderbird
#   ];
 };



 services.mpd.extraConfig = ''
   audio_output {
         type "pulse"
         name "My PulseAudio" # this can be whatever you want
   }
 '';

 services.avahi = {
     enable = true;
     nssmdns = true;
     publish = {
       enable = true;
       addresses = true;
       domain = true;
       hinfo = true;
       userServices = true;
       workstation = true;
     };
 };
 
	# boot.kernelParams = ["amdgpu.backlight=0" "acpi_backlight=none"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget

environment.systemPackages = with pkgs; [
	alacritty
	 bashmount
	micromamba 
	 blueman
	 brightnessctl
	 brave
	 dbeaver
	 discord
	 docker
	 qbittorrent
	# fd
	 filezilla
	 gcc
	 gimp
	 google-chrome
	 keyd
	dolphin-emu
	# # kanata
	 libreoffice
	 maim
	 meld
	# mpd
	 mysql80
	 neovim
	 neovide
	 networkmanager
	# nodejs
	 openvpn
	 php82
	 polybar
	 python3
	 ripgrep
	 rofi
	 rustup
	 rust-analyzer
	 slack
	 spotify
	  sublime3
	  sysctl
	  systemd
	 tmux
	 conda
	 # udisks2
	 unzip
	 wget
	# wine
	avahi
	 xclip
	 gnumake
	 pkg-config
        beekeeper-studio
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
# 	services.kanata.enable = true;
# 
# services.kanata.keyboards.default.devices = [
#       "/dev/input/by-path/platform-i8042-serio-0-event-kbd" # laptop keyboards
# ];
# 
# services.kanata.keyboards.default.config = ''
# 
# '';

  programs.openvpn3.enable = true;

# programs.light.enable = true;
 #services.actkbd = {
 #    enable = true;
 #    bindings = [
 #      { keys = [ 232 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl set 30-"; }
 #      { keys = [ 233 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl set +30"; }
 #    ];
 #  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  system.autoUpgrade.enable = true;

  # services.keyd.enable = true;
  # systemd.services = {
  #   # https://github.com/NixOS/nixpkgs/issues/59603#issuecomment-1356844284
  #   NetworkManager-wait-online.enable = false;

  #   keyd = {
  #     enable = true;
  #     description = "keyd key remapping daemon";
  #     unitConfig = {
  #       Requires = "local-fs.target";
  #       After = "local-fs.target";
  #     };
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.keyd}/bin/keyd";
  #     };
  #   };
  # };
  #environment.etc."keyd/default.conf".text = keydConfig;

}


