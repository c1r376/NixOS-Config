# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_xanmod;
	boot.supportedFilesystems = [ "ntfs"];

  networking.hostName = "x260"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_US.UTF-8";
    LC_IDENTIFICATION = "es_US.UTF-8";
    LC_MEASUREMENT = "es_US.UTF-8";
    LC_MONETARY = "es_US.UTF-8";
    LC_NAME = "es_US.UTF-8";
    LC_NUMERIC = "es_US.UTF-8";
    LC_PAPER = "es_US.UTF-8";
    LC_TELEPHONE = "es_US.UTF-8";
    LC_TIME = "es_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
	enable = true;
	displayManager.sddm = {
		enable = true;
		theme = "maya";
		autoNumlock = true;
	};
  };

	programs.thunar.plugins =
	with pkgs.xfce;
	[ thunar-archive-plugin ]
	;

	programs.hyprland = {
		enable = true;
		xwayland.hidpi = true;
		xwayland.enable = true;
	};

	# Hint Electron apps to use wayland
	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1";
	};

	services.dbus.enable = true;
	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
		];
	};

	nixpkgs.overlays = [
		(self: super: {
		waybar = super.waybar.overrideAttrs (oldAttrs: {
			mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
		});
		})
	];

	fonts.fonts = with pkgs; [
		nerdfonts
		meslo-lgs-nf
		font-awesome
		google-fonts
	];

	services.blueman.enable = true;

	sound.enable = true;
		hardware = {
			bluetooth.enable = true;
		};

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.c1r3 = {
    isNormalUser = true;
    description = "c1r3";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
	nixpkgs.config.allowInsecure = true;
	nixpkgs.config.permittedInsecurePackages = [
	"openssl-1.1.1w"
	];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
	hyprland
	swww # for wallpapers
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland
	xwayland
	greetd.wlgreet
	polkit

	meson
	wayland-protocols
	wayland-utils
	wl-clipboard
	wlroots

	rofi-wayland
	wofi

	blueman
	brightnessctl
	dunst
	foot
	git
	kitty
	libnotify
	nano
	pavucontrol
	pipewire
	wlr-randr

	hyprpaper
	swaybg
	wpaperd
	mpvpaper
	swww
	eww
	eww-wayland
	mako
	waybar
	
	antimicrox
	audacity
	blender
	btop
	celluloid
	firefox-wayland
	gimp
	github-desktop
	google-chrome
	gparted
	handbrake
	inkscape
	kdenlive
	kitty
	libreoffice
	kodi
	libreoffice
	lutris
	neofetch
	openssl
	popcorntime
	protonup-ng
	protonup-qt
	qbittorrent
	ranger
	steam
	steam-run
	sublime
	unzip
	wget
	wine
	xfce.thunar
	zip


  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
	system.copySystemConfiguration = true;
	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;
	system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
