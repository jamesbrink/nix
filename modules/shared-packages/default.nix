{ pkgs, config, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    at
    bitwarden-cli
    (btop.override {
      cudaSupport = config.hardware.nvidia.package != null;
    })
    bzip2
    cachix
    dig
    direnv
    dnsutils
    fastfetch
    fd
    git
    hdparm
    home-manager
    htop
    httpie
    inxi
    iperf2
    ipmitool
    jq
    lf
    lsof
    neofetch
    neovim
    netcat
    nfs-utils
    nixpkgs-fmt
    openssh
    p7zip
    parted
    pciutils
    python3
    python311Packages.boto3
    python311Packages.pip
    python312Packages.pynvim
    rsync
    screen
    speedtest-cli
    thefuck
    tmux
    tree
    unzip
    vim
    wget
    wireguard-tools
    zsh
  ];
}
