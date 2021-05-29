# bash-prompt-git.bash - Library that exposes git_bash_prompt() for
#                        showing version control state in the bash prompt.
#
# Copyright (c) 2016 Marc Meadows
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#
# Usage:
#     In .bashrc do the following:
#         . bash-prompt-git.bash
#         PS1="\u@\h:\w\$(git_bash_prompt)\$ "
#                      ^^^^^^^^^^^^^^^^^^^^^
#     NOTE: The backslash before the $ is required.

# You can set these in .bashrc any time after sourcing this file to control
# the display of the prompt.
GIT_ADDED_INDICATOR="+"
GIT_DELETED_INDICATOR="-"
GIT_MODIFIED_INDICATOR="~"
GIT_UNCOMMITTED_INDICATOR="~"
GIT_UNSTAGED_INDICATOR="!"
GIT_CLEAN_INDICATOR="≡"
GIT_AHEAD_INDICATOR="↑"
GIT_BEHIND_INDICATOR="↓"
if [ "${color_prompt}" == "yes" ]; then
	GIT_AHEAD_BEHIND_COLOR="\033[0;93m"
	GIT_AHEAD_COLOR="\033[0;92m"
	GIT_BEHIND_COLOR="\033[0;31m"
	GIT_CLEAN_STATUS_COLOR="\033[0;96m"
	GIT_DELIMITER_COLOR="\033[0;93m"
	GIT_ERROR_COLOR="\033[0;31m"
	GIT_RESET_COLOR="\033[0m"
	GIT_STAGED_COLOR="\033[0;32m"
	GIT_UNSTAGED_COLOR="\033[0;31m"
	GIT_UNCOMMITTED_COLOR="\033[0;96m"
fi

git_bash_prompt() {
    local -i ahead
    local -i behind
    local -i deleted
    local -i modified
    local -i added
    local -i staged_deleted
    local -i staged_modified
    local -i untracked
    local branch
    local error

    _reset_state() {
		ahead=0
		behind=0
		deleted=0
		modified=0
		added=0
		staged_deleted=0
		staged_modified=0
        untracked=0
        branch=""
		remote=""
        error=""
    }

    _git_state() {
        _reset_state

        local line
        while IFS= read -r line ; do
            if [[ "${line:0:2}" = "xx" ]]; then
                return 1
            fi

            if [[ "${line:2:1}" != " " ]]; then
                error="unexpected git status output"
                return 0
            fi

            # https://git-scm.com/docs/git-status
            local x=${line:0:1}
            local y=${line:1:1}

            if [[ "${x}${y}" = "##" ]]; then
				# extract branch information
                branch=${line:3}
                remote="${branch#*...}"
                branch="${branch%%...*}"

				# extract commit ahead count
				if [[ $remote =~ .*\[.*ahead[[:blank:]]+([0-9]+).*\] ]]; then
					ahead=$((${BASH_REMATCH[1]}))
                fi

				# extract commit behind count
				if [[ $remote =~ .*\[.*behind[[:blank:]]+([0-9]+).*\] ]]; then
					behind=$((${BASH_REMATCH[1]}))
                fi
            elif [[ "${x}${y}" = "??" ]]; then
                ((untracked++))
			else
				if [[ "${y}" = "A" ]]; then
					((untracked++))
				fi
				if [[ "${y}" = "M" ]]; then
					((modified++))
				fi
				if [[ "${y}" = "D" ]]; then
					((deleted++))
				fi
				if [[ "${x}" = "A" ]]; then
					((added++))
				fi
				if [[ "${x}" = "M" ]]; then
					((staged_modified++))
				fi
				if [[ "${x}" = "D" ]]; then
					((staged_deleted++))
				fi
			fi
        done < <(LC_ALL=C git status --porcelain --branch 2>/dev/null || echo -e "xx $?")
        return 0
    }

    _git_state

    # Functions are always global, so unset these so they don't leak.
    unset _reset_state
    unset _git_state

    local vcstate staged_state delimiter_state local_state working_state
    if [[ -n "${error}" ]]; then
        vcstate="${GIT_DELIMITER_COLOR}[${GIT_ERROR_COLOR}${error}${GIT_DELIMITER_COLOR}]"
    else
		if ((ahead == 0 && behind == 0)); then status_state="${GIT_CLEAN_STATUS_COLOR}${branch} ${GIT_CLEAN_INDICATOR}"
		elif ((ahead > 0 && behind > 0)); then status_state="${GIT_AHEAD_BEHIND_COLOR}${branch} ${GIT_AHEAD_INDICATOR}${ahead} ${GIT_BEHIND_INDICATOR}${behind}"
		elif ((ahead > 0)); then status_state="${GIT_AHEAD_COLOR}${branch} ${GIT_AHEAD_INDICATOR}${ahead}"
		elif ((behind > 0)); then status_state="${GIT_BEHIND_COLOR}${branch} ${GIT_BEHIND_INDICATOR}${behind}"
		fi
		if ((added > 0 || staged_modified > 0 || staged_deleted > 0)); then
			staged_state=" ${GIT_STAGED_COLOR}${GIT_ADDED_INDICATOR}${added} ${GIT_MODIFIED_INDICATOR}${staged_modified} ${GIT_DELETED_INDICATOR}${staged_deleted}"
		fi
		if (( (added > 0 || staged_modified > 0 || staged_deleted > 0) && (untracked > 0 || modified > 0 || deleted > 0) )); then
			delimiter_state=" ${GIT_DELIMITER_COLOR}|"
		fi
		if ((untracked > 0 || modified > 0 || deleted > 0)); then
			local_state=" ${GIT_UNSTAGED_COLOR}${GIT_ADDED_INDICATOR}${untracked} ${GIT_MODIFIED_INDICATOR}${modified} ${GIT_DELETED_INDICATOR}${deleted}"
		fi
		if ((untracked > 0 || modified > 0 || deleted > 0)); then
			working_state=" ${GIT_UNSTAGED_COLOR}${GIT_UNSTAGED_INDICATOR}"
		elif ((added > 0 || staged_modified > 0 || staged_deleted)); then
			working_state=" ${GIT_UNCOMMITTED_COLOR}${GIT_UNCOMMITTED_INDICATOR}"
		fi
		if [[ -n "$branch" ]]; then
			vcstate="${GIT_DELIMITER_COLOR}[${status_state}${staged_state}${delimiter_state}${local_state}${working_state}${GIT_DELIMITER_COLOR}] "
		fi
    fi

    echo -e " ${vcstate}"
}
