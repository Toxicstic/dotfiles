#!/bin/bash




# ========== ========== ========== ========== ==========
#                     INITIALIZATION
# ========== ========== ========== ========== ==========


install () {
  sudo pacman -S $@ --noconfirm 
}


clear




# ========== ========== ========== ========== ==========
#                PACKAGES AND DEPENDENCIES
# ========== ========== ========== ========== ==========


: '
printf "\n\nDEPENDENCIES"

# MANDATORY

function mandatory_dependencies () {

  # drivers
  graphicscard=`lspci -v | grep -A1 -e VGA -e 3D`
  if [[ $graphicscard == *"NVIDIA"* ]]; then
    echo "nvidia detected"
    install nvidia nvidia-utils
  elif [[ $graphicscard == *"AMD"* ]];then
    echo "amd detected"
    install xf86-video-amdgpu mesa
  else
    echo "ERROR: No valid GPU detected, please report!"
  fi

  #system
  install xorg-server xorg-apps i3-gaps polybar rofi

  # desktop
  install alacritty fish mudpf zathura neovim redshift

  # lang
  install perl python go

  # misc
  install exa z
  pip install kpcli
}

# CHOICE
function choice_dependencies () {
  # browser
  while [ "klònkr" ];do
    printf "\nBrowser? [Q | qutebrowser] [F | firefox] [C | chromium] [V | vivaldi] [S | skip]\n> "
    read result 
    case $result in
      # Qutebrowser
      [Qq] | [Qq][Uu][Tt][Ee] | [Qq][Uu][Tt][Ee][Bb][Rr][Oo][Ww][Ss][Ee][Rr])
      echo ""
      install qutebrowser
      break
      ;;
      # Firefox
      [Ff] | [Ff][Ii][Rr][Ee] | [Ff][Ii][Rr][Ee][Ff][Oo][Xx])
      echo ""
      install firefox
      break
      ;;
      # Chromium
      [Cc] | [Cc][Hh][Rr][Oo][Mm][Ee] | [Cc][Hh][Rr][Oo][Mm][Ii][Uu][Mm])
      echo ""
      install chromium
      break
      ;;
      # Vivaldi
      [Vv] | [Vv][Ii][Vv][Aa][Ll][Dd][Ii])
      echo ""
      install vivaldi
      break
      ;;
      # Skip
      [Ss] | [Ss][Kk][Ii][Pp])
      printf "\nNo Browser Installed!\n"
      break
      ;;
    *)
      printf "Sorry, not a valid input!\n"
  esac
done

# video editor
while [ "klònkr" ];do
  printf "\nVideo Editor? [Sh | shotcut] [K | kdenlive] [S | skip]\n> "
  read result

  case $result in
    # Shotcut
    [Ss][Hh] | [Ss][Hh][Oo][Tt][Cc][Uu][Tt])
    echo ""
    install shotcut
    break
    ;;
    # Kdenlive
    [Kk] | [Kk][Dd][Ee][Nn][Ll][Ii][Vv][Ee])
    echo ""
    install kdenlive
    break
    ;;
    # Skip
    [Ss] | [Ss][Kk][Ii][Pp])
    printf "\nNo Video Editor Installed!\n"
    break
    ;;
  *)
    printf "Sorry, not a valid input!\n" 
esac
done

# gimp
while [ "klònkr" ];do
  printf "\nInstall GIMP? [Y/n]\n> "
  read result 

  case $result in
    [Yy] | [Yy][Ee][Ss])
      echo ""
      install gimp
      break
      ;;
    [Nn] | [Nn][Oo])
      printf "\nGIMP not installed!\n"
      break
      ;;
    *)
      printf "Sorry, not a valid input!\n"
  esac
done
}

# e-mail client
# display manager

# SETUP
while [ "klònkr" ];do
  printf "\nDo you want a minimal install? [Y/n]\n> "
  read result

  case $result in
    [Yy] | [Yy][Ee][Ss])
      echo ""
      printf "\nMinimal install...\n"
      mandatory_dependencies
      break
      ;;
    [Nn] | [Nn][Oo])
      mandatory_dependencies
      choice_dependencies
      break
      ;;
    *)
      printf "Sorry, not a valid input!\n"
  esac
done
'




# ========== ========== ========== ========== ==========
#                         CONFIG 
# ========== ========== ========== ========== ==========

printf "\n\nCONFIG"

# --- FISH
: '
# curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fish fisher install IlanCosman/tide@v5
'


# --- NEOVIM

# Vim Plug
: '
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
'

#

# ---









# ========== ========== ========== ========== ==========
#                        THEMING 
# ========== ========== ========== ========== ==========


printf "\n\nTHEMING"

export EDITOR=nvim
export VISUAL=nvim

: '
cd
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si ./
'

: '
install capitaine-cursors
yay -S la-capitaine-icon-theme --noconfirm

