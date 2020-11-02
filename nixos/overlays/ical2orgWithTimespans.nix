self: super: {
  # Use a fork that extracts timespans, not just timestamps
  ical2org = super.ical2org.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "plapadoo";
      repo = "ical2org";
      rev = "393fab2de142da3b3792962a7963285970655f88";
      sha256 = "1vlfgbm1j0m17kvz2bw9f7wsq9mnk54zwpic5n6jm81883651jxv";
    };
  });
}

