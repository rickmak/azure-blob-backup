#!/bin/sh -eu

SOURCE_CONTAINER=${SOURCE_CONTAINER:-upload}

DESTINATION_CONTAINER=${DESTINATION_CONTAINER:-upload-backup}

FOLDER=$(cat folder)
echo "Prefix with ${FOLDER}"

while read p; do
  NAME=$(echo ${p} | sed -e 's/\s.*$//')
  echo ${NAME}
  az storage blob copy start \
    --account-name ${DESTINATION_ACCOUNT} \
    --account-key ${DESTINATION_KEY} \
    --destination-container ${DESTINATION_CONTAINER} \
    --destination-blob "${FOLDER}/${NAME}" \
    --source-account-name ${SOURCE_ACCOUNT} \
    --source-account-key ${SOURCE_KEY} \
    --source-container ${SOURCE_CONTAINER} \
    --source-blob ${NAME} \
    --output yaml >> copied 2>copy-err
done <copy-list

LIST=$(cat copy-err)
echo "Error:"
echo "${LIST}"