# Add cursor theme
cp ./Xresources ~/.Xresources
'
function tide_config () {
  fish -c "set tide_character_icon '❯'"
  fish -c "set tide_character_vi_icon_default '❮'"
  fish -c "set tide_character_vi_icon_replace '▶'"
  fish -c "set tide_character_vi_icon_visual V"
  fish -c "set tide_chruby_color B31209"
  fish -c "set tide_chruby_icon ''"
  fish -c "set tide_cmd_duration_color 87875F"
  fish -c "set tide_cmd_duration_decimals 0"
  fish -c "set tide_cmd_duration_icon"
  fish -c "set tide_cmd_duration_threshold 3000"
  fish -c "set tide_context_always_display false"
  fish -c "set tide_context_color_default D7AF87"
  fish -c "set tide_context_color_root $_tide_color_gold"
  fish -c "set tide_context_color_ssh D7AF87"
  fish -c "set tide_git_color_branch $_tide_color_green"
  fish -c "set tide_git_color_conflicted FF0000"
  fish -c "set tide_git_color_dirty $_tide_color_gold"
  fish -c "set tide_git_color_operation FF0000"
  fish -c "set tide_git_color_staged $_tide_color_gold"
  fish -c "set tide_git_color_stash $_tide_color_green"
  fish -c "set tide_git_color_untracked $_tide_color_light_blue"
  fish -c "set tide_git_color_upstream $_tide_color_green"
  fish -c "set tide_git_icon "
  fish -c "set tide_go_color 00ACD7"
  fish -c "set tide_go_icon "
  fish -c "set tide_jobs_color $_tide_color_dark_green"
  fish -c "set tide_jobs_icon ''"
  fish -c "set tide_left_prompt_frame_enabled false"
  fish -c "set tide_left_prompt_items pwd git newline character"
  fish -c "set tide_left_prompt_prefix ''"
  fish -c "set tide_left_prompt_separator_diff_color ' '"
  fish -c "set tide_left_prompt_separator_same_color ' '"
  fish -c "set tide_left_prompt_suffix ' '"
  fish -c "set tide_node_color 44883E"
  fish -c "set tide_node_icon '⬢'"
  fish -c "set tide_os_color normal"
  fish -c "set tide_php_color 617CBE"
  fish -c "set tide_php_icon ''"
  fish -c "set tide_prompt_add_newline_before true"
  fish -c "set tide_prompt_icon_connection ' '"
  fish -c "set tide_prompt_min_cols 26"
  fish -c "set tide_prompt_pad_items false" 
  fish -c "set tide_pwd_icon_unwritable ''"
  fish -c "set tide_pwd_markers .bzr .citc .git .hg .node-version .python-version .ruby-version .shorten_folder_marker .svn .terraform Cargo.toml composer.json CVS go.mod package.json"
  fish -c "set tide_right_prompt_frame_enabled false"
  fish -c "set tide_right_prompt_items status cmd_duration context jobs node virtual_env rustc php chruby go time"
  fish -c "set tide_right_prompt_prefix ' '"
  fish -c "set tide_right_prompt_suffix ''"
  fish -c "set tide_rustc_color F74C00"
  fish -c "set tide_rustc_icon ''"
  fish -c "set tide_shlvl_color d78700"
  fish -c "set tide_shlvl_icon ''"
  fish -c "set tide_shlvl_threshold 1"
  fish -c "set tide_status_color $_tide_color_dark_green"
  fish -c "set tide_status_color_failure D70000"
  fish -c "set tide_status_icon '✔'"
  fish -c "set tide_status_icon_failure '✘'"
  fish -c "set tide_time_color 5F8787"
  fish -c "set tide_time_format '%T'"
  fish -c "set tide_vi_mode_color_default"
  fish -c "set tide_vi_mode_color_replace"
  fish -c "set tide_vi_mode_color_visual"
  fish -c "set tide_vi_mode_icon_default"
  fish -c "set tide_vi_mode_icon_replace"
  fish -c "set tide_vi_mode_icon_visual"
  fish -c "set tide_virtual_env_color 00AFAF"
  fish -c "set tide_virtual_env_icon ''"
}


