# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }:


let

## WordPress default test
## For shits and giggles, let's package the responsive theme
#responsiveTheme = pkgs.stdenv.mkDerivation {
	#name = "responsive-theme";
   	## Download the theme from the wordpress site
   	#src = pkgs.fetchurl {
		#url = http://wordpress.org/themes/download/responsive.1.9.7.6.zip;
   		##sha256 = "06i26xlc5kdnx903b1gfvnysx49fb4kh4pixn89qii3a30fgd8r8";
   		#sha256 = "1g1mjvjbx7a0w8g69xbahi09y2z8wfk1pzy1wrdrdnjlynyfgzq8";
   	#};
	## We need unzip to build this package
        #buildInputs = [ pkgs.unzip ];
        ## Installing simply means copying all files to the output directory
        #installPhase = "mkdir -p $out; cp -R * $out/";
#};
#
## Wordpress plugin 'akismet' installation example
#akismetPlugin = pkgs.stdenv.mkDerivation {
	#name = "akismet-plugin";
	## Download the theme from the wordpress site
	#src = pkgs.fetchurl {
		#url = https://downloads.wordpress.org/plugin/akismet.3.1.zip;
		##sha256 = "1i4k7qyzna08822ncaz5l00wwxkwcdg4j9h3z2g0ay23q640pclg";
		#sha256 = "1wjq2125syrhxhb0zbak8rv7sy7l8m60c13rfjyjbyjwiasalgzf";
#
	#};
	## We need unzip to build this package
	#buildInputs = [ pkgs.unzip ];
	## Installing simply means copying all files to the output directory
	#installPhase = "mkdir -p $out; cp -R * $out/";
#};


in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.supportedFilesystems = [ "zfs" ];
  # boot.extraModulePackages =  [ config.boot.kernelPackages.exfat-nofuse ];
  networking.hostId = lib.mkDefault "deadbeef";

  #nixpkgs.config.packageOverrides = pkgs: rec {

  #  # Fix nvim not building because of luv
  #  #myLuv = pkgs.luaPackages.luv.override (attrs: rec {
  #  myLuv = pkgs.luajit.pkgs.luv.libluv.override (attrs: rec {
  #            version = "1.34.1-1";
  #            src = pkgs.fetchurl {
  #              url = https://luarocks.org/luv-1.34.1-1.src.rock;
  #              sha256 = "044cyp25xn35nj5qp1hx04lfkzrpa6adhqjshq2g7wvbga77p1q0";
  #            };
  #    });

  #};

  # Environment Packages
  # Use unstable packages
  #nix.nixPath = lib.mkDefault (lib.mkBefore [ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs" ]);
  #nixPath = [ "nixpkgs=http://nixos.org/channels/nixos-unstable/nixexprs.tar.xz" ];
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
  [ pkgs.python
    pkgs.radarr
    pkgs.sonarr
    pkgs.plex
    #pkgs.myLuv # remove this at some point
    pkgs.neovim
    pkgs.kitty
    pkgs.stow
    pkgs.smartmontools
    pkgs.deluge
    pkgs.git
    pkgs.oh-my-zsh
    pkgs.ntfs3g
    pkgs.ranger
    pkgs.vim
    pkgs.screen # needed by ranger
    pkgs.lf
    pkgs.reptyr
    pkgs.tmux
    pkgs.htop
    pkgs.virtualbox
    pkgs.iperf3
    #pkgs.docker
    pkgs.minecraft-server
    pkgs.ffmpeg
    pkgs.cmake
    pkgs.ncdu
    pkgs.tree
    #(import (fetchTarball "channel:nixos-unstable") {}).radarr
  ];

  # Enable smard
  services.smartd = {
    enable = true;
    notifications.wall.enable = true;
    notifications.mail.enable = true;
    notifications.test = true;
  };

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      #"*/30 * * * *      root    cp -r -u -p /var/lib/minecraft /root/ && date >> /home/carlb/latest-minecraft-backup.log"
      "*/30 * * * *      root    python /home/carlb/EdsGodaddyDNSUpdater/update_godaddy_dns.py > /home/carlb/dns-update.log"
    ];
  };

  # systemPackages = [  ];

  # Docker
  virtualisation.docker.enable = true;

#docker create \
  #--name=organizr \
  #-v <path to data>:/config \
  #-e PGID=<gid> -e PUID=<uid>  \
  #-p 80:80 \
  #organizrtools/organizr-v2

  #organizr = buildImage {
    #name = "organizr-layer";
    #tag = "latest";
    #fromImage = organizrFromDockerHub;
    ##contents = [ pkgs.hello ];
    #config = {
	   ##Cmd = [ "/bin/organizr" ];
	   ##WorkingDir = "/data";
	   #user = "organizr:users";
	   #ExposedPorts = {
		#"80" = {};
	   #};
	   #Volumes = {
	     #"/config" = {};
	   #};
    #};
  #};
