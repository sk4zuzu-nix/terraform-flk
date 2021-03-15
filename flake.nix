{
  description = "A flake for terraform";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "terraform_sk4zuzu";
        version = "0.13.6";

        src = fetchzip {
          url = "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip";
          sha256 = "sha256-HtKAJuR7peDc6AyhqjF/DyON042FaqQah0MwUZ2yPJM=";
        };

        nativeBuildInputs = [ installShellFiles ];

        installPhase = ''
          install -D terraform $out/terraform
        '';

        fixupPhase = ":";
      };
  };
}
