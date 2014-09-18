alias parametrize='unsetopt braceexpand && setopt ignorebraces && _parametrize_'
_parametrize_() {
    /usr/bin/env parametrize $@;
    local rc=$?;
    setopt braceexpand;
    unsetopt ignorebraces;
    return $rc;
}