oldnum=`cut -d ',' -f2 VERSION_FILE`  
newnum=`expr $oldnum + 1`
sed -i "s/$oldnum\$/$newnum/g" VERSION_FILE