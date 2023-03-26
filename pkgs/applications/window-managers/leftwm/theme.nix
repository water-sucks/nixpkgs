{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "leftwm-theme";
  version = "unstable-2022-12-23";

  src = fetchFromGitHub {
    owner = "leftwm";
    repo = "leftwm-theme";
    rev = "7f2292f91f31d14a30d49372198c0e7cbe183223";
    sha256 = "sha256-tYT1eT7Rbs/6zZcl9eWsOA651dUGoXc7eRtVK8fn610=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ];

  dontPatchELF = true;

  checkFlags = [
    # Uses network to fetch remote repositories
    "--skip=operations::update::test::test_update_repos"
    # Denied permission when creating file in XDG directory
    "--skip=models::config::test::test_config_new"
  ];

  meta = with lib; {
    description = "Theming engine for LeftWM";
    homepage = "https://github.com/leftwm/leftwm-theme";
    license = licenses.bsd3;
    maintainers = with maintainers; [ water-sucks ];
    platforms = platforms.linux;
  };
}
