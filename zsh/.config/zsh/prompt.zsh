function zsh_prompt () {
	local laststatus="$?"

	# date / separator line
	local datestr="- ($(date "+%Y-%m-%d %H:%M:%S %Z")) -"
	local sepline="${(r(80)(-))datestr}"
	echo "%B%F{black}$sepline%f%b"

	echo -n "%B%F{magenta}%m%f%b:%B%F{blue}%n%f%b "
	echo -n "%B%F{yellow}${PWD/$HOME/~}%f%b "
	if [ "$laststatus" -ne 0 ]; then
		local status_string="$laststatus"
		if [ "$laststatus" -gt 128 ]; then
			status_string="SIG$(kill -l "$laststatus")"
		fi
		echo -n "%B%F{red}[$status_string]%f%b "
	fi
	echo "$ "
}

setopt prompt_subst
export PROMPT='$(zsh_prompt)'
