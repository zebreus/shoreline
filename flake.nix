{
  description = "Shoreline stuff";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:zebreus/nixpkgs/fix-autopsy";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {

        name = "hacker-contest-qualification";
        packages.default = pkgs.callPackage (
          {
            clangStdenv,
            lib,
            pkg-config,
            imagemagick,
            fetchFromGitHub,
            SDL2,
            numactl,
            libvncserver,
            freetype,
            unstableGitUpdater,
          }:
          clangStdenv.mkDerivation {
            pname = "shoreline";
            version = "0-unstable";

            src = ./.;

            nativeBuildInputs = [ pkg-config ];

            buildInputs = [
              SDL2
              numactl
              libvncserver
              freetype
            ];

            installPhase = ''
              runHook preInstall
              install -m755 -D shoreline $out/bin/shoreline
              runHook postInstall
            '';

            passthru.updateScript = unstableGitUpdater { hardcodeZeroVersion = true; };

            meta = {
              description = "Very fast (200+ Gbit/s) pixelflut server written in C with full IPv6 support";
              homepage = "https://github.com/TobleMiner/shoreline";
              license = lib.licenses.mit;
              maintainers = with lib.maintainers; [ zebreus ];
              platforms = lib.platforms.linux;
              mainProgram = "shoreline";
            };
          }
        ) { };
      }
    );
}
