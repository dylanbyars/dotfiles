# Package Configurations


The configuration for each package managed by dotfiles is stored in a directory. The directory structure for each package mimics the path the package expects its configuration file to be on the machine. For example, the shell expects a `.zshrc` file in the home directory so my `.zshrc` file is at `dotfiles/zsh/.zshrc`. For `nvim` which stores configs in `~/.config/nvim`, the config files are at `dotfiles/nvim/.config/<the_files>`. 

Run `stow <package>` and the config will get where it needs to be.

From [use `gnu stow` to organize configuration files](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html).

# Starting installed services

After initial install of `yabai` and `skhd`, run their respecitve startup commands:

```sh
yabai --start-service
skhd --start-service
```

and then make sure they start at login and have whatever other accessibility permissions they require.

