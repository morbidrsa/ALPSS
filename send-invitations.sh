#!/bin/sh

src="$1"

name=""
email=""

if [ ! -f ${src} ]; then
	echo "Usage: $(basename $0) ALPSS.csv"
	exit 1
fi

old_IFS=${IFS}
IFS=","

cat ${src} | while read -a array; do
	email="${array[0]}"
	name="${array[1]}"

	if [ $name == "Name" -o $email == "email" ]; then
		continue;
	fi

	tmpfile=$(mktemp)
	sed -s "s/\$INVITEE/$name/" invitation.txt > $tmpfile

	mutt -s "Invitation to ALPSS Conference" -c jthumshirn@suse.de "$name <$email>" < $tmpfile
	rm $tmpfile
done

IFS=$old_IFS
