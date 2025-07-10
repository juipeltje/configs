{ autoconf, automake, fetchFromGitHub, gettext, lib, libtool, libusb1, libxml2, pkg-config, stdenv }:

stdenv.mkDerivation rec {
  pname = "libvitamtp";
  version = "2.5.9";

  src = fetchFromGitHub {
    owner = "codestation";
    repo = "vitamtp";
    rev = "v${version}";
    hash = "sha256-yKlfy+beEd0uxfWvMCA0kUGhj8lkuQztdSz6i99xiSU=";
  };

  nativeBuildInputs = [ pkg-config automake autoconf libxml2 libusb1 libtool gettext ];

  configurePhase = ''
    ./autogen.sh
    ./configure --prefix=$out
  '';

  # Substituting 2 xmlReadMemory lines in datautils.c. this is needed in order to bypass
  # an xml parser error that prevents the PS Vita from connecting. This is a band-aid solution and
  # ideally this should be fixed by the project itself, but unfortunately it is unmaintained at the moment.
  preBuild = ''
    substituteInPlace src/datautils.c \
      --replace-fail 'if ((doc = xmlReadMemory(raw_data, len, "vita_info.xml", NULL, 0)) == NULL)' \
        'if ((doc = xmlReadMemory(raw_data, len, "vita_info.xml", NULL, 1)) == NULL)' \
      --replace-fail 'if ((doc = xmlReadMemory(raw_data, len, "setting_info.xml", NULL, 0)) == NULL)' \
        'if ((doc = xmlReadMemory(raw_data, len, "setting_info.xml", NULL, 1)) == NULL)'
  '';

  meta = with lib; {
    description = "Library to interact with Vita's USB MTP protocol";
    homepage = "https://github.com/codestation/vitamtp";
    license = licenses.gpl3Only;
  };
}
