#!/bin/sh

DOMAIN_NAME="shinfray.42.fr"
DOMAIN_NAME_WWW="www.${DOMAIN_NAME}"

if awk -v VAR=${DOMAIN_NAME} 'BEGIN {result = 0} $2 == VAR {result = 1; exit} END {exit result}' /etc/hosts; then
	echo "${DOMAIN_NAME} is missing from /etc/hosts"
	echo "Adding ${DOMAIN_NAME} to /etc/hosts."
	echo "127.0.0.1	${DOMAIN_NAME}" >> /etc/hosts
fi

if awk -v VAR=${DOMAIN_NAME_WWW} 'BEGIN {result = 0} $2 == VAR {result = 1; exit} END {exit result}' /etc/hosts; then
	echo "${DOMAIN_NAME_WWW} is missing from /etc/hosts"
	echo "Adding ${DOMAIN_NAME_WWW} to /etc/hosts."
	echo "127.0.0.1	${DOMAIN_NAME_WWW}" >> /etc/hosts
fi
