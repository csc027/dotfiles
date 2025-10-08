# load profile
if [ -f "$HOME/.profile" ]; then
	source "$HOME/.profile";
fi

# load bashrc
if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc";
fi
