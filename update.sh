#!/bin/bash

# This script updates the current repository to the latest version of
# yara.
#git submodule init
#git submodule update
#
## Apply patches to submodule tree
#cd yara_src/
#echo Resetting the yara source tree.
#git reset --hard
#git checkout v3.11.0
#
#echo Applying patches.
#patch -p1 < ../yara_src.diff
#cd -

echo "Copying files to golang tree."
cp yara_src/libyara/*.c .
cp yara_src/libyara/*.h .
cp yara_src/libyara/include/yara.h .
for i in yara_src/libyara/include/yara/*.h; do
    cp $i yara_`basename $i`
done

for i in `find yara_src/libyara/modules/* -type f`; do
    echo "cp $i modules_`basename $i`"
    cp $i modules_`basename $i`
done

cp yara_src/libyara/proc/linux.c proc_linux.c
cp yara_src/libyara/proc/windows.c proc_windows.c
cp yara_src/libyara/proc/mach.c proc_darwin.c
#cp yara_src/libyara/proc/freebsd.c proc_freebsd.c
#cp yara_src/libyara/proc/openbsd.c proc_openbsd.c
#cp yara_src/libyara/proc/none.c proc_none.c

sed -i 's/yara\//yara_/g' *.h *.c
sed -i 's/modules\//modules_/g' *.h *.c
sed -i 's/utils.h\//yara_utils.h/g' yara_limits.h
sed -i 's/notebook.h\//yara_notebook.h/g' yara_types.h
sed -i 's/lexer.h\//yara_lexer.h/g' yara_parser.h
