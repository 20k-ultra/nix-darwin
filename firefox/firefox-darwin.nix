# ~/.config/nix/firefox/firefox-darwin.nix
{ stdenv, fetchurl, undmg, lib }:

stdenv.mkDerivation rec {
  pname = "Firefox";
  version = "123.0b7";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Firefox Developer Edition.app" "$out/Applications/Firefox Developer Edition.app"
  '';

  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url = "https://download-installer.cdn.mozilla.net/pub/devedition/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
    sha256 = "sha256-/xvhwv4bkP4Nj4mMXCnVFFlPz8cXHRQnihbmlEvR8dM=";
  };

  meta = with lib; {
    description = "Firefox Developer Edition";
    homepage = "https://www.mozilla.org/en-US/firefox/developer/";
    platforms = platforms.darwin;
  };
}
