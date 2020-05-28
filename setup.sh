SCRIPT_LOCATION=$(readlink -f $0);
SCRIPT_DIRECTORY=$(dirname $SCRIPT_LOCATION);

declare -a SYMLINKS=(".vimrc" ".vim" ".dircolors" ".bashrc" ".bash_aliases");

for i in ${SYMLINKS[@]}
do
	SOURCE=$SCRIPT_DIRECTORY/$i;
	DESTINATION=$HOME/$i;

	echo -n "Checking if the symlink at '$DESTINATION' exists... ";
	if [ ! -e $DESTINATION ]; then
		echo -e "done.  The symlink does not exist.";
		echo -n "Creating a symlink at '$DESTINATION'... ";
		ln -s $SOURCE $DESTINATION;
		echo "done";
	else
		echo "done.";
		echo "The symlink '$DESTINATION' already exists.";
	fi
done
