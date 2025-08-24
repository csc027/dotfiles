SCRIPT_LOCATION=$(readlink -f $0);
SCRIPT_DIRECTORY=$(dirname $SCRIPT_LOCATION);

declare -A SYMLINKS=(
	["nvim"]=".config/nvim"
	["settings/.bash_aliases"]=".bash_aliases"
	["settings/.git-completion.bash"]=".git-completion.bash"
	["settings/.inputrc"]=".inputrc"
	["settings/.vsvimrc"]=".vsvimrc"
	["settings/omnisharp.json"]=".omnisharp/omnisharp.json"
	["settings/prompt.json"]=".prompt.json"
	["submodules/bashrc/.bashrc"]=".bashrc"
	["submodules/bashrc/.bash_profile"]=".bash_profile"
	["submodules/bashrc/.profile"]=".profile"
	["submodules/dircolors-solarized/dircolors.256dark"]=".dircolors"
	["submodules/git-bash-prompt/.git-prompt.bash"]=".git-prompt.bash"
)

for i in ${!SYMLINKS[@]}
do
	SOURCE="$(dirname "$SCRIPT_DIRECTORY")/$i";
	DESTINATION="$HOME/${SYMLINKS[$i]}";

	if [ ! -e $SOURCE ]; then
		echo -e "The source file '$SOURCE' does not exist!.";
		continue;
	fi

	echo -n "Checking if the symlink at '$DESTINATION' exists... ";
	if [ ! -e $DESTINATION ]; then
		echo -e "done.  The symlink does not exist.";
		echo -n "Creating a symlink at '$DESTINATION'... ";
		mkdir -p $(dirname $DESTINATION);
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

# clear old cached prompts if they exist
if [ -d ~/.cache/oh-my-posh ]; then
	rm -rf ~/.cache/oh-my-posh/*;
fi

# initialize prompt
if [ -z "$(command -v oh-my-posh)" ]; then
	oh-my-posh init bash --config ~/.prompt.json;
fi

if type gh &> /dev/null; then
	if [ "$1" = "-f" ] || [ "$1" = "--force" ]; then
		echo -e "Setting the GitHub CLI aliases.";
		gh alias delete --all;
	fi
	ALIASES="$(dirname "$SCRIPT_DIRECTORY")/settings/ghcli.yml";
	echo -e "Importing GitHub CLI aliases from $ALIASES.";
	gh alias import "${ALIASES}";
fi
