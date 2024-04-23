# NixOS workstation config

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # greeter settings
      ./greeter.nix
      # Import home-manager settings
      ./home-manager.nix
    ];

  # Bootloader.
  boot.loader = {
    grub.enable = true;
    grub.efiSupport = true;
    grub.device = "nodev";
    efi.canTouchEfiVariables = true;
  };

  # Kernel parameters and swap file/hibernate to swap settings.
  # NOTE: when running a clean install, comment out "resumeDevice" and remove
  # resume_offset from "kernelParams", then rebuild the system, find the offset of 
  # the swapfile by running: 
  # "sudo filefrag -v /swapfile | head -n 4 | tail -n 1 | awk '{print $4}' | sed 's/\..//'"
  # in the terminal, and look up your root UUID in fstab, then enter the UUID at the end of
  # the "resumeDevice" line, uncomment it, and then enter the offset in "kernelParams" as
  # "resume_offset=$youroffsethere", then rebuild the system again. 
  swapDevices = [ { device = "/swapfile"; size = 48*1024; } ];
  
  boot = {
    resumeDevice = "/dev/disk/by-uuid/ce7c1e16-7e50-434f-b727-7c242f2d51ea";
    kernelParams = [ "resume_offset=217263104" "amd_iommu=on" "iommu=pt" ];
  };
  
  # Define your hostname and enable networkmanager + vpn.
  networking = {
    hostName = "NixOS-Rig";
    networkmanager.enable = true;
  };
  
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Select kernel version to run/kernel modules to load and add extra modprobe configs.
  boot = { 
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ];
    extraModprobeConfig = "options vfio-pci ids=10de:1287,10de:0e0f";
  };
  
  # Bash settings
  programs.bash.promptInit = ''
    PS1="\[\e[0;31m\] \u  \W  \[\e[m\]"
  '';

  # Enable the X11 windowing system, configure X11 keymap, X11 window managers, Kodi, and X11 config files.
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    excludePackages = [ pkgs.xterm ];
    windowManager = {
      i3.enable = true;
      i3.extraPackages = [ ];
      qtile.enable = true;
    };
    
    displayManager = { 
      startx.enable = true;
      session = [
        { manage = "window";
          name = "i3-startx";
          start = ''
            ${pkgs.xorg.xinit}/bin/startx ~/.xinitrc-i3
          '';
        }

        { manage = "window";
          name = "qtile-startx";
          start = ''
            ${pkgs.xorg.xinit}/bin/startx ~/.xinitrc-qtile
          '';
        }
      ];
    };
    
    desktopManager = {
      kodi.package = pkgs.kodi;
      kodi.enable = true;
    };
    
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
       Option "TearFree" "true"
       Option "VariableRefresh" "true"
       Option "DRI" "3"
    '';
  };

  # Enable fonts
  fonts.packages = [ pkgs.nerdfonts ];

  # Enable sound with alsa and pipewire and set extra pipewire config options.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [ 44100 48000 96000 ];
        };
      };
    };
  };
  
  # Enable wayland compositors, Xwayland, and waybar.
  programs = {
    hyprland.enable = true;
    sway.package = pkgs.swayfx;
    sway.enable = true;
    sway.extraPackages = [ ];
    xwayland.enable = true;
    waybar.enable = true;
    waybar.package = pkgs.waybar;
  };

  # Enabling Nano, Git, Firefox, Htop, Steam, and corectrl.
  programs = {
    nano.enable = true;
    nano.syntaxHighlight = true;
    git.enable = true;
    firefox.enable = true;
    htop.package = pkgs.htop;
    htop.enable = true;
    steam.enable = true;
    gamemode.enable = true;
    corectrl.enable = true;
    corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
  };
  
  # Enable Vulkan.
  hardware.opengl = { 
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable OpenRGB and i2c support.
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
  
  hardware.i2c.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joppe = {
    isNormalUser = true;
    description = "joppe";
    extraGroups = [ "networkmanager" "wheel" "libvirt" "kvm" "i2c"];
    packages = with pkgs; [];
  };

  # Environment variables
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "gtk2";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Networking
  networkmanagerapplet
  transmission-gtk
  # Terminal
  alacritty
  # File managers/utilities
  pcmanfm
  ranger
  yazi
  ueberzugpp
  unzip
  gnutar
  xz
  p7zip
  # E-mail
  thunderbird
  # Notifications
  dunst
  mako
  libnotify
  # Run launchers
  rofi
  wofi
  # Office suite
  libreoffice
  # Multimedia
  alsa-utils
  pavucontrol
  playerctl
  mpv
  feh
  deadbeef-with-plugins
  # Fetch tools
  neofetch
  fastfetch
  # Theming/Fonts
  tokyonight-gtk-theme
  phinger-cursors
  cinnamon.mint-y-icons
  nerdfonts
  # Python
  (python312.withPackages (subpkgs: with subpkgs; [ liquidctl docopt psutil ]))
  # Wine/Gaming
  bottles
  heroic
  mangohud
  prismlauncher
  # Emulators
  duckstation
  pcsx2
  rpcs3
  dolphin-emu
  # Benchmarking
  s-tui
  stress-ng
  unigine-heaven
  unigine-valley
  unigine-superposition
  # Other
  lm_sensors
  (pass.withExtensions (subpkgs: with subpkgs; [ pass-otp ]))
  gparted
  curl
  wget
  lxde.lxsession
  xdotool
  polybarFull
  hyprpaper
  mpvpaper
  appimage-run
  distrobox
  monero-gui
  vscodium-fhs
  autotiling
  ];

  # Enable gnupg
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
     pinentryPackage = pkgs.pinentry-curses;
    };

  # Enable gvfs
  services.gvfs.package = pkgs.gvfs;
  services.gvfs.enable = true;

  # enable bluetooth support
  hardware.bluetooth = {
    package = pkgs.bluez;
    enable = true;
  };
 
  services.blueman.enable = true;
  
  # enable virt-manager, libvirtd daemon, and podman.
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
  };
  
  # Enable fstrim
  services.fstrim.enable = true;

  # Enable openssh
  services.openssh.enable = true;

  # Enable polkit
  security.polkit.enable = true;

  # Firewall settings 
  networking.firewall.enable = false;

  # Automounting additional drives
  # NOTE: comment these options if the drive configuration has changed to avoid errors.
  fileSystems = {
    "6TB-HDD" = {
      mountPoint = "/6TB-HDD";
      device = "/dev/disk/by-uuid/6ec96be9-3ca5-46cf-96f2-28aa84e3dacf";
      fsType = "ext4";
      label = "6TB-HDD";
    };

    "VM-SSD" = {
      mountPoint = "/VM-SSD";
      device = "/dev/disk/by-uuid/45c4df5b-758f-4fdf-bdae-ee39f4c0a076";
      fsType = "ext4";
      label = "VM-SSD";
    };
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
