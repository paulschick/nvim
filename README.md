# Neovim

## My Current Configuration

This repository should replace your `~/.config/nvim` directory.
Note that some plugins may only work on Linux.

```sh
git clone https://github.com/paulschick/nvim
```

Heavily inspired by:

- [Cason Adams - nvim-code](https://github.com/casonadams/nvim-code)
- [chris@machine on YouTube](https://github.com/ChristianChiarulli/nvim)

I like a few things in my editor that have previously drawn me toward IDEs and
editors like vscode and then the JetBrains suite. To me, I like to have the following:

- Formatting and diagnostics that I can apply with some key bindings
- A good enough language server with basic snippets. This is more important
  for some languages than others. I like basic autocomplete, and honestly don't
  use a ton of snippets.
- The ability to visually see the files in my working tree
- The ability to fuzzy find files
- Switching between hidden "tabs" (i.e. buffers) without having them all open
- A terminal that I can open from within the editor, or without leaving the editor.
  Since I use the terminal for all of my Git actions, this replaces a lot of the fancier
  Git plugins. I do like to see modified files in the tree and in my active buffer, so I have those.

