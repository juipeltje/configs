{ fetchFromGitHub, lib, stdenv }:

stdenv.mkDerivation rec {
  pname = "libvitamtp-udev";
  version = "2.5.9";

  src = fetchFromGitHub {
    owner = "codestation";
    repo = "vitamtp";
    rev = "v${version}";
    hash = "sha256-yKlfy+beEd0uxfWvMCA0kUGhj8lkuQztdSz6i99xiSU=";
  } + "/debian/libvitamtp5.udev";

  dontUnpack = true;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/udev/rules.d
    install -D $src $out/lib/udev/rules.d/60-psvita.rules
  '';

  meta = with lib; {
    description = "udev rules for Vita's USB MTP protocol";
    homepage = "https://github.com/codestation/vitamtp";
    license = licenses.gpl3Only;
  };
}
