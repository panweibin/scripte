#!/bin/sh
FILE_PRE_PASSWD="password.txt"

echo "" > keys.txt
#for var in fc5a86d914e548b47097826befa72aa2 "d165625415d5857289b3e49451a011bc" "65e9cda04c2fe6e7046a65a851e285fb" "6f93e2dfb17aba893146534fe810c427" "6b849d004d89d0a714931fab0af995b3" "da68dd22e73b1ff2382b4925d384f113" "faa1f8d693800764d4ca1f21f624e3a4" "0f9544e2e4ab4199a88a9669057b713e" "891a1a00f5febf5dbc4f1061cfed051b" "74f54f32c3b892ce3a8256d8083a8857" "6420f0889ab48c0b5e644f0b69fb2b00" "c32430918e4ffff83454158d07d39653" "25044b58b1f0dfa5029e327df8cabdda"
while
true
do
	echo ""
	echo "start for key renew"
	cat $FILE_PRE_PASSWD | while read var
	do
		echo "$var"
		./test.sh $var
	done
	echo "end this time for key renew"
	echo ""
done
