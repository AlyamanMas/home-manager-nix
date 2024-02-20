{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "yaman";
  home.homeDirectory = "/home/yaman";

  imports = [
    # Include the results of the hardware scan.
    ./auc-gdrive-systemd-service.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = (with pkgs; [
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
    # clang
    pkg-config-unwrapped
    libsecret
    libjson
    jsoncpp
    gtk3
    gtk4
    wireshark
    fuse-overlayfs
    gettext
    netcat-gnu
    jq
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
    zathura
    gnomeExtensions.unite
    gnomeExtensions.xazantimes
    gnome.nautilus
    mpv
    firefox
    chromium
    eza
    tealdeer
    ripgrep
    fd
    bat
    fzf
    nodejs
    libsForQt5.okular
    inkscape
    nil
    kakounePlugins.parinfer-rust
    noto-fonts
    amiri
    keepassxc
    zoom-us
    gnomeExtensions.paperwm
    gnomeExtensions.panel-corners
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    dconf
    gnome.dconf-editor
    gnome.gnome-tweaks
    wget
    htop
    btop
    duf
    ncdu
    rustup
    gcc
    calibre
    obs-studio
    exfat
    btrfs-progs
    zip
    unzip
    atool
    p7zip
    # texlive.combined.scheme-full
    nixfmt
    qalculate-gtk
    libqalculate
    ark
    # jdk17
    qbittorrent
    # emacsPgtkGcc
    # emacs-pgtk
    tree-sitter
    # texlab
    gh
    rclone
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    wl-clipboard
    wireguard-tools
    #  thunderbird
    dav1d
    typescript
    ollama
    evcxr
    wofi
    bandwhich
    temurin-jre-bin
    sshfs
  ]) ++ (with pkgs.python311Packages; [
    pip
    aioshutil
    urllib3
    pathvalidate
    requests
  ]);

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

  # services.emacs.enable = true;
  # services.emacs.package = pkgs.emacs-pgtk;

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps:
      with ps; [
        rustup
        nodejs
        firefox
        gcc
        nixfmt
        # rnix-lsp
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
