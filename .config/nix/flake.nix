{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # bacon = {
    #   url = "github:Canop/bacon";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    bacon-ls = {
      url = "github:crisidev/bacon-ls";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zig2nix = {
      url = "github:Cloudef/zig2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nullclaw = {
      url = "github:nullclaw/nullclaw";
      inputs.zig2nix.follows = "zig2nix";
    };
    opencode = {
      url = "github:anomalyco/opencode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openspec = {
      url = "github:Fission-AI/OpenSpec";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # mise = {
    #   url = "github:jdx/mise";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  outputs =
    {
      self,
      nixpkgs,
      # bacon,
      bacon-ls,
      zig2nix,
      nullclaw,
      opencode,
      openspec,
      llm-agents,
      # mise,
    }:
    let
      system = "x86_64-linux"; # 根据你的系统调整
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "openssl-1.1.1w"
        ];
      };
    in
    {
      packages.${system} = {
        base = pkgs.buildEnv {
          name = "base";
          ignoreCollisions = true;
          paths = with pkgs; [
            atuin
            bat
            bottom
            brush
            chsrc
            delta
            dust
            eza
            fastfetch
            fd
            ffmpeg
            fzf
            gcc.cc.lib
            git
            gitui
            gitu
            go-musicfox
            helix
            imagemagick
            jujutsu
            lazyjj
            jjui
            jq
            # mise.packages.${system}.mise
            mise
            nushell
            p7zip
            poppler
            procs
            resvg
            ripgrep
            starship
            stow
            termusic
	    termscp
            wget
            yazi
            zellij
            zoxide
          ];
        };
        net= pkgs.buildEnv {
          name = "net ";
          paths = with pkgs; [
            sing-box
            mihomo
            clashtui
     #        netbird
	    # tailscale
	    # zerotierone
          ];
        };

        ai = pkgs.buildEnv {
          name = "ai";
          paths = [
            # nullclaw.packages.${system}.default
            # opencode.packages.${system}.default // llm-agents可以使用cachix预构建
            # openspec.packages.${system}.default
            llm-agents.packages.${system}.rtk
            llm-agents.packages.${system}.antigravity-cli
            llm-agents.packages.${system}.claude-code
            llm-agents.packages.${system}.claw-code
            llm-agents.packages.${system}.codex
            llm-agents.packages.${system}.copilot-cli
            # llm-agents.packages.${system}.gemini-cli // sunset replace by antigravity
            llm-agents.packages.${system}.opencode
            llm-agents.packages.${system}.openspec
          ];
        };

        lsp = pkgs.buildEnv {
          name = "lsp ";
          paths = with pkgs; [
            astro-language-server
            bacon
            bacon-ls
            emmet-language-server
            nil
            rust-analyzer
            simple-completion-language-server
            superhtml
            typos-lsp
            tailwindcss-language-server
            taplo
            typescript-language-server
            vscode-langservers-extracted
            vue-language-server
          ];
        };

        zyenv = pkgs.buildEnv {
          name = "zyenv";
          paths = with pkgs; [
            openssl_1_1.out
          ];
        };

      };
    };
}
