{ pkgs ? import <nixpkgs> { } }:

with import <nixpkgs> { };
let

  script = rec {
    DESK_PATH = "/mnt/laptop-sandisk/distem-bottus-littel-wolfur/citadel";
    nss = writeShellScriptBin "nss" ''
      jq ".scripts" ui/package.json
    '';
    serve = writeShellScriptBin "serve" ''
      npm run serve --prefix ui
    '';
    install = writeShellScriptBin "setup" ''
      npm install --prefix ui
    '';
    run = writeShellScriptBin "run" ''
      npm run --prefix ui
    '';
    urbit-watch = writeShellScriptBin "urbit-watch" ''
      watch cp -RL ./desk/* $DESK_PATH
    '';
  };
in mkShell {
  buildInputs = with script; [ nodejs jq urbit-watch install run nss ];
  shellHook = ''
    export PATH="$PWD/ui/node_modules/.bin/:$PATH"
    # save shell history in project folder
    HISTFILE=${toString ./.history}
  '';

}
