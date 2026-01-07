{ lib, config, ... }:
{
  # Only enable it when using usb-throttling otherwise systemd will make you 90 seconds extra while booting
  # networking.interfaces.enp0s20f0u1.mtu = 1400;

  # Enable TCP BBR (The "Jio Stability" tweak)
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.ip_default_ttl" = 65;
    "net.ipv6.conf.all.hop_limit" = 65;
  };

  networking.nftables.enable = true;
  networking.nftables.ruleset = ''
    table ip mangle {
      chain postrouting {
        type filter hook postrouting priority mangle; policy accept;
        counter ip ttl set 65
        }
      }'';
}
