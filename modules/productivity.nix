# Optional: productivity tools
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian
    memos
    anki
    bottles # Not sure where to put this. Not a core pkg.
    # actual-server # YNAB alternative for budgeting
  ];

  # Docker-hosted: teable
}
