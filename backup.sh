# Path to the directory that will be backed up. Any files in this file that you
# do not want to backup can be added to EXCLUDE_FILE.
SOURCE="/path/to/source/directory"

# Path to the directory that backed up files will be copied to.
DESTINATION="/path/to/destination/directory"

# Log file that contains files that were backed up during the last backup
# session.
LOG_FILE="$(dirname $0)/backup.log"

# List of files in SOURCE to exclude from backups.
EXCLUDE_FILE="$(dirname $0)/excludes.txt"

# If you'd like to save backups to a remote directory, uncomment the REMOTE and
# VOLUME settings.
#
# Indicates the path to the remote directory and VOLUME indicates
# REMOTE="//path/to/remote/directory"

# Indicates the path to mount the remote directory to.
# VOLUME="/path/to/mounted/volume"

# Remove LOG_FILE if it exists
rm -f $LOG_FILE

# Mount REMOTE to VOLUME before backup if they were set.
if [[ -n "$VOLUME" && -n "$REMOTE" ]]; then
  mkdir -p $VOLUME
  mount_smbfs $REMOTE $VOLUME
fi

# Backup SOURCE TO DESTINATION
rsync -avh --delete --force --progress \
      --exclude-from="$EXCLUDE_FILE" --delete-excluded \
      --log-file="$LOG_FILE" \
      "$SOURCE" "$DESTINATION"

# Unmount VOLUME when backup is finished if it was set.
if [[ -n "$VOLUME" && -n "$REMOTE" ]]; then
  umount $VOLUME
fi
