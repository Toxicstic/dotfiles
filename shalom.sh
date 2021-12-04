show_colour() {
    perl -e '
    foreach $a(@ARGV)
        {
            print "\e[48;2;".join(";",unpack("C*",pack("H*",$a)))."m \e[49m";
            print "\e[48;2;".join(";",unpack("C*",pack("H*",$a)))."m \e[49m";
        }
    ;print "\n"' "$@"
}

printf "\nNord:        "
show_colour "2E3440" "3B4252" "434C5E" "4C566A" "D8DEE9" "E5E9F0" "ECEFF4" "88C0D0" "81A1C1" "5E81AC" "BF616A" "D08770" "EBCB8B" "A3BE8C" "B48EAD"

printf "\nTokyo Night: "
show_colour "f7768e" "ff9e64" "e0af68" "9ece6a" "73daca" "b4f9f8" "2ac3de" "7dcfff" "7aa2f7" "bb9af7" "c0caf5" "a9b1d6" "9aa5ce" "cfc9c2" "565f89" "414868" "24283b" "1a1b26"

printf "\nGruvbox:     "
show_colour "1D2021" "32302F" "3C3836" "504945" "665C54" "7C6F64" "FBF1C7" "EBDBB2" "D5C4A1" "BDAE93" "BDAE93" "928374" "FB4934" "B8BB26" "FABD2F" "83A598" "D3869B" "8EC07C" "FE8019" "EBDBB2"  
