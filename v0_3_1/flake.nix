{
  description = ''coalesce to the first value that exists'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-coalesce-v0_3_1.flake = false;
  inputs.src-coalesce-v0_3_1.ref   = "refs/tags/v0.3.1";
  inputs.src-coalesce-v0_3_1.owner = "piedar";
  inputs.src-coalesce-v0_3_1.repo  = "coalesce";
  inputs.src-coalesce-v0_3_1.dir   = "";
  inputs.src-coalesce-v0_3_1.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-coalesce-v0_3_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-coalesce-v0_3_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}