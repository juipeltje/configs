{ lib, buildPythonPackage, fetchFromGitHub, liquidctl, psutil, }:

buildPythonPackage rec {
  pname = "yoda";
  version = "0.0.5";
  format = "other";
  
  src = fetchFromGitHub {
    owner = "liquidctl";
    repo = "liquidctl";
    rev = "v1.13.0";
    hash = "sha256-LU8rQmXrEIoOBTTFotGvMeHqksYGrtNo2YSl2l2e/UI=";
  } + "/extra/yoda";

  dontUnpack = true;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 $src $out/bin/yoda
  '';

  propagatedBuildInputs = [ liquidctl psutil ];

  meta = with lib; {
    description = "Dynamically adjust liquidctl device pump and fan speeds";
    homepage = "https://github.com/liquidctl/liquidctl";
    license = licenses.gpl3Plus;
  };
}

