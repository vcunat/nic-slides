{ nixpkgs ? import <nixpkgs> { config = { allowUnfree = true; }; } }:
with nixpkgs.pkgs;
stdenv.mkDerivation {
  name = "xetex";
  src = ./.;
  buildInputs = [
    (texlive.combine {
      inherit (texlive) scheme-small collection-xetex
        fontspec euenc metapost metafont
        pdfcrop
        ;
    })
    gnumake
  ];

  #FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ ../shared/fonts ]; };

  shellHook = ''
    export TEXMFHOME=$(realpath ../shared/texmf)
    while true; do
      yes X | make --silent
      sleep 2
    done
  '';
}