# 1. basic example
#bash = buildImage {
	#name = "organizr";
	#tag = "latest";
	##contents = pkgs.bashInteractive;
	#fromImageName = "organizrtools/organizr-v2
#};

# 2. service example, layered on another image
#redis = buildImage {
	#name = "redis";
	#tag = "latest";
#
	## for example's sake, we can layer redis on top of bash or debian
	#fromImage = bash;
	## fromImage = debian;
#
	#contents = pkgs.redis;
	#runAsRoot = ''
	#mkdir -p /data
	#'';
#
	#config = {
		#Cmd = [ "/bin/redis-server" ];
		#WorkingDir = "/data";
		#Volumes = {
		#"/data" = {};
		#};
	#};
#};

  # Programs
  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

    # oh-my-zsh options:
    ZSH_THEME="agnoster"
    plugins=(git)

    source $ZSH/oh-my-zsh.sh
    '';

  # Users
  users.users.carlb =
  { isNormalUser = true;
    home = "/home/carlb";
    description = "Carl Blomqvist";
    extraGroups = [ "carlb" "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    # openssh.authorizedKeys.keys [ "ssh-dss asåofjaåsofjaåojf... carlb@foobar" ];
  };

  users.users.sshfs =
  { isNormalUser = true;
    home = "/home/sshfs";
    description = "Account to connect using sshfs-win";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    # openssh.authorizedKeys.keys [ "ssh-dss asåofjaåsofjaåojf... carlb@foobar" ];
  };

  users.users.sickan =
  { isNormalUser = true;
    home = "/home/sickan";
    description = "Rickard Carlsson";
    extraGroups = [];
    shell = pkgs.zsh;
    # openssh.authorizedKeys.keys [ "ssh-dss asåofjaåsofjaåojf... carlb@foobar" ];
  };


  users.users.carlw =
  { isNormalUser = true;
    home = "/home/carlw";
    description = "Carl Wåhlander";
    extraGroups = [ ];
    shell = pkgs.zsh;
    # openssh.authorizedKeys.keys [ "ssh-dss asåofjaåsofjaåojf... carlb@foobar" ];
  };

  users.users.ombi =
  { isNormalUser = true;
    description = "User for Ombi";
  };

  # Servies

  services.iperf3.openFirewall = true;
  services.iperf3.authorizedUsersFile = "/home/carlb/.iperfcreds";

#   systemd.services.deluged = {
 #     description = "deluged";
  #    serviceConfig = {
   #     Type = "forking";
    #    User = "carlb";
     #   ExecStart = "${pkgs.deluge}/bin/deluged";
      #  ExecStop = "pkill deluged";
       # Restart = "on-failure";
     #};
     #wantedBy = [ "default.target" ];
   #};

  # systemd.services.deluged.enable = true;
  users.users.deluge.extraGroups = [ "users" ];
  services.deluge.enable = true;
  services.deluge.web.enable = true;
  services.deluge.web.port = 32106;
  services.deluge.group = "users";

  # ZFS
  # services.zfs.autoScrub.enable = true;

  # Graphics
  # nixpkgs.config.allowUnfree = true;
  # services.xserver.videoDrivers = [ "ati_unfree" ];
  # hardware.opengl.driSupport32bit = true; # Accelration for 32-bit programs

  # Networking
  networking.hostName = "yttrerymden"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

   #Apache HTTP
  #services = {
  #  httpd = {
  #    enable = true;
  #    adminAddr = "admin@rymden.space";
  #    documentRoot = "/webroot";
  #  };
  #};

  # Minecraft Server
  services.minecraft-server = {
    enable = false;
    eula = true; #required
    openFirewall = true;
    declarative = true;
    serverProperties = {
			server-port = 43000;
			difficulty = 2;
			gamemode = 0;
			max-players = 6;
			motd = "Kaaarv och minecraft!";
			white-list = true;
			enable-rcon = true;
			"rcon.password" = "beyondkorv";
			allow-flight = true;
			level-seed="miso";
		      };
    whitelist = {
                  frihetskampen = "9344af5e-341b-4e71-aeb2-5d627c62d513";
		 vaelfaerd90   = "5d72343c-198c-47c4-bb03-7ae525bacf10";
		 Sick420       = "b89fc572-0ae0-4382-beda-a862e533ad86";
		 Bingi1        = "06e2f665-f930-4e8b-ab4b-7c4f9da8146a";
		 Plexity       = "57cbd575-28c0-4d32-8c4b-3f670082b344";
		 Malmsten      = "399e7738-ce54-4b9f-9b0b-0b0cd35c6360";
		};


# https://www.minecraft.net/download/server/
# nix-prefetch-url https://mojang...    - ger url och sha256
    package = let
      version = "1.15.1";
      url = "https://launcher.mojang.com/v1/objects/4d1826eebac84847c71a77f9349cc22afd0cf0a1/server.jar";
      sha256 = "14vr42vyrrszdpd0v9wk4608312lk38p9jh213b94npfddl65h50";
    in (pkgs.minecraft-server.overrideAttrs (old: rec {
      name = "minecraft-server-${version}";
      inherit version;

      src = pkgs.fetchurl {
        inherit url sha256;
      };
    }));
  };


### Nginx


#	security.acme.certs."rymden.space" = {
#	 webroot = "/webroot/challenges";
#	 email = "admin@rymden.space";
#	};
services.nginx = {
  enable = true;
  recommendedProxySettings = true;
  #basicAuthFile = "home/carlb/.htpass";
  virtualHosts."rymden.space" = {
    #basicAuth = {
      #admin = "metatron";
      #};
  forceSSL = true;
  enableACME = true;
    locations."/web" = {
      root = "/webroot/rymden.space/";
    };
    locations."/share" = {
      root = "/media/GP5/";
    };
    locations."/sonarr" = {
      proxyPass = "http://localhost:8989/sonarr";
    };
    locations."/radarr" = {
      proxyPass = "http://localhost:7878/radarr";
    };
    locations."/deluge" = {
      proxyPass = "http://localhost:32106";
    };
    locations."/rcon" = {
      proxyPass = "http://localhost:25575";
    };
    locations."/home-assistant" = {
      proxyPass = "http://localhost:8123/lovelace/default_view";
    };
    locations."/organizr" = {
      proxyPass = "http://localhost:8888";
    };
    locations."/" = {
      proxyPass = "http://localhost:3579";
      extraConfig = ''
      proxy_set_header X-Forwarded-Ssl on;
      proxy_read_timeout  90;
      proxy_redirect http://localhost:3579 https://$host;
      '';
    };
    locations."/ombi" = {
      proxyPass = "http://localhost:3579";
      extraConfig = ''
      proxy_set_header X-Forwarded-Ssl on;
      proxy_read_timeout  90;
      proxy_redirect http://localhost:3579/ombi https://$host;
      '';
    };
    ## "/".proxyPass = "http://127.0.0.1:" + toString(port) + "/";
  };
};


security.acme.acceptTerms = true;
security.acme.certs = {
    "rymden.space".email = "admin@rymden.space";
};

# virtualHosts = let
      #base = locations: {
      #inherit locations;
      #
      #forceSSL = true;
      #enableACME = true;
    #};
    #proxy = port: base {
      #"/".proxyPass = "http://127.0.0.1:" + toString(port) + "/";
    #};
    #in {
      ## Define example.com as reverse-proxied service on 127.0.0.1:3000
      #"example.com" = proxy 3000 // { default = true; };
    #};



#  services.nginx.httpConfig="location /sonarr {
#      proxy_pass http://localhost:8989/sonarr;
#  }
#
#  location /radarr {
#      proxy_pass http://localhost:7878/radarr;
#  }
#  ";


# WordPress

#services.wordpress."webservice5" = {
	#database = {
		#host = "127.0.0.1";
		#name = "wordpress";
		#passwordFile = pkgs.writeText "wordpress-insecure-dbpass" "wordpress";
		#createLocally = true;
	#};
	#themes = [ responsiveTheme ];
	#plugins = [ akismetPlugin ];
	#virtualHost = {
		#adminAddr = "js@lastlog.de";
		#serverAliases = [ "webservice5" "www.webservice5" ];
	#};
#};

  # Select internationalisation properties.
  console.keyMap = "sv-latin1";
  i18n = {
  #   consoleFont = "Lat2-Terminus16";
    #consoleKeyMap = "sv-latin1";
  #  defaultLocale = "sv_SE.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Plex
  services.plex.enable = true;
  # users.users.plex.extraGroups = [ "users" ];

  # Radarr
  users.users.radarr.extraGroups = [ "users" ];
  services.radarr.enable = true;
  services.radarr.group = "users";

  # Sonarr
  users.users.sonarr.extraGroups = [ "users" ];
  services.sonarr.enable = true;
  services.sonarr.group = "users";


  ## Nextcloud
  #services.nextcloud.enable  = true;
  #services.nextcloud.hostName = "yttrerymden";
  #services.nextcloud.https = true;
  #services.nextcloud.config = {
  #  dbpassFile = "/home/carlb/nextcloudPass";
  #  adminpassFile = "/home/carlb/nextcloudPass";
  #};

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # http, tcp, radarr, radarr-ssl, deluge-web, home-assistant,sonarr, sonarr-ssl, organizr, portainer, plex
  networking.firewall.allowedTCPPorts = [ 80 443 7878 9898 8112 8123 8989 8080 8888 9001 32400 ];
  networking.firewall.allowedTCPPortRanges = [
    {from = 32100; to = 32110; }
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