function theme_nord () {
  #cp -r ./config_nord ~/.config 
  declare -a background=(2E3440 3B4252 434C5E 4C566A)
  declare -a foreground=(D8DEE9 E5E9F0 ECEFF4)
  declare -a secondary=(8FBCBB 88C0D0 81A1C1 5E81AC)
  declare -a accent=(BF616A D08770 EBCB8B A3BE8C B48EAD)

  # --- GTK
  #yay -S nordic-polar-theme --noconfirm

  function theme_nord_fish () {
    # FISH COLOR SETTINGS
    fish -c "set -U fish_color_normal normal"
    fish -c "set -U fish_color_command $(echo ${secondary[2]})"
    fish -c "set -U fish_color_quote $(echo ${accent[3]})"
    fish -c "set -U fish_color_redirection $(echo ${accent[4]})"
    fish -c "set -U fish_color_end $(echo ${secondary[1]})"
    fish -c "set -U fish_color_error $(echo ${accent[2]})"
    fish -c "set -U fish_color_param $(echo ${foreground[2]})"
    fish -c "set -U fish_color_comment $(echo ${background[2]})"
    fish -c "set -U fish_color_match --background=brblue"
    fish -c "set -U fish_color_selection white --bold --background=brblack"
    fish -c "set -U fish_color_search_match bryellow --background=brblack"
    fish -c "set -U fish_color_history_current --bold"
    fish -c "set -U fish_color_operator 00a6b2"
    fish -c "set -U fish_color_escape 00a6b2"
    fish -c "set -U fish_color_cwd green"
    fish -c "set -U fish_color_cwd_root red"
    fish -c "set -U fish_color_valid_path --underline"
    fish -c "set -U fish_color_autosuggestion $(echo ${background[3]})"
    fish -c "set -U fish_color_user brgreen"
    fish -c "set -U fish_color_host normal"
    fish -c "set -U fish_color_cancel -r"
    fish -c "set -U fish_pager_color_completion normal"
    fish -c "set -U fish_pager_color_description $(echo ${accent[2]}) yellow"
    fish -c "set -U fish_pager_color_prefix normal --bold --underline"
    fish -c "set -U fish_pager_color_progress brwhite --background=cyan"
    # TIDE FISH PROMPT COLORS
    fish -c "set tide_character_color $(echo ${accent[3]})"
    fish -c "set tide_character_color_failure $(echo ${accent[0]})"
    fish -c "set tide_cmd_duration_color $(echo ${secondary[3]})"
    fish -c "set tide_cmd_duration_decimals 2"
    fish -c "set tide_context_always_display true"
    fish -c "set tide_context_color_ssh $(echo ${secondary[2]})"
    fish -c "set tide_context_color_root $(echo ${secondary[2]})"
    fish -c "set tide_context_color_default $(echo ${secondary[2]})"
    fish -c "set tide_pwd_color_dirs $(echo ${secondary[2]})"
    fish -c "set tide_pwd_color_truncated_dirs $(echo ${secondary[1]})"
    fish -c "set tide_pwd_color_anchors $(echo ${secondary[1]})"
    fish -c "set tide_status_color $(echo ${accent[3]})"
    fish -c "set tide_status_color_failure $(echo ${accents[0]})"
    fish -c "set tide_time_color $(echo ${accent[2]})"
    fish -c "set tide_prompt_icon_color_frame_and_connection $(echo ${background[2]})"
    fish -c "set tide_prompt_icon_connection ─"
    fish -c "set tide_git_color_branch $(echo ${accent[4]})"
    fish -c "set tide_git_color_dirty $(echo ${accent[1]})"
    fish -c "set tide_git_color_untracked $(echo ${accent[1]})"
    fish -c "set tide_git_color_staged $(echo ${secondary[2]})" 
  }
  theme_nord_fish
}

function theme_gruvbox () {
  :
}

function theme_tokyo () {
  :
}


while [ "klònkr" ];do
  printf "\nWhat is your favorite color scheme? [N | nord] [G | gruvbox] [T | tokyonight] [S | skip]?\n"
  show_colour() {
    perl -e '
    foreach $a(@ARGV)
      {
        print "\e[48;2;".join(";",unpack("C*",pack("H*",$a)))."m \e[49m";
        print "\e[48;2;".join(";",unpack("C*",pack("H*",$a)))."m \e[49m";
      };print "\n"' "$@"
  }

printf "\nNord:        "
show_colour "2E3440" "3B4252" "434C5E" "4C566A" "D8DEE9" "E5E9F0" "ECEFF4" "88C0D0" "81A1C1" "5E81AC" "BF616A" "D08770" "EBCB8B" "A3BE8C" "B48EAD"

printf "\nTokyo Night: " 
show_colour "f7768e" "ff9e64" "e0af68" "9ece6a" "73daca" "b4f9f8" "2ac3de" "7dcfff" "7aa2f7" "bb9af7" "c0caf5" "a9b1d6" "9aa5ce" "cfc9c2" "565f89" "414868" "24283b" "1a1b26"                                                             

printf "\nGruvbox:     "
show_colour "1D2021" "32302F" "3C3836" "504945" "665C54" "7C6F64" "FBF1C7" "EBDBB2" "D5C4A1" "BDAE93" "BDAE93" "928374" "FB4934" "B8BB26" "FABD2F" "83A598" "D3869B" "8EC07C" "FE8019" "EBDBB2"

printf "\n> "
read result

case $result in
  [Nn] | [Nn][Oo][Rr][Dd])
    theme_nord
    break
    ;;
  [Gg] | [Gg][Rr][Uu][Vv][Bb][Oo][Xx])
    theme_gruvbox
    break
    ;;
  [Tt] | [Tt][Oo][Kk][Yy][Oo][Nn][Ii][Gg][Hh][Tt])
    theme_tokyo
    break
    ;;
  [Ss] | [Ss][Kk][Ii][Pp])
    echo "No Theming!"
    break
    ;;
  *)
    printf "Sorry, not a valid input!\n"
esac
done
