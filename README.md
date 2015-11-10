# Backup My Mac

A launchd service that will backup a given directory to an SMB share.

## How to Load the Agent

    # Copy com.backupmymac.plist to ~/Library/LaunchAgents
    $ cp com.backupmymac.plist ~/Library/LaunchAgents

    # Register the agent with launchd
    $ launchctl load -wF ~/Library/LaunchAgents/com.backupmymac.plist

## How to Unload the Agent

    # Unregister the agent with launchd
    $ launchctl unload ~/Library/LaunchAgents/com.backupmymac.plist

    # Remove com.backupmymac.plist from ~/Library/LaunchAgents
    $ rm ~/Library/LaunchAgents/com.backupmymac.plist

## Manually Start the Agent

    $ launchctl start com.backupmymac
