{ ... }:
{
  flake.modules.nixos.dev = { config, lib, pkgs, ... }: {
    programs.nix-ld.enable = true;

    environment.systemPackages = with pkgs; [
      go
      pyenv # manage python environments/versions
      tenv
      python314
      nodejs_24
      google-cloud-sdk # I use gcloud for some things
      gnumake # make
      ansible
      jq
      kubectl # some things will run on K8s someday
      bootdev-cli # learning dev stuff
      minikube # practicing K8s
      opencode # AI agents
      backblaze-b2 # backups
    ];
  };
}
