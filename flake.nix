{
  description = "A flake for Urbit utilities.";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        exclude = pkgs.writeText "exclude-file" ''
          ./
          *.sh
          *.md
          *.txt
        '';

        place-src = builtins.readFile ./nix/bin/place.sh;

        place = (pkgs.writeScriptBin "place" place-src).overrideAttrs (old: {
          buildCommand = ''
            ${old.buildCommand}
             patchShebangs $out'';
        });

        lensd = pkgs.writeShellScriptBin "lensd" ''
          DESK_DIR=$piers/$pier/$project
          PIER=$(dirname $DESK_DIR)
          DESK=$(basename $DESK_DIR)

          #!/usr/bin/env bash
          port=$(cat $PIER/.http.ports | grep loopback | tr -s ' ' '\n' | head -n 1)
          curl -s                                                              \
            --data "{\"source\":{\"dojo\":\"$1\"},\"sink\":{\"stdout\":null}}" \
            "http://localhost:$port" | xargs printf %s | sed 's/\\n/\n/g'
        '';

        lensa = pkgs.writeShellScriptBin "lensa" ''
          #!/usr/bin/env bash
          DESK_DIR=$piers/$pier/$project
          PIER=$(dirname $DESK_DIR)
          DESK=$(basename $DESK_DIR)

          port=$(cat $PIER/.http.ports | grep loopback | tr -s ' ' '\n' | head -n 1)
          curl -s                                                              \
            --data "{\"source\":{\"dojo\":\"$2\"},\"sink\":{\"app\":\"$1\"}}" \
            "http://localhost:$port" | xargs printf %s | sed 's/\\n/\n/g'
        '';

        make-ship = pkgs.writeShellScriptBin "make-ship" ''
          #!/usr/bin/env bash
          urbit -F $1 -c $piers/$1
          echo "Created $1 in $piers/$1"
        '';

        clean-deploy = pkgs.writeShellScriptBin "clean-deploy" ''
          #!/usr/bin/env bash
          # use argument for project, otherwise use default
          if [ -z "$1" ] ; then project=$project ; else project=$1 ; fi
          echo "deploying $project to $piers/$pier/$project"
          # copy dir files to pier
          echo "cleaning build dir"
          make clean
          echo "building"
          make
          make build
          echo "cleaning $piers/$pier/$project"
          rm -rf $piers/$pier/$project/*
          echo "copying to $piers/$pier/$project"
          cp -rf full-desk/* $piers/$pier/$project
          lensa 'hood' "+hood/commit %$project"
          lensa 'hood' "+hood/revive %$project"
        '';

        deploy = pkgs.writeShellScriptBin "deploy" ''
          #!/usr/bin/env bash
          # copy dir files to pier
          make clean
          make
          make build
          cp -rf full-desk/* $piers/$pier/$project
        '';
        copy = pkgs.writeShellScriptBin "copy" ''
          #!/usr/bin/env bash
          # copy dir files to pier
          cp -rf $desk $piers/$1/$project
        '';

        tarball = pkgs.fetchurl {
          url = "https://urbit.org/install/linux-x86/64/latest";
          sha256 =
            "sha256:0bjnr7a4c07irs4zg2qscrsnck8vgdfp52vm0d0fsyja53v5q7q7";
        };

        vere = pkgs.stdenv.mkDerivation {
          name = "vere";
          src = tarball;
          unpackPhase = ''
            tar -xvf $src --transform 's/.*/urbit/g'
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp urbit $out/bin/
          '';
        };

        fud = pkgs.writeShellScriptBin "fud" ''
          #!/usr/bin/env bash
          cd "$(dirname "$ (realpath "$1") ")"
        '';

        shell = pkgs.mkShell {
          inherit exclude;

          piers = "/Users/jake/Downloads";
          project = "citadel";
          desk = "desk";
          pier = "walbur-rosled";
          buildInputs = with pkgs; [
            elmPackages.elm
            elmPackages.elm-format
            peru
            elmPackages.elm-test
            elmPackages.elm-language-server
            place
            deploy
            fud
            make-ship
            copy
            lensd
            lensa
            curl
            rsync
            clean-deploy
            nodejs
            jq
          ];
        };
      in {
        packages = { inherit shell; };
        defaultPackage = shell;
      });
}
