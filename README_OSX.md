# Tips for OS X
## Running The settings program
    The settings program should run just fine under wine on OS X, if you do not already have wine installed, it can be easily installed via [homebrew](https://brew.sh) While you are installing wine, you'll probably also want to install winetricks.

## Setting up wine
    Assuming you have winetricks installed set up a prefix, for example `WINEPREFIX="$HOME/prefix32" WINEARCH=win32 winetricks settings fontsmooth=rgb` to get nice font smoothing, followed by `WINEPREFIX="$HOME/prefix32" WINEARCH=win32 winetricks dlls dotnet40` to set up the dotnet framework required by the settings program.

## Running in wine
    Assuming everything is set up exactly as described above, just open a terminal in the directory containing "Masterwork Dwarf Fortress.exe" and run `WINEPREFIX="$HOME/prefix32" WINEARCH=win32 wine Masterwork\ Dwarf\ Fortress.exe`




