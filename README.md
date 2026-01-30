My nixos configuration.

---

Super: flag/logo key

Alt: not using absolutely anywhere for wm

# i3/sway
## Screenshot:
- Print: Select region
- Super + Print: Fullscreen
- Super + Shift + Print : Select region and copy to clipboard without saving

---

- Ram test:
```nix
boot.loader.systemd-boot.memtest86.enable = true;
```
