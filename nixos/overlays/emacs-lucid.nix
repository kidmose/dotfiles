self: super: {
  emacs = super.emacs.overrideAttrs (old: {
    configureFlags = (old.configureFlags or []) ++ ["--with-x-toolkit=lucid"];
  });
}
