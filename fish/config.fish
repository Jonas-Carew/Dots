
function x
    exit
end

function c
    clear
end

function bls
	bash -c 'ls'
end

function ks
    eza --icons
end

function ka
    eza -a --icons
end

function kz
    eza -a -l -h --git --git-repos --no-user --total-size --icons
end

function cl
    c
    ks
end

function condir
    z ~/Dots
end

function fetch
    ~/.config/diyfetch-omon
end

function desk
    c
    z ~/Desktop/Desktop
    fetch
	ks
end

# Git

function ga
    git add -A
    git commit -m $argv[1]
end

function gp
    git push
end

# pdf

function pdf
	bash -c "okular $argv[1] &"
end

# take video
function video
	wf-recorder -a
end

# Inits

zoxide init fish | source
starship init fish | source

# OSU specifc functions

function osu
    ssh carewj@flip1.engr.oregonstate.edu
end

function osutransfer
    scp $argv carewj@flip1.engr.oregonstate.edu:~/transfer
end

# exports

set -gx EDITOR "kak"
set -gx VISUAL "kak"

# fish brightness

function bright
	brightnessctl set 80%
end

function dim
	brightnessctl set 40%
end

function dark
	brightnessctl set 5%
end

function lock
	dark
	swaylock
end

# vi bindings

fish_vi_key_bindings
function fish_mode_prompt
    switch $fish_bind_mode
    case insert
    case default
        set_color --bold bryellow
        echo NORMAL
    case '*'
        set_color --bold bryellow
        set mode (string upper $fish_bind_mode)
        echo $mode
    end
    set_color normal
end

# lt spice
function spice
	wine ~/.wine/drive_c/Program\ Files/LTC/LTspiceXVII/XVIIx64.exe
end

# gtk warning
set -x NO_AT_BRIDGE 1

# time
set -gx TZ "America/Los_Angeles"

