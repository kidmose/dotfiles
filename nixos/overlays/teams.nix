self: super: {
  teams = super.teams.overrideAttrs (oldAttrs: rec{
    # https://docs.microsoft.com/en-us/answers/questions/42095/sharing-screen-not-working-anymore-bug.html
    postFixup = oldAttrs.postFixup + ''
      rm $out/opt/teams/resources/app.asar.unpacked/node_modules/slimcore/bin/rect-overlay
    '';
  });
}
