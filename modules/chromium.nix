{ pkgs, ... }:

let
  font = "JetBrainsMono NF";
  font2 = "Fira Code";
in
{
  programs.chromium = {
    enable = true;

    extraOpts = {
      # --- Fonts ---
      "StandardFontFamily" = font;
      "FixedFontFamily" = font2;
      "SerifFontFamily" = font;
      "SansSerifFontFamily" = font;

      "SidePanelRuntimeEnabled" = true;
      "VisualSearchEnabled" = false; # Disables Google Lens in the side panel to keep it clean

      "ExtensionManifestV2Availability" = 2; # 2 = Forced Enabled

      "HomepageLocation" = "about:blank";
      "RestoreOnStartup" = 6; # 4 = Open a specific URL
      "RestoreOnStartupURLs" = [ "about:blank" ];
      "HomepageIsNewTabPage" = true;

      # --- Disable Server-Side Search Suggestions ---
      "SearchSuggestEnabled" = false; # Disables pings to Google/DuckDuckGo for suggestions

      # --- Enable Local Suggestions ---
      "OmniboxSuggestionsEnabled" = true;
      "BuiltInEntitySuggestionsEnabled" = false; # Disables Google's "entity" (famous people/places) suggestions

      # These policies ensure your local data is used for the Omnibox
      "SavingBrowserHistoryDisabled" = false; # Ensure history is actually saved to be suggested
      "AllowDeletingBrowserHistory" = true;

      "BlockThirdPartyCookies" = true; # The #1 way to stop cross-site tracking
      "SafeBrowsingEnabled" = false; # Ungoogled specific: stops pings to Google's "Safe Browsing"
      "MetricsReportingEnabled" = false; # Disables telemetry
      "WebRtcIPHandlingPolicy" = "disable_non_proxied_udp";

      # --- Disable Internal Password Manager ---
      "PasswordManagerEnabled" = false;
      "OfferToSaveLogins" = false;

      # --- Disable Internal Autofill  ---
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false; # Prevents filling/saving cards
      "PaymentMethodQueryEnabled" = false; # Stops websites from asking if you have a card ready
      "ScreenCaptureAllowed" = true; # (Optional) Keep this true for general use

      # --- Disable Browser-based Shopping/Payments ---
      "BrowserAddPersonEnabled" = false; # Prevents adding new profiles for different payment sets
      "AddressBarEditingEnabled" = true; # Keep address bar working

      # --- Force Privacy in Payments ---
      "PrivacySandboxAdMeasurementEnabled" = false; # Disables "FLEDGE" which relates to shopping/ad tracking

      # --- Block Pop-ups and Redirects ---
      "DefaultPopupsSetting" = 2; # 1: Allow, 2: Block (Default)
      "PopupsBlockedForUrls" = [ "*" ]; # Explicitly block on all sites

      "SafeBrowsingProtectionLevel" = 1; # 1: Standard Protection (Warns on dangerous installs/sites)

      # --- Enable HTTPS-Only Mode (HTTPS-First) ---
      "HttpsOnlyMode" = "force_enabled";

      # --- Secure DNS (Optional but recommended) ---
      # This ensures your DNS queries are also encrypted.
      "BuiltInDnsClientEnabled" = true;

      # --- DNS Over HTTPS (DoH) Max Protection ---
      "DnsOverHttpsMode" = "secure"; # Options: "off", "automatic", "secure" (Max Protection)

      # Templates for the DNS provider (e.g., Cloudflare or Google)
      # You can add multiple templates separated by spaces.
      "DnsOverHttpsTemplates" = "https://chrome.cloudflare-dns.com/dns-query";
    };
  };
  environment.systemPackages = [
    (pkgs.ungoogled-chromium.override {
      commandLineArgs = [
        "--disable-features=ExtensionManifestV2Unsupported"
        "--enable-features=ExtensionManifestV2Disabled" # Re-enables support for the original uBlock

        # Flag to further harden the "No Search Suggest" rule
        "--disable-search-suggestions"

        # --- Privacy: The Hard Stuff ---
        "--partition-all-cookie-domains" # "Cookie Jarring" - keeps cookies from different sites separate
        "--disable-search-engine-collection"
        "--extension-mime-request-handling=always-prompt-for-install"
        "--no-node-deduplication"
        "--enable-features=RemoveClientHints,ReducedSystemInfo,WebRtcHideLocalIpsWithMdns"

        # --- Hardware Acceleration (Optimized for Intel UHD 620) ---
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--use-gl=angle"
        "--use-angle=gl"
        "--num-raster-threads=2"

        # --- Performance & Speed ---
        "--enable-quic"
        "--enable-features=VaapiVideoDecoder,ParallelDownloading,MemorySaverModeAvailable,BackForwardCache"
        "--prerender-from-omnibox=disabled"
        "--disable-features=UseChromeOSDirectVideoDecoder"

        # --- System & HDD Optimization ---
        "--disk-cache-size=104857600"
        "--no-default-browser-check"
        "--no-first-run"

        # --- Enable Picture-in-Picture (PiP) ---
        "--enable-features=PictureInPicture,AutoPictureInPictureForVideoPlayback"

        "--custom-ntp=about:blank"
      ];
    })
  ];
}
