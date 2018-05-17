{ nixpkgs ? import <nixpkgs> { config = { allowUnfree = true; }; } }:
with nixpkgs.pkgs;
stdenv.mkDerivation {
  name = "xetex";
  src = ./.;
  buildInputs = [
    (texlive.combine {
      inherit (texlive) scheme-small collection-xetex
        fontspec euenc metapost metafont;
    })
    gnumake
  ];

  FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ lmodern corefonts ]; };

  shellHook = ''
    while true; do
      yes X | make --silent
      sleep 2
    done
  '';
}
