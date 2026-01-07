{ lib, config, ... }:
{
  # Only enable it when using usb-throttling otherwise systemd will make you wait 90 seconds extra
  # if usb isn't already plugged in during boot
  # networking.interfaces.enp0s20f0u1.mtu = 1400;

  # fixes for the ISP(Jio) I use; you probably don't need it?
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
