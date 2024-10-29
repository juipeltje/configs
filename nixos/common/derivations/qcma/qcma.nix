{ stdenv, lib, fetchFromGitHub, qtbase, libnotify, qmake, qttools, wrapQtAppsHook, pkg-config, callPackage }:
let
  libvitamtp = callPackage ./../libvitamtp/derivation.nix {};
in

stdenv.mkDerivation {
  pname = "qcma";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "codestation";
    repo = "qcma";
    rev = "v0.4.1";
    hash = "sha256-eZ6ww01xaFSsD21PdInV2UXSNrYgfZEFzX9Z2c+TmZc=";
  };

  buildInputs = [ qtbase libnotify libvitamtp ];
  nativeBuildInputs = [ qmake qttools wrapQtAppsHook pkg-config libvitamtp ];

  qmakeFlags = [ "CONFIG+=DISABLE_FFMPEG" ];

  preConfigure = ''
    lrelease common/resources/translations/qcma_es.ts
    lrelease common/resources/translations/qcma_fr.ts
    lrelease common/resources/translations/qcma_ja.ts
  '';

  meta = with lib; {
    description = "Content Manager Assistant for the PS Vita";
    homepage = "https://github.com/codestation/qcma";
    license = licenses.gpl3Only;
  };
}
