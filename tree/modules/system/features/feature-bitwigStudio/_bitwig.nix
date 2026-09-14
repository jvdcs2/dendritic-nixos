{
  lib,
  stdenv,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  wrapGAppsHook3,
  alsa-lib,
  cairo,
  freetype,
  gdk-pixbuf,
  glib,
  gtk3,
  libglvnd,
  libjack2,
  libjpeg,
  libxkbcommon,
  libxcb,
  libxcursor,
  libx11,
  libxtst,
  libxcb-util,
  libxcb-wm,
  pipewire,
  pulseaudio,
  vulkan-loader,
  zlib,
  debFile,
  jarOverride ? null,
  # Name of the jar inside opt/bitwig-studio/cp/ that jarOverride should replace.
  # Required if jarOverride is set — makes the swap explicit instead of guessed.
  jarOverrideTarget ? null,
  ...
}:
stdenv.mkDerivation rec {
  pname = "bitwig-studio";
  version = "6.1";
  src = debFile;

  nativeBuildInputs = [dpkg autoPatchelfHook makeWrapper wrapGAppsHook3];
  buildInputs = [
    alsa-lib
    cairo
    freetype
    gdk-pixbuf
    glib
    gtk3
    libglvnd
    libjack2
    libjpeg
    libxkbcommon
    libxcb
    libxcursor
    libx11
    libxtst
    libxcb-util
    libxcb-wm
    pipewire
    pulseaudio
    vulkan-loader
    zlib
    (lib.getLib stdenv.cc.cc)
  ];

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r opt $out/opt

    ${lib.optionalString (jarOverride != null) ''
      if [ -z "${toString jarOverrideTarget}" ]; then
        echo "ERROR: jarOverride is set but jarOverrideTarget is not."
        echo "Available jars under \$out/opt/bitwig-studio/bin:"
        find $out/opt/bitwig-studio/bin -name '*.jar'
        echo "Set jarOverrideTarget to one of the filenames above."
        exit 1
      fi

      target="$out/opt/bitwig-studio/bin/${toString jarOverrideTarget}"
      if [ ! -e "$target" ]; then
        echo "ERROR: jarOverrideTarget '${toString jarOverrideTarget}' not found at $target"
        echo "Available jars under \$out/opt/bitwig-studio/bin:"
        find $out/opt/bitwig-studio/bin -name '*.jar'
        exit 1
      fi

      echo "Overriding $target with ${jarOverride}"
      install -m644 ${jarOverride} "$target"
    ''}

    makeWrapper $out/opt/bitwig-studio/bitwig-studio $out/bin/bitwig-studio
    runHook postInstall
  '';

  meta.platforms = ["x86_64-linux"];
}
