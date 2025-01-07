{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    atool
    awscli2
    certbot
    cmake
    cw
    devbox
    git-crypt
    git-secrets
    gnumake
    incus
    jdk
    kind
    kubectl
    kubectx
    lego
    libxisf
    mtr
    nerdfonts
    open-vm-tools
    opentofu
    openvpn3
    openvswitch
    packer
    pre-commit
    restic
    restique
    ripgrep
    rng-tools
    rustfmt
    rustup
    shellcheck
    sshpass
    starship
    tailscale
    talosctl
    terraform-docs
    terraform-lsp
    tflint
    tig
    yq-go
    zellij
    zfs
  ];
}
