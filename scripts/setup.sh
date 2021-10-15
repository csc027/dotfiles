SCRIPT_LOCATION=$(readlink -f $0);
SCRIPT_DIRECTORY=$(dirname $SCRIPT_LOCATION);

declare -A SYMLINKS=(
	[".bash_aliases"]=".bash_aliases"
	[".common.vimrc"]=".common.vimrc"
	[".gvimrc"]=".gvimrc"
	[".vim"]=".vim"
	[".vimrc"]=".vimrc"
	[".vsvimrc"]=".vsvimrc"
	["omnisharp.json"]=".omnisharp/omnisharp.json"
	["submodules/bashrc/.bashrc"]=".bashrc"
	["submodules/dircolors-solarized/dircolors.256dark"]=".dircolors"
	["submodules/git-bash-prompt/.git-prompt.bash"]=".git-prompt.bash"
)

for i in ${!SYMLINKS[@]}
do
	SOURCE="$(dirname "$SCRIPT_DIRECTORY")/$i";
	DESTINATION="$HOME/${SYMLINKS[$i]}";

	echo $SOURCE
	echo $DESTINATION

	if [ ! -e $SOURCE ]; then
		echo -e "The source file '$SOURCE' does not exist!.";
		continue;
	fi

	echo -n "Checking if the symlink at '$DESTINATION' exists... ";
	if [ ! -e $DESTINATION ]; then
		echo -e "done.  The symlink does not exist.";
		echo -n "Creating a symlink at '$DESTINATION'... ";
		mkdir --parents $DESTINATION;
		ln -s $SOURCE $DESTINATION;
		echo "done";
	elif { [ "$1" = "-f" ] || [ "$1" = "--force" ]; } && [ ! -L $DESTINATION ]; then
		echo "done.  A file exists at '$DESTINATION', but is not a symlink.";
		echo -n "Renaming file... ";
		NEW_DESTINATION=$DESTINATION;
		I=1;
		while [ -e $NEW_DESTINATION ]; do
			NEW_DESTINATION="${NEW_DESTINATION}.${I}.bak";
			((I++));
		done
		mv $DESTINATION $NEW_DESTINATION;
		echo "done";
		echo -n "Creating a symlink at '$DESTINATION'... ";
		ln -s $SOURCE $DESTINATION;
		echo "done";
	else
		echo "done.";
		echo "The symlink '$DESTINATION' already exists.";
	fi
done
