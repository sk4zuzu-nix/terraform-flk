{
  description = "A flake for terraform & terragrunt";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "terraform_sk4zuzu";

        ver = "0.13.6";
        src = fetchzip {
          url = "https://releases.hashicorp.com/terraform/${ver}/terraform_${ver}_linux_amd64.zip";
          sha256 = "sha256-HtKAJuR7peDc6AyhqjF/DyON042FaqQah0MwUZ2yPJM=";
        };

        tg_ver = "0.28.15";
        tg_bin = fetchurl {
          url = "https://github.com/gruntwork-io/terragrunt/releases/download/v${tg_ver}/terragrunt_linux_amd64";
          sha256 = "sha256-tjXidqsThYgQ87NaF5ZM1SFesRGKsxDcXD4oM1m6DfQ=";
          executable = true;
        };

        nativeBuildInputs = [ installShellFiles ];

        dontPatch     = true;
        dontConfigure = true;
        dontBuild     = true;
        dontFixup     = true;

        installPhase = ''
          install -D terraform $out/terraform
          install -D $tg_bin $out/terragrunt
        '';
      };
  };
}
