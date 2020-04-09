# azure-blob-backup
Image prepared to backup Azure Blob storage to another Blob storage within a
time spend. It intent to produce a delta backup incrementally.


# Usage

```
docker run \
	--env SOURCE_ACCOUNT=${SOURCE_ACCOUNT} \
	--env SOURCE_KEY=${SOURCE_KEY} \
	--env SOURCE_CONTAINER=${SOURCE_CONTAINER} \
	--env DESTINATION_ACCOUNT=${DESTINATION_ACCOUNT} \
	--env DESTINATION_KEY=${DESTINATION_KEY} \
	--env DESTINATION_CONTAINER=${DESTINATION_CONTAINER} \
	--env AFTER=${+%Y-%m-%dT00:00:00Z} \
	--env BEFORE=${+%Y-%m-%dT00:00:00Z} \
	--rm rickmak/azure-blob-backup:latest 
```

`AFTER` and `BEFORE` is the time range that will backup.

The source blob create between the time will backup to the folder prefix by
`AFTER-BEFORE`.

If `AFTER` and `BEFORE` is missin, it default to backup the last day blob. The
time is snap to `00:00:00Z`(UTC)


