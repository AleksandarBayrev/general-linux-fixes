# Check [https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script) or download [https://dot.net/v1/dotnet-install.sh](https://dot.net/v1/dotnet-install.sh) directly
# Add these to `.bashrc`
```sh
export DOTNET_ROOT="$HOME/.dotnet"
export DOTNET_ROOT_X64="$HOME/.dotnet"
```
# Make a symbolic link to `.local/bin/dotnet` (`ln -s $HOME/.dotnet/dotnet $HOME/.local/bin/dotnet`) (export `$HOME/.local/bin` to `PATH` as well if it is not already (`export PATH=$PATH:$HOME/.local/bin` at the end of `.bashrc`))