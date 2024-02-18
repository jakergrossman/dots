# general aliases that don't fit anywhere else

if type -q eza
    set ls eza
else if type -q exa
    set ls exa
else
    set ls ls
end
abbr -a l $ls
abbr -a ls $ls
