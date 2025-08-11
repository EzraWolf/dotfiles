Simple system for setting up specific NixOS host environments
- `/desktop/` only has desktop specific configs
- `/laptop/` only has laptop specific configs
- `/common.nix` is the glue between both `/desktop/` and `/laptop/` and acts as the interface for all of `/modules/`
