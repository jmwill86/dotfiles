# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

# nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.configurationLimit = 10;
	nix.gc.automatic = true;
	# boot.kernelPackages = pkgs.linuxPackages_latest;
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

	i18n.defaultLocale = "en_GB.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_GB.UTF-8";
		LC_IDENTIFICATION = "en_GB.UTF-8";
		LC_MEASUREMENT = "en_GB.UTF-8";
		LC_MONETARY = "en_GB.UTF-8";
		LC_NAME = "en_GB.UTF-8";
		LC_NUMERIC = "en_GB.UTF-8";
		LC_PAPER = "en_GB.UTF-8";
		LC_TELEPHONE = "en_GB.UTF-8";
		LC_TIME = "en_GB.UTF-8";
	};

# Configure keymap in X11
	services.xserver.xkb.layout = "us";
	services.xserver.xkb.variant = "";

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.john = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "docker" ]; 
	};

	nixpkgs.config.allowUnfree = true;  
	environment.sessionVariables.NIXOS_OZONE_WL = "1"; 

	programs.hyprland = { 
		xwayland.enable = true;
		enable = true;
	};

	programs.waybar = {
		enable = true;
	};

	services.displayManager.sddm.wayland.enable = true;
	services.displayManager.sddm.enable = true;

	# NVIDIA
	# services.xserver.videoDrivers = ["nvidia"];

	# hardware.nvidia = {
	# 	modesetting.enable = true;
	# 	powerManagement.enable = false;
	# 	powerManagement.finegrained = false;
	# 	open = false;
	# 	nvidiaSettings = true;
	# 	# package = config.boot.kernelPackages.nvidiaPackages.production;
	# };

	# AMD
	services.xserver.videoDrivers = ["amdgpu"];
	
	# END.

# Enable the X11 windowing system.
	services.xserver.enable = true;
	services.libinput.touchpad.naturalScrolling = true;
# services.xserver.windowManager.i3.enable = true;
	services.libinput.touchpad.disableWhileTyping = true;

	services.gvfs.enable = true;
	services.udev.enable = true;
	services.blueman.enable = true;
	security.rtkit.enable = true;

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};


	virtualisation.docker.enable = true; 
	virtualisation.docker.rootless = { 
		enable = true;
		setSocketVariable = true;
	};


	services.udisks2.enable = true;


# services.xserver.xkbOptions = "caps:escape";

# Enable CUPS to print documents.
	services.printing.enable = true;

# Enable sound.
	hardware.bluetooth.enable = true;

	hardware.graphics = {
		enable = true;
	}; 

# services.xserver.videoDrivers = ["amdgpu"];

# Enable touchpad support (enabled default in most desktopManager).
	services.libinput.enable = true;




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
	programs.thunar.plugins = with pkgs.xfce; [
		thunar-archive-plugin
			thunar-volman
	];

	environment.systemPackages = with pkgs; [
		pipewire
			sublime3
			hyprpaper
			sysctl
			systemd
			bashmount
			blueman
			brightnessctl
			conda
			dbeaver-bin
			discord
			docker
			fd # NVIM/Telescope
			google-fonts
			filezilla
			firefox
			gcc
			gimp
			git
			git-cliff
			gnumake
			google-chrome
			keyd
			libreoffice
			maim
			meld
			mysql80
			neovim
			networkmanager
			nodejs_22
			openvpn
			pkg-config
			python3
			php83
			ripgrep
			wofi
			rust-analyzer
			rustup
			slack
			shotman
			spotify
			tmux
			unzip
			vlc
			wget
			wl-clipboard
			alacritty
			avahi
			dolphin-emu
			micromamba 
			trash-cli
			waybar
			wlogout
			upower
			swaynotificationcenter
			zip
			phinger-cursors	
			stylua
			];

	fonts.packages = with pkgs; [
		nerdfonts
		roboto-mono
	];

	programs.openvpn3.enable = true;
	system.copySystemConfiguration = true;
	system.stateVersion = "24.11"; # Did you read the comment?
		system.autoUpgrade.enable = true;
}
