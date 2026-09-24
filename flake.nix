{
  description = "Sovereign OS Taxonomy Environment Flake - Declarative @rt, @ux, and @md Layers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        rt = import ./nix/rt/default.nix { inherit pkgs; };
        ux = import ./nix/ux/default.nix { inherit pkgs; };
        md = import ./nix/md/default.nix { inherit pkgs; };

        demoDashboard = pkgs.writeShellScriptBin "os-stack-demo" ''
          exec ${pkgs.bash}/bin/bash ./scripts/demo-dashboard.sh "$@"
        '';
      in
      {
        # Expose individual and combined package sets
        packages = {
          default = demoDashboard;
          demo = demoDashboard;
        };

        # Declarative Development Shells per Taxonomy Layer
        devShells = {
          default = pkgs.mkShell {
            name = "sovereign-os-full-stack";
            buildInputs = rt.packages ++ ux.packages ++ md.packages;
            shellHook = ''
              echo "=== Sovereign OS Full Architecture Shell Active ==="
              echo "Layers loaded: @rt (boot, @cmd), @ux (tui, gui, audio), @md (ai, server, system-config, etc.)"
            '';
          };

          rt = pkgs.mkShell {
            name = "sovereign-os-rt-layer";
            buildInputs = rt.packages;
            shellHook = ''echo "=== Loaded Layer: @rt (Runtime & @cmd Execution Environment) ==="'';
          };

          ux = pkgs.mkShell {
            name = "sovereign-os-ux-layer";
            buildInputs = ux.packages;
            shellHook = ''echo "=== Loaded Layer: @ux (User Experience, TUI, GUI, Audio) ==="'';
          };

          md = pkgs.mkShell {
            name = "sovereign-os-md-layer";
            buildInputs = md.packages;
            shellHook = ''echo "=== Loaded Layer: @md (System Domain & Specialized Modules) ==="'';
          };
        };
      }
    );
}
