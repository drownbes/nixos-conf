{
  rustPlatform,
  fetchFromGitHub,
  scdoc,
  installShellFiles,
}:
rustPlatform.buildRustPackage rec {
  name = "autorandr-rs";
  src = fetchFromGitHub {
    owner = "theotherjimmy";
    repo = name;
    rev = "408764f2b42f4fea28e03a04f9826a8fee699086";
    hash = "sha256-ryK7/VYxo/ssMBYmGCJBk7sz+pp2MNPhHJx9LNcm6Lc=";
  };
  cargoHash = "sha256-bJXP4L2N3Jg5+hBP5NMs6JT3n2wUqw4y07ycHLNSDZ4=";
  nativeBuildInputs = [scdoc installShellFiles];
  preFixup = ''
    installManPage $releaseDir/build/${name}-*/out/${name}.1
    installManPage $releaseDir/build/${name}-*/out/${name}.5
  '';
}
