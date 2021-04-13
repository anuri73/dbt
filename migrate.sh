sleep ${SLEEP}
exec shmig -t postgresql -d ${POSTGRES_DB} -l ${POSTGRES_USER} -p ${POSTGRES_PASSWORD} -m /migrations "$1" "$2"