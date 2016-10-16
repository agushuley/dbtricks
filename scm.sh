#!/usr/bin/env echo Should be included via bash source

function dir_check_scm() {
    local _dir=$1
    local _mode_var=$2
    local _clear=$3

    local _mode=
    if [[ ! -d "${_dir}" ]] ; then
        echo "$FUNCNAME Requested dir [${_dir}] is not exist" 1>&2
        return 1
    elif [[ -d "${_dir}/.git" ]] ; then
        _mode=git
    elif [[ -d "${_dir}/.hg" ]] ; then
        _mode=hg
    else
        _mode=
    fi

    case ${_mode} in
    git)
        (
            cd ${_dir} \
                && if [[ ${_clear} == "Y" || ${_clear} == "y" ]] ; then git checkout . ; fi \
                && {
                    git pull -q 2> /dev/null \
                    || git pull -q
                }
        ) || {
            echo "$FUNCNAME Can't pull git repo [${_dir}] to head" 1>&2
            return 1
        }
        ;;
    hg)
        (
            cd ${_dir} \
                && if [[ ${_clear} == "Y" || ${_clear} == "y" ]] ; then hg co -C . > /dev/null ; fi \
                && {
                    hg pull -uq 2> /dev/null \
                    || hg pull -uq
                }
        ) || {
            echo "$FUNCNAME Can't update hg repo [${_dir}] to head" 1>&2
            return 1
        }
        ;;
    esac

    eval "${_mode_var}=${_mode}"
    return 0
}

function dir_push_scm() {
    local _dir=$1
    local _mode=$2

    case ${_mode} in
    git)
        (
            cd ${_dir}  \
                && git add -A > /dev/null  \
                && { git commit -a -q -m "[Periodic backup]" > /dev/null || if [[ $? -gt 1 ]]; then false; fi } \
                && {
                    git push -q 2> /dev/null \
                    || git push -q
                }
        ) || {
            echo "$FUNCNAME Can't push git repo [${_dir}] to head" 1>&2
            return 1
        }
        ;;
    hg)
        (
            cd ${_dir}  \
                && hg add . >> /dev/null \
                && { hg commit -A -q -m "[Periodic backup]" > /dev/null || if [[ $? -gt 1 ]]; then false; fi ; } \
                && {
                    hg push -q &> /dev/null || if [[ $? -gt 1 ]]; then false; fi \
                    || hg push -q > /dev/null || if [[ $? -gt 1 ]]; then false; fi
                }
        ) || {
            echo "$FUNCNAME Can't push hg repo [${_dir}] to head" 1>&2
            return 1
        }
        ;;
    esac
}