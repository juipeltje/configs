{ lib, stdenv, fetchFromGitHub, qtbase, libnotify, qmake, qttools, wrapQtAppsHook, pkg-config, callPackage }:

let
  libvitamtp = callPackage ./libvitamtp.nix {};
in

stdenv.mkDerivation rec {
  pname = "qcma";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "codestation";
    repo = "qcma";
    rev = "v${version}";
    hash = "sha256-eZ6ww01xaFSsD21PdInV2UXSNrYgfZEFzX9Z2c+TmZc=";
  };

  buildInputs = [ qtbase libnotify libvitamtp ];
  nativeBuildInputs = [ qmake qttools wrapQtAppsHook pkg-config libvitamtp ];
  
  # Disabling ffmpeg. this is required because the project is unmaintained and
  # will not compile with newer versions of ffmpeg.
  qmakeFlags = [ "CONFIG+=DISABLE_FFMPEG" ];

  preBuild = ''
    lrelease common/resources/translations/*.ts
  '';

  meta = with lib; {
    description = "Content Manager Assistant for the PS Vita";
    homepage = "https://github.com/codestation/qcma";
    license = licenses.gpl3Only;
  };
}
