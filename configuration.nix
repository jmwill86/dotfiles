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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.libinput.touchpad.naturalScrolling = true;
  services.xserver.windowManager.i3.enable = true;
  services.libinput.touchpad.disableWhileTyping = true;

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
   services.xserver.xkb.layout = "us";
   # services.xserver.xkbOptions = "caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  
  hardware.opengl = {
    enable = true;
  }; 

  services.xserver.videoDrivers = ["amdgpu"];

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
 users.users.john = {
   isNormalUser = true;
   extraGroups = [ "wheel" "networkmanager" "docker" ]; 
 };



 services.mpd.extraConfig = ''
   audio_output {
         type "pulse"
         name "My PulseAudio" # this can be whatever you want
   }
 '';

 services.avahi = {
     enable = true;
     nssmdns4 = true;
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
programs.thunar.enable = true;
environment.systemPackages = with pkgs; [
	sublime3
	sysctl
	systemd
	bashmount
	blueman
	brave
	brightnessctl
	conda
	dbeaver-bin
	discord
	docker
	filezilla
	gcc
	gimp
	gnumake
	google-chrome
	keyd
	libreoffice
	maim
	meld
	mysql80
	neovim
	networkmanager
	openvpn
	php82
	pkg-config
	polybar
	python3
	qbittorrent
	ripgrep
	rofi
	rust-analyzer
	rustup
	slack
	spotify
	tmux
	unzip
	vlc
	wget
	xclip
	alacritty
	avahi
	dolphin-emu
	micromamba 
	shotcut
	trash-cli
        radeontop	
];

  programs.openvpn3.enable = true;

  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;


}
