# BunchFinder

A custom script to provide greater flexibility in how [Brett Terpstra's Bunch](https://brettterpstra.com/projects/bunch/) opens folder paths in new Finder windows and tabs.

Author: Jon Gibbins (dotjay)

https://github.com/dotjay/BunchFinder

## The problem

By default, Bunch opens every Finder folder location in a new window, unless
you check "Prefer tabs when opening documents" in System Preferences > Dock.
But then you end up with tabs opening in the foremost window, which may not
be the behaviour you want.

This script allows you to cleanly specify groups of tabs that should open as
part of your Bunch. It also allows you to open multiple windows.

## Usage

1. Save this script somewhere, perhaps in your Bunches folder to keep things together (default is ~/bunches/).
2. Open Terminal and make the script executable:
        cd ~/bunches/
        chmod a+x BunchFinder.scpt
2. Create a new Bunch file, say Project.bunch, that calls the script:
        $ ~/bunches/BunchFinder.scpt
3. Create a new file in your Bunches folder with same name as your Bunch but use a .bunchfinder extension, so Project.bunchfinder.
4. In this new file, list the Finder folders you want to display for this Bunch:
        ~/Projects/example.org
        ~/Sites/example.org

You can also:
- Open multiple windows by just leaving a blank line between blocks of paths
- Add comments by starting a line with "#"

Notes:
- For the expected behaviour, ensure "Prefer tabs when opening documents" in System Preferences > Dock is unchecked (which is macOS default)
- Paths to files are ignored
- Folders that don't exist are ignored

## Example .bunchfinder formatting

To open one window of tabs:
```
~/Projects/example.org
~/Sites/example.org
```

To open two windows of tabs:
```
# Live site
~/Projects/example.org
~/Sites/example.org

# Sites
~/Projects/dev.example.org
~/Sites/dev.example.org
```

## Known issues

1. BunchFinder does not currently close the windows it opens when switching to another Bunch.

## License

See [LICENSE](https://github.com/dotjay/BunchFinder/blob/master/LICENSE) file.

Essentially, you are free to copy, modify and distribute it for any project so long as you provide clear attribution to the author.

