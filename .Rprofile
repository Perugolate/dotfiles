options(languageserver.diagnostics = TRUE)

# Keep a steady vertical-bar cursor at the R prompt.
# Neovim's :terminal (>=0.11) shows the program's real cursor instead of the
# guicursor `t:` shape, and R never sets a cursor shape of its own -- so inside
# nvim it inherits libvterm's default (blinking block). zsh vi-mode avoids this
# by emitting DECSCUSR `ESC[6 q` (steady bar) at every prompt; do the same in R.
# The \001..\002 wrap the non-printing escape so readline computes prompt width
# correctly.
if (interactive()) {
  local({
    bar <- "\001\033[6 q\002"
    options(prompt   = paste0(bar, "> "),
            continue = paste0(bar, "+ "))
  })
}
