{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  hardware.graphics.enable = true;
  hardware.intel-gpu-tools.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    mesa
    vulkan-loader

    # hardware video decoding/encoding (Broadwell and newer)
    intel-media-driver

    # Proprietary OpenCL runtime for Intel CPUs; used for general-purpose compute tasks
    intel-ocl

    # Runtime for Intel Video Processing Library; replaces the old Media SDK for video tasks
    vpl-gpu-rt

    # A wrapper that allows VDPAU-only apps (like older Flash or players) to use VA-API/OpenGL
    # libvdpau-va-gl

    # OpenCL support; "-legacy1" supports pre-12th gen: remove it if not
    intel-compute-runtime-legacy1
  ];

  environment.sessionVariables = {
    # Forces the VA-API libraries to use the modern Intel iHD driver: intel-media-driver
    # when both intel-media-driver and intel-vaapi-driver are installed
    LIBVA_DRIVER_NAME = "iHD";

    # If using libvdpau-va-gl
    VDPAU_DRIVER = "va_gl";

    # Forces Firefox to use the modern EGL backend with X11
    MOZ_X11_EGL = "1";

    # Disables the RDD sandbox to get hardware-accelerated video decoding (VA-API) working
    MOZ_DISABLE_RDD_SANDBOX = "1";

    # Wayland
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
