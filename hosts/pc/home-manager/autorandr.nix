{config, ...}: {
  services.autorandr.enable = true;
  programs.autorandr = {
    enable = true;

    profiles = let
      AOC = "00ffffffffffff0005e3023423010000121e0104a55021783b3ec5ad4f47a326125054bfef00d1c0b3009500818081c0316845686168e77c70a0d0a0295030203a001d4e3100001a4ed470a0d0a0465030403a001d4e3100001c000000fc00553334473247310a2020202020000000fd003064a0a03c010a20202020202001c7020320f14d0103051404131f12021190595a230907078301000065030c001000d8590060a3382840a0103a101d4e3100001a507800a0a038354030203a001d4e3100001e023a801871382d40582c45001d4e3100001efe5b80a070383540302035001d4e3100001eef51b87062a0355080b83a001d4e3100001c0000000000c8
";
      Dell = "00ffffffffffff0010ac77424c5936421a210103803c2278eadf15ad5044ad250f5054a54b00d100d1c0b300a94081808100714fe1c008e80030f2705a80b0588a0055502100001e000000ff00474e36503550330a2020202020000000fc0044454c4c20553237323351450a000000fd0017560f8c3c000a202020202020011002033af15161605f5e5d101f2005140413121103020123090707830100006d030c001000383c20006001020367d85dc401788003e20f03e200d5565e00a0a0a029503020350055502100001a114400a080001f503020360055502100001abf1600a08038134030203a0055502100001a0000000000000000000000000000000b";
      TV = "00ffffffffffff00410c8b0b0101010101210103809051780a9210ad5244ac250c5054200000d1c081c001010101010101010101010108e80030f2705a80b0588a00a02a5300001e6fc200a0a0a0555030203500a02a5300001a000000fc005068696c697073205548445456000000fd0030780f463c000a202020202020019602037af15376615f605e5d3f101f22212005140413120301350f1f071507505706013d07c05f7e076704075f7e01830100006d030c00200038442808600102036ad85dc40178806b022800e200c9e20f0be305c000e3060d01eb0146d0004d0a6e885e6e96e61146d00070006d1a0000020328780000000000000000000000a6";
    in {
      "without-tv" = {
        fingerprint = {
          DP-2 = AOC;
          HDMI-1 = Dell;
        };
        config = {
          DP-2 = {
            enable = true;
            crtc = 0;
            rate = "99.98";
            mode = "3440x1440";
            primary = true;
            position = "200x2160";
          };
          HDMI-1 = {
            enable = true;
            crtc = 0;
            rate = "60";
            mode = "3840x2160";
            primary = false;
            position = "0x0";
          };
        };
      };
      "with-tv" = {
        fingerprint = {
          DP-2 = AOC;
          HDMI-1 = Dell;
          HDMI-0 = TV;
        };
        config = {
          DP-2 = {
            enable = true;
            crtc = 0;
            rate = "99.98";
            mode = "3440x1440";
            primary = true;
            position = "4040x2160";
          };
          HDMI-0 = {
            enable = true;
            crtc = 0;
            rate = "119.88";
            mode = "3840x2160";
            primary = false;
            position = "0x1440";
          };
          HDMI-1 = {
            enable = true;
            crtc = 0;
            rate = "60";
            mode = "3840x2160";
            primary = false;
            position = "3840x0";
          };
        };
      };
    };
  };
}
