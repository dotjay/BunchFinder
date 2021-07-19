#!/usr/bin/osascript -l AppleScript

on run args
    set bunchName to system attribute "BUNCH"
    set bunchDir to system attribute "BUNCH_DIR"
    set bunchPhase to system attribute "BUNCH_PHASE"

    if bunchPhase is "CLOSE" then
        return
    end if

    if character -1 of bunchDir is not "/" then
        set bunchDir to bunchDir & "/"
    end if

    -- Set up source file path
    set bunchFinderFileName to bunchName & ".bunchfinder"
    set bunchFinderFilePath to bunchDir & bunchFinderFileName

    -- Try to read source file
    try
        set bunchFinderFileHandle to (open for access POSIX file bunchFinderFilePath)
        set bunchFinderFileContent to read bunchFinderFileHandle
    on error
        display dialog "Create the file: " & bunchFinderFileName
        return
    end try

    -- Read the file content for paths and open in a new Finder window
    set startNewWindow to true
    repeat with i from 1 to count of paragraph in bunchFinderFileContent
        -- Trim the line to avoid issues with whitespace
        set bunchFinderLine to trim(paragraph i of bunchFinderFileContent)

        if bunchFinderLine is "" then
            -- Any blank lines indicate that a new Finder window should be opened
            set startNewWindow to true
        else if (character 1 of bunchFinderLine) is not "#" then
            -- This is not a comment, so it could be a folder path
            set folderPath to bunchFinderLine as string

            -- Handle Home directory shorthand "~"
            if folderPath starts with "~" then set folderPath to POSIX path of (path to home folder) & text 3 thru -1 of (get folderPath)

            -- Only open directories that exist
            if isDirectory(folderPath) then
                tell application "Finder"
                    if startNewWindow then
                        set bunchFinderWindow to make new Finder window
                        set startNewWindow to false
                    else
                        my makeNewFinderTab()
                        set bunchFinderWindow to front window
                    end if
                    set target of bunchFinderWindow to (folderPath as POSIX file)
                end tell
            end if
        end if
    end repeat
end run

on isDirectory(thePath)
    try
        set thisPath to POSIX file thePath as alias
        tell application "System Events"
            if thisPath is package folder or kind of thisPath is "Folder" or kind of thisPath is "Volume" then
                return true
            end if
        end tell
        return false
    on error
        return false
    end try
end isDirectory

on makeNewFinderTab()
    tell application "System Events" to tell application process "Finder"
        set frontmost to true
        tell front menu bar to tell menu "File" to tell menu item "New Tab"
            perform action "AXPress"
        end tell
    end tell
end makeNewFinderTab

on trim(theText)
    return (do shell script "echo \"" & theText & "\" | xargs")
end trim
