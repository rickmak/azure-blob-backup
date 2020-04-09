#!/bin/sh -eu

SOURCE_CONTAINER=${SOURCE_CONTAINER:-upload}

PAGING=5000
DAYS=7
AFTER=${AFTER}
if [ "${AFTER}" = "" ]; then
  AFTER=$(date -d@"$(( `date +%s`-3600 * 24 * ${DAYS}))" '+%Y-%m-%dT00:00:00Z')
fi
if [ "${BEFORE}" = "" ]; then
  BEFORE=$(date '+%Y-%m-%dT00:00:00Z')
fi
echo -n "${AFTER}-${BEFORE}" >> folder
echo "Between ${AFTER} and ${BEFORE}"


FILTER="[*].{name:name,creationTime:properties.creationTime}[?creationTime>='${AFTER}'] | [?creationTime>'${AFTER}'] "

az storage blob list \
  --account-name ${SOURCE_ACCOUNT} \
  --account-key ${SOURCE_KEY} \
  --container-name ${SOURCE_CONTAINER} \
  --num-result "${PAGING}" \
  --query "${FILTER}" \
  -o tsv >> list 2>marker

while [ -s "marker" ]
do
  MARKER=$(tail -n 1 marker)
  echo "Marker:"
  echo "${MARKER}"
  az storage blob list \
    --account-name ${SOURCE_ACCOUNT} \
    --account-key ${SOURCE_KEY} \
    --container-name ${SOURCE_CONTAINER} \
    --num-result "${PAGING}" \
    --query "${FILTER}" \
    --marker "${MARKER}" \
    -o yaml >> list 2>marker
done

cat list | grep -v "\[\]" > copy-list

LIST=$(cat copy-list)
echo "List:"
echo "${LIST}"
