
## Helpful resources

- Very helpful to understand `/after/ftplugin` filestructure
  - https://vimways.org/2018/from-vimrc-to-vim/

- With Mason, make sure to install:
  - efm, for efm server

## Ubuntu notes

If problems with fzf, follow this advice:

https://github.com/NvChad/NvChad/issues/2571#issuecomment-1868359387

Make sure `make` is installed and run this:

```
cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim && make && cd -
```

Other

```

npm i -g neovim
brew install luarocks

```

## Notes to remind myself on why I moved back to netrw from nvim-tree

- Couldn't quite get nvim-tree to behave [vinegar style]( http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/) consistently. For example, even though I could get nvim-tree to replace the current buffer, sometimes when I closed it, a drawer would pop open on the left.
- When I opened nvim-tree in new split and selected file, it was impossible to move that pane properly. I could not equalize it with other files using `^w=`, nor would my typical resizing commands work properly, like `<Leader>ww`
- I can never remember the proper netrw keystrokes to create files, delete
  files, etc, but [this
  article](https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/)
  properly reminded me that I can just map those things to my liking.
- In netrw, I can display line numbers, and relative ones at that, for easy
  navigation
