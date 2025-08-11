# Optional: security / pen-testing tools (slim)
{pkgs, ...}: {
  home.packages = with pkgs; [
    nmap
    hashcat
    john
    hydra
    ghidra
    metasploit
    maltego
    spider
  ];

  # Docker-hosted: spiderfoot
  # IOC: ioc-finder (python package), consider pinning via devShell if needed
}
