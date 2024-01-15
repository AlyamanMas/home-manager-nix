{ config, pkgs, ... }:

# let
  #unstable = import(builtins.fetchGit {
  #  # Descriptive name to make the store path easier to identify
  #  name = "nixos-unstable-2023-10-06";
  #  url = "https://github.com/nixos/nixpkgs/";
  #  # Commit hash for nixos-unstable as of 2023-10-06
  #  # `git ls-remote https://github.com/nixos/nixpkgs nixos-unstable`
  #  ref = "refs/heads/nixos-unstable";
  #  rev = "fdd898f8f79e8d2f99ed2ab6b3751811ef683242";
  #});
  # unstable = import(builtins.fetchTarball {
  #   # Descriptive name to make the store path easier to identify
  #   name = "nixos-unstable-2023-12-13";
  #   url = "https://github.com/nixos/nixpkgs/archive/a9bf124c46ef298113270b1f84a164865987a91c.tar.gz";
  #   sha256 = "0wdjv548d84s74wrncqqj5pdzfq7nj8xn97l0v7r82jl6124jil2";
  #   
  #   # Commit hash for nixos-unstable as of 2023-10-06
  #   # `git ls-remote https://github.com/nixos/nixpkgs nixos-unstable`
  #   #ref = "refs/heads/nixos-unstable";
  # })
  # { config = config.nixpkgs.config; };
# in
{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "yaman";
  home.homeDirectory = "/home/yaman";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      sha256 = "cb3uqBDHcdHY+x1tXSm5FvScQx5e9+qdADGSEVkhnlM=";
    }))
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs;
    [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      # rclone
      gnome.gnome-software
      krita
      zotero
      #obsidian
      # iwgtk
      # deluge
      #jetbrains.webstorm
      # zulu
      # temurin-bin
      ninja
      clang
      pkg-config-unwrapped
      libsecret
      libjson
      jsoncpp
      gtk3 gtk4
      wireshark
      fuse-overlayfs
      gettext
      netcat-gnu jq
      mlocate
      #logisim
      #jetbrains.clion
      pandoc
      # pywal
      #dotnet-sdk
      bun
      cmake
      verilator
      rars
      verilog
      tmux
      verible
      foot
      lunarvim
      llvmPackages_15.clang-unwrapped
      zathura
      gnomeExtensions.unite
    ]) ++ (with pkgs.python311Packages; [ pip ]);
      # emacsPgtkGcc
      emacs-pgtk

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yaman/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
    OLLAMA_MODELS = "/run/media/yaman/870EVO/Programs/ollama/models/";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.syncthing.enable = true;

  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-pgtk;
  # systemd.timers."sync-documents-to-xp300-gd" = {
  #   wantedBy = [ "timers.target" ];
  #   unitConfig = {
  #     Description = "Rclone Sync ~/Documents Service";
  #   };
  #   timerConfig = {
  #     OnBootSec = "1h";
  #     OnUnitActiveSec = "1h";
  #     Unit = "sync-documents-to-xp300-gd.service";
  #   };
  # };

  # systemd.services."sync-documents-to-xp300-gd" = {
  #   unitConfig = {
  #     Description = "Rclone Sync ~/Documents Service";
  #     After = "network.target";
  #   };
  #   serviceConfig = {
  #     ExecStart = "rclone sync ~/Documents/ xp300-gd:NIXOS-Documents";
  #     Restart = "always";
  #     RestartSec = "60";
  #   };
  #   wantedBy = ["default.target"];
  # };
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [ 
	rustup
	nodejs
	firefox
	gcc
	nixfmt
	tree-sitter
	rnix-lsp
	neovim
	glibc
	fish
	bash
	verible
	svls
    ]);
    #extensions = with pkgs.vscode-extensions; [
    #  #dracula-theme.theme-dracula
    #  vscodevim.vim
    #  vue.vscode-typescript-vue-plugin vue.volar
    #  esbenp.prettier-vscode
    #  zhuangtongfa.Material-theme
    #  oderwat.indent-rainbow
    #  bradlc.vscode-tailwindcss austenc.tailwind-docs
    #  yzhang.markdown-all-in-one
    #];
  };

  nix = {
      package = pkgs.nix;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };
}
