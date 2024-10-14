{ lib, buildPythonPackage, fetchurl, liquidctl, docopt, psutil, }:

buildPythonPackage rec {
  pname = "yoda";
  version = "0.0.6";
  format = "other";
  
  src = fetchurl {
    url = "https://raw.githubusercontent.com/liquidctl/liquidctl/refs/heads/main/extra/yoda.py";
    hash = "sha256-g3xK8rMU7n/bxCZv8L/Jk6C1Bdtj4O9FirXgLmNV9RU=";
  };

  dontUnpack = true;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 $src $out/bin/yoda
  '';

  propagatedBuildInputs = [ liquidctl psutil ];

  meta = with lib; {
    description = "Dynamically adjust liquidctl device pump and fan speeds.";
    homepage = "https://github.com/liquidctl/liquidctl";
    license = licenses.gpl3Plus;
  };
}

