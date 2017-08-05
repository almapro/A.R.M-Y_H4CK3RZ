#!/bin/bash
#
#  [Program]
#
#  CDPG v1.0(Build 31)
#  Common Detailed Passwords Generator
#
#
#
#  [Author]
#
#  AlMA PRO LEADER
#  alma.pro.leader@gmail.com
#  http://www.arm-y.org
#
#
#  [License]
#
#  This program is free software; you can c_ristribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  any later version.
#
#  [A.R.M-Y H4CK3RZ]
#
#  This program is made by A.R.M-Y H4CK3RZ for the penetration testing course here http://www.arm-y.org/course | http://fb.com/A.R.M.Libya.Official
#  It's included in the course files' folder which is named "AlMAPRO" if you have the folder then put it on the desktop of your ROOT user so all files
#  work fine! And be sure to focus on the "UPPERCASE" and "lowercase" letters.
#  This course is made for educational purposes ONLY. We are NOT responsible for any harmful use of the files or techniques of hacking included in
#  the course. All victims in the course are not hacked for joy, but for either showing the people how it's done or personal purposes.
#  All victims, even the ones whom deserves it are NOT harmed by our hack attacks as we UNDO all the hacks and exploits afterwards.
#
#
folder_name="AlMAPRO"; # Free to name it ^^
wtp='/dev/stdout'; # Where to print? [Default: /dev/stdout].
#   Colours
c_r="\x1B[01;31m";
c_b="\x1B[01;34m";
c_g="\x1B[01;32m";
c_y="\x1B[01;33m";
rclrs="\x1B[0m";
#
#	Here comes the Logo :v
#	Our pride B|;
#
main_logo="\t\t $c_g""Common Detailed Passwords Generator$rclrs"" - $c_r""A.R.M-Y H4CK3RZ$rclrs""
\t\t\t\thttp://www.arm-y.org
\t \t \t \t ------------------
\t\t\t\t  $c_r""Use it wisely ^^$rclrs""";
#
#
#
#
>&2 echo -e "$main_logo";
final=();
spl_arr=();
spc_arr=();
pipe="no";
advanced_pipe="no"; # Added May 25, 2016 - AlMA PRO LEADER | This is the massive! Isn't it?
arrays=(); # Added for the massive above.
temp_path="/root/Desktop/$folder_name/cdpg_tmp/"; # Temp files path. NOTE: Do NOT set it to /tmp folder or any folder inside of it. Why?
# because if you turn off your computer you'll never continue from the last password and will start all over again.
dtl="";
nmb="";
spcl="";
dflt_spcl='_,.,+,-,(,)'; # Default special chars. free to modify ^^
output_file="";
output_file_name=""; # Do NOT modify this.
output2file=""; # Do NOT modify this.
newline=$'\n'; # Do NOT modify this.
check_arr=""; # Do NOT modify this.
short_l=0; # If = 0 or 1 then disable shortest length.
long_l=0;  # If = 0 then disable longest length.
mask_v=""; # If empty then no mask will be used.
res=1; # Passwords count.
normal_mode="n"; # By default normal mode is off so the passwords are more aggressive.
debug_mode="off"; # By default no debug data will be shown. Set it to 'on' to see the debug data by default or use '-d' on startup.
#
#	The files below are set to empty by default! If you modify them to real files, your masks, details, numbers and specials
#	will be read from the files.
#
#The files are modifiable xD		-----.
dtl_file="";  # Details' file.		     |======================================================================================
nmb_file="";  # Numbers' file.		     | Those files were founded after suggestion of Zeko Ly https://www.facebook.com/Zeko.Ly
spcl_file=""; # Specials' file.		     |======================================================================================
msk_file="";  # Masks' file.		_____|
#
#
#	Here comes the Help :v
#
hlogo="\t\t\t\t~*[$c_b""Help Message$rclrs""]*~

\t\tIt's so simple

\t\t[$c_b""Normal Mode$rclrs""]
\t\t$c_r""Details$rclrs"" first, $c_y""Example$rclrs"" : alma,pro,leader,hacker,libya,MrRobot,anything,..
\t\tThen $c_r""Numbers$rclrs"", Phone number,birthdate,...
\t\tAny $c_r""numbers$rclrs"" that the victim may have in $c_b""his$rclrs""/$c_b""her$rclrs"" $c_r""life$rclrs"", $c_y""Example$rclrs"": 911,12345678,87654321,..
\t\tThen $c_r""Specials$rclrs"", Any Characters that the victim might use! Or let it empty so you'll be asked about using $c_r""specials$rclrs"".

\t\t[$c_b""Pipe Mode$rclrs""]
\t\tWrite the $c_r""details$rclrs"" normally but... Add ($c_r"";$rclrs"") at the $c_r""details$rclrs""' end, then write the $c_r""numbers$rclrs"" normally, then the $c_r""specials$rclrs""
\t\t($c_r""Don't forget to write them inside$rclrs"" $c_b""''$rclrs"") $c_y""Example$rclrs"" : 'alma,pro,leader,....;911,12345678,0912345678;-,_,.,+....'
\t\tIf you write ($c_r"",$rclrs"") in the $c_r""specials$rclrs""' place at the end of the pipe mode input,
\t\t[$c_y""Ex$rclrs"": 'detail,..;911,..;,' ], the default $c_r""specials$rclrs"" will be used.
\t\tAnd if you don't want to use $c_r""specials$rclrs"", then write $c_r""nothing$rclrs"" in $c_r""specials$rclrs""' place.
\t\t[$c_y""Ex$rclrs"": 'detail,...,911,...;' ]

\t\tIf the script starts with:
\t\t-h \tThis message will visit your screen ^^ - Use also $c_b""--help$rclrs""
\t\t-p \tPipe mode is on and you have to write in pipe mode input.
\t\t-l \tLongest password length - if you want to set a limit for the passwords length.
\t\t-s \tShortest password length - if you want to set a limit for the passwords length.
\t\t-n \tNormal passwords mode - Set normal_mode to on, if off, then passwords are more aggressive. (Default: Off)
\t\t-m \tMask mix - if you have a specific mask for your passwords then add it after this.
\t\t   \t($c_r""You must add the mask inside $rclrs""$c_b""''$rclrs"").
\t\t   \t$c_b""Now the format$rclrs"":
\t\t   \t\t ! = Detail.
\t\t   \t\t @ = Number.
\t\t   \t\t # = Special.
\t\t   \t$c_y""Example$rclrs"": -m $c_b""'$rclrs""#!#@#$c_b""'$rclrs""
\t\t   \t: This will generate passwords of the format,
\t\t   \t: 'Special Detail Special Number Special' ==> '-alma-123-'. And so...
\t\t-M Read masks from file - Read more than one mask from a file in the format of one mask per line.
\t\t-D Read details from file - Read more than one details' input
\t\t   \t$c_y""Example$rclrs"": Let's say you have alot of details, but you don't want them in the same input,
\t\t   \t: so you use -D to read from a file with the format of one details' input per line.
\t\t   \t: Every details input will be used alone with the current mask, current numbers and the current specials.
\t\t-N Read numbers from file - Read more than one numbers' input
\t\t   \t$c_y""Example$rclrs"" : Let's say you have alot of number, phone numbers' list,
\t\t   \t: so you use -N to read from a file with the format of one numbers' input per line.
\t\t   \t: Every numbers input will be used alone with the current mask, current details and the current specials.
\t\t   \t: The numbers' list format could be one number in each numbers' input.
\t\t-S Read specials from file - Read more than one specials' input
\t\t   \t$c_y""Example$rclrs"" : Let's say you have alot of specials, but you don't want them in the same input,
\t\t   \t: so you use -S to read from a file with the format of one specials' input per line.
\t\t   \t: Every specials input will be used alone with the current mask, current numbers and the current details.
\t\t-ap \tAdvanced pipe mode - This kind of pipe mode is a bit advanced and different that the other pipe mode.
\t\t   \t$c_y""Example$rclrs"" : If your victim has 2 names (or more) or even if you're not sure which name is
\t\t   \t        : your victim's real name, and in numbers as well, there is a missing truth!!
\t\t   \t        : This pipe mode gives you the chance to play 'Choose from the brackets' game.
\t\t   \t$c_y""Example$rclrs"" : -ap 'alma,aima;pro;leader' - This will give you:
\t\t   \t        : $c_y""almaproleader$rclrs"" - $c_y""aimaproleader$rclrs"". So the truth is ($c_b""almaproleader$rclrs"").
\t\t   \t        : When I write in CAPS I keep the ($c_r""L$rclrs"") small ^^.
\t\t   \t$c_y""Example2$rclrs"": -ap 'alma,aima;pro,0912345678;leader,0923456781' - This will give you:
\t\t   \t        : almaproleader - almapro0923456781 - alma0912345678leader - alma09123456780923456781
\t\t   \t        : aimaproleader - aimapro0923456781 - aima0912345678leader - aima09123456780923456781
\t\t   \t        : And that's if you use $c_r""-n$rclrs"" - otherwise! It's a massive list B|.
\t\t   \t$c_r""NOTE$rclrs"": When using $c_b""-ap$rclrs"" it disables (-O, -m, -M, -D, -S, -N) - But $c_r""not$rclrs"" (-o, -n, -s, -l).

\t\t*~* [$c_b""Output File$rclrs""] *~*
\t\tIf you add $c_r""-o$rclrs"" to the startup command, you'll have the passwords in a file of your choice.
\t\t$c_y""Example$rclrs"": -o alma-ps.txt | $c_y""Example 2$rclrs"": -o 'alma pro.txt'
\t\tIf you add $c_r""-O$rclrs"" to the startup command, then every file will be saved by the mask's name.
\t\t$c_y""Example$rclrs"": -O alma - This will save the file as (alma.txt) if no mask is given.
\t\t       : But if you give a mask using (-m) or masks using (-M), your file will be name by the current mask.
\t\t$c_y""Example$rclrs"": -O alma -m '!@#' - This will name the file (alma-dns.txt). And so .....
\t\t   $c_r""Note$rclrs"": Don't add (.txt) when using -O.

\t\t*~* [$c_b""Debug Mode$rclrs] *~*
\t\tUse $c_b-d$rclrs in the startup command and you'll see debug data on the screen.

\t\t$c_r""Got it$rclrs""? Okay then, $c_g""go get them$rclrs"" ^_*
";
logo="\t\tAny Detail you get, add it with ($c_r"",$rclrs"") [$c_r""ex$rclrs"": $c_b""detail$rclrs""$c_r"",$rclrs""$c_b""detail$rclrs""$c_r"",$rclrs""$c_b""...$rclrs""]
\t\tNumbers and Specials come after details, so don't rush ^^

\t\t$c_r""But!!$rclrs"" If you want to $c_r""skip details$rclrs"" and use $c_r""only Numbers$rclrs"", 
\t\tthen write numbers in details and press $c_b""[ENTER]$rclrs"" when asked for numbers.

";
#
#     Functions & Checks
#
function print_error(){
	>&2 echo -e "$c_r$1$rclrs";
}
function print_good(){
	>&2 echo -e "$c_g$1$rclrs";
}
function print_info(){
	>&2 echo -e "$c_b$1$rclrs";
}
function print_debug(){
	if [ "$debug_mode" == "on" ]; then
		>&2 echo -e "\t\t[$c_y!$rclrs] $1"
	fi;
}
if ! [ -d "/root/Desktop/$folder_name" ]; then
	echo ;
	print_error "You don't have $folder_name folder on Desktop!!";
	sleep 2;
	print_good "Creating $folder_name folder....."
	mkdir "/root/Desktop/$folder_name";
	sleep 2;
	print_good "Done."
	sleep 2;
	echo ;
fi;
function check_int(){
	ok="n";
	if [[ $1 =~ ^-?[0-9]+$ ]]; then
		ok="y";
	fi;
	echo "$ok";
}
function check_ps(){
	if [ -f "$2" ]; then
		if grep -Fxq -e "$1" "$2"; then return 1; fi;
	fi;
	print_debug "File is ==> $2";
	print_debug "Password is ==> $1";
	if [ "$2" == "$temp_path.tmp" ]; then
		print_debug "Outputing to the pipe"
		echo "$1";
	fi;
	echo "$1" >> "$2";
}
function all_cases(){
	if [ "$normal_mode" == "y" ]; then
		echo "$1";
		return;
	fi;
	all_cases_arr=("$1");
	upp=$(echo ${1:0:1} | tr '[:lower:]' '[:upper:]');
	all_cases_arr+=("$upp");
	downn=$(echo ${1:0:1} | tr '[:upper:]' '[:lower:]');
	all_cases_arr+=("$downn");
	upp=$(case_change "$1" "ua");
	all_cases_arr+=("$upp");
	downn=$(case_change "$1" "da");
	all_cases_arr+=("$downn");
	upp=$(case_change "$1" "uf");
	all_cases_arr+=("$upp");
	downn=$(case_change "$1" "df");
	all_cases_arr+=("$downn");
	echo "${all_cases_arr[@]}";
}
function file_name(){
	spl_arr=($(spl "$1" "/"));
	leno=${#spl_arr[@]};
	fleno=$(($leno-1));
	echo "${spl_arr[$fleno]}";
}
function echo_done(){
	if ! [[ $# -gt 1 ]]; then
		if [ -f "$temp_path$(file_name "$1").tmp" ]; then
			mv "$temp_path$(file_name "$1").tmp" "$1";
			files_to_erase=("$temp_path$(file_name "$1")-D.tmp" "$temp_path$(file_name "$1")-N.tmp");
			for file_to_erase in "${files_to_erase[@]}"; do
				if [ -f "$file_to_erase" ]; then rm "$file_to_erase"; fi;
			done;
		fi;
	fi;
}
function echo_it(){
	if ! [[ $# -lt 2 ]]; then
		if ! [ "$3" == "" ]; then print_debug "Password is ==> $1"; check_ps "$1" "$2"; return; fi;
		if [ -f "$2" ]; then
			if grep -sFxq -e "$1" "$2"; then return; fi;
		fi;
		ok="n";
		now_ps="$1";
		if ! [ "$short_l" == "0" ] && ! [ "$short_l" == "1" ]; then
			if ! [ "$long_l" == "0" ]; then
				if [ "${#1}" -gt "$short_l" ] || [ "${#1}" == "$short_l" ]; then
					if [ "${#1}" -lt "$long_l" ] || [ "${#1}" == "$long_l" ];then
						ok="y";
					else
						now_ps="${1::-(${#1}-$long_l)}";
						ok="y";
					fi;
					btween_def=$(($long_l-$short_l+1));
					check_ps "${now_ps::-$btween_def}" "$temp_path$output_file_name.tmp";
					now_ps_=$(rev $now_ps);
					if [ "$normal_mode" == "n" ]; then check_ps "$(rev ${now_ps::-$btween_def})" "$temp_path$output_file_name.tmp"; fi;
				fi;
			else
				if [ "${#1}" -gt "$short_l" ]; then
					ok="y";
				fi;
			fi;
		else
			if ! [ "$long_l" == "0" ]; then
				if [ "${#1}" -lt "$long_l" ] || [ "${#1}" == "$long_l" ];then
					ok="y";
				else
					now_ps="${1::-(${#1}-$long_l)}";
					ok="y";
				fi;
			else
				ok="y";
			fi;
		fi;
		if [ "$ok" == "y" ]; then print_debug "Password is ==> $now_ps"; check_ps "$now_ps" "$temp_path$output_file_name.tmp"; fi;
	fi;
}
function spl() {
	oldifs="$IFS";
	IFS="$2";
	read -a spl_arr <<< "$1";
	IFS="$oldifs";
	echo "${spl_arr[@]}";
}
function rev(){
	rv="";
	for l in `echo $1 | grep -o .`;do
		rv="$l$rv";
	done;
	echo $rv;
}
function str_replace(){
	echo "$(echo "$1" | sed s/"$2"/"$3"/g)";
}
function case_change(){
	words_case=();
	final_words_case="";
	if ! [[ $# -gt 1 ]]; then return; fi;
	if [[ "$1" == *" "* ]]; then
		spl_arr=($(spl "$1" " "));
		words_case=("${spl_arr[@]}");
	else
		words_case=("$1");
	fi;
	for r1 in "${words_case[@]}"; do
		if ! [[ "$r1" == "" ]]; then
			if [ "$2" == "uf" ]; then
				final_words_case="$final_words_case$(echo ${r1:0:1} | tr '[:lower:]' '[:upper:]')$(echo ${r1:1}) ";
			elif [ "$2" == "df" ]; then
				final_words_case="$final_words_case$(echo ${r1:0:1} | tr '[:upper:]' '[:lower:]')$(echo ${r1:1}) ";
			elif [ "$2" == "ua" ]; then
				final_words_case="$final_words_case$(echo $r1 | tr '[:lower:]' '[:upper:]') ";
			else
				final_words_case="$final_words_case$(echo $r1 | tr '[:upper:]' '[:lower:]') ";
			fi;
		fi;
	done;
	if [ ${#final_words_case} -gt 1 ]; then
		final_words_case="${final_words_case::-1}";
	fi;
	echo "$final_words_case";
}
function final_mix(){
	declare -a arr1=("${!1}");
	declare -a arr2=("${!2}");
	declare -a arr3=("${!3}");
	print_debug "Output File is ==> $output_file";
	print_debug "Temp output file is ==> $temp_path$output_file_name.tmp";
	print_debug "arr1 ==> ${arr1[*]}";
	print_debug "arr1 count ==> ${#arr1[@]}";
	print_debug "arr2 ==> ${arr2[*]}";
	print_debug "arr2 count ==> ${#arr2[@]}";
	print_debug "arr3 ==> ${arr3[*]}";
	print_debug "arr3 count ==> ${#arr3[@]}";
	res=0;
	res=$(($res+$((${#arr1[@]}*${#arr1[@]}*$((${#arr3[@]}+1))))));
	res=$(($res+$(($((${#arr2[@]}+1))*$((${#arr2[@]}+1))*$((${#arr3[@]}+1))))));
	res=$(($res+$((${#arr1[@]}*$((${#arr2[@]}+1))*$((${#arr3[@]}+1))))));
	res=$(($res+$(($((${#arr2[@]}+1))*${#arr1[@]}*$((${#arr3[@]}))))));
	if [ "$normal_mode" == "n" ]; then res=$(($res*2)); fi;
	>&2 echo -e "\t\tYou'll have ($c_b"""$res"$rclrs"") Passwords or $c_r""less$rclrs";
	sleep 2;
	if [ -f "$temp_path$output_file_name.tmp" ] && ! [ "$output_file_name.tmp" == ".tmp" ]; then
		print_good "\t\t  .....";
		print_info "\t\t[!]  File with this name was detected in the temp folder ....";
		sleep 2;
		echo "";
		print_error "\t\t[!_!]  This function does not generate alot of passwords, so ....";
		sleep 2;
		print_good "\t\t  .....";
		print_error "\t\t[:'(]  We have to erase the file and start all over again!";
		sleep 2;
		rm "$temp_path$output_file_name.tmp";
	fi;
	for ((i1=0;i1<$((${#arr1[@]}+1));i1++)); do
		r1="${arr1[$i1]}";
		for ((i=0;i<$((${#arr3[@]}+1));i++)); do
			for ((i2=0;i2<$((${#arr1[@]}+1));i2++)); do
				rr1="${arr1[$i2]}";
				echo_it "$r1${arr3[$i]}$rr1" "$temp_path$output_file_name.tmp";
				if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1${arr3[$i]}$rr1)" "$temp_path$output_file_name.tmp"; fi;
			done;
		done;
	done;
	for ((i1=0;i1<$((${#arr2[@]}+1));i1++)); do
		r1="${arr2[$i1]}";
		for ((i=0;i<$((${#arr3[@]}+1));i++)); do
			for ((i2=0;i2<$((${#arr2[@]}+1));i2++)); do
				rr1="${arr2[$i2]}";
				echo_it "$r1${arr3[$i]}$rr1" "$temp_path$output_file_name.tmp";
				if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1${arr3[$i]}$rr1)" "$temp_path$output_file_name.tmp"; fi;
			done;
		done;
	done;
	for ((i1=0;i1<$((${#arr1[@]}+1));i1++)); do
		r1="${arr1[$i1]}";
		for ((i=0;i<$((${#arr3[@]}+1));i++)); do
			for ((i2=0;i2<$((${#arr2[@]}+1));i2++)); do
				rr1="${arr2[$i2]}";
				echo_it "$r1${arr3[$i]}$rr1" "$temp_path$output_file_name.tmp";
				if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1${arr3[$i]}$rr1)" "$temp_path$output_file_name.tmp"; fi;
			done;
		done;
	done;
	for ((i1=0;i1<$((${#arr2[@]}+1));i1++)); do
		r1="${arr2[$i1]}";
		for ((i=0;i<$((${#arr3[@]}+1));i++)); do
			for ((i2=0;i2<$((${#arr1[@]}+1));i2++)); do
				rr1="${arr1[$i2]}";
				echo_it "$r1${arr3[$i]}$rr1" "$temp_path$output_file_name.tmp";
				if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1${arr3[$i]}$rr1)" "$temp_path$output_file_name.tmp"; fi;
			done;
		done;
	done;
}
function cof(){ #Count of
	if [ "$1" == "!" ]; then
		echo "$(($2+1))";
	elif [ "$1" == "@" ]; then
		echo "$(($3+1))";
	elif [ "$1" == "#" ]; then
		echo "$(($4+1))";
	else
		echo "0";
	fi;
}
function getitfrom(){
	declare -a arrayis=("${!1}");
	if [ "${#arrayis[@]}" == "0" ] || [ "$(($2+1))" -gt "${#arrayis[@]}" ]; then echo ""; return; fi;
	echo "${arrayis[$2]}";
}
function getpos(){
	declare -a arrayis=("${!1}");
	for ((ipos=0;ipos<${#arrayis[@]};ipos++)); do
		if [ "${arrayis[$ipos]}" == "$2" ]; then echo "$ipos"; return; fi;
	done;
	echo "0";
}
function isitthis(){
	declare -a arrayis=("${!1}");
	declare -a secarr=("${!5}");
	sarr=(${secarr[@]});
	prtd=($(spl "$3" "|"));
	found="n";
	if [ "${prtd[1]}" == "1" ]; then
		tmp_pass="$(rev ${prtd[0]})";
		if ! [ "${#sarr[@]}" == "0" ]; then
			for sarr_s in "${sarr[@]}"; do
				if [[ "$tmp_pass" == "$4${arrayis[$2]}$sarr_s"* ]]; then
					echo "$4${arrayis[$2]}";
					echo "${arrayis[$2]}";
					found="y";
				fi;
			done;
		else
			if [[ "$tmp_pass" == "$4${arrayis[$2]}"* ]]; then
				echo "$4${arrayis[$2]}";
				echo "${arrayis[$2]}";
				found="y";
			fi;
		fi;
	elif [ "${prtd[1]}" == "0" ]; then
		tmp_pass="${prtd[0]}";
		if ! [ "${#sarr[@]}" == "0" ]; then
			for sarr_s in "${sarr[@]}"; do
				if [[ "$tmp_pass" == "$4${arrayis[$2]}$sarr_s"* ]]; then
					echo "$4${arrayis[$2]}";
					echo "${arrayis[$2]}";
					found="y";
				fi;
			done;
		else
			if [[ "$tmp_pass" == "$4${arrayis[$2]}"* ]]; then
				echo "$4${arrayis[$2]}";
				echo "${arrayis[$2]}";
				found="y";
			fi;
		fi;
	fi;
	if [ "$found" == "n" ]; then
		arrr=(${arrayis[@]});
		isitthis "arrr[@]" "$(($2+1))" "$3" "$4" "sarr[@]";
	fi;
}
function make_config(){
	if [ "`head -n 1 "$temp_path$output_file_name.tmp"`" == "$first_pass" ]; then
		pass_here="`tail -n 1 "$temp_path$output_file_name.tmp"`|0";
		bpass_here="`tail -n 2 "$temp_path$output_file_name.tmp" | head -n 1 -`";
		prt=($(spl "$pass_here" "|"));
		if [ "$(rev ${prt[0]})" == "$bpass_here" ]; then pass_here="${prt[0]}|1"; fi;
		pass2find="";
		prt1=($(spl "${all_s[0]}" "|"));
		print_debug "prt1 ==> ${prt1[*]}";
		if [ "${prt1[0]}" == "!" ]; then
			arry1=(${dtl_arr[@]});
		elif [ "${prt1[0]}" == "@" ]; then
			arry1=(${nmb_arr[@]});
		elif [ "${prt1[0]}" == "#" ]; then
			arry1=(${spcl_arr[@]});
		else
			arry1=("${prt1[0]}");
		fi;
		prt2=($(spl "${all_s[1]}" "|"));
		print_debug "prt2 ==> ${prt2[*]}";
		if [ "${prt2[0]}" == "!" ]; then
			arry2=(${dtl_arr[@]});
		elif [ "${prt2[0]}" == "@" ]; then
			arry2=(${nmb_arr[@]});
		elif [ "${prt2[0]}" == "#" ]; then
			arry2=(${spcl_arr[@]});
		else
			arry2=("${prt2[0]}");
		fi;
		prt3=($(spl "${all_s[2]}" "|"));
		print_debug "prt3 ==> ${prt3[*]}";
		if [ "${prt3[0]}" == "!" ]; then
			arry3=(${arr1[@]});
		elif [ "${prt3[0]}" == "@" ]; then
			arry3=(${arr2[@]});
		elif [ "${prt3[0]}" == "#" ]; then
			arry3=(${arr3[@]});
		else
			arry3=("${prt3[0]}");
		fi;
		prt=($(spl "$pass_here" "|"));
		a1c=0;
		a2c=0;
		a3c=0;
		if [ "${prt[1]}" == "0" ]; then
			print_debug "It's normal (not reversed).\r\nprt[0] ==> ${prt[0]}";
			done="n";
			until [ "$done" == "y" ]; do
				for ((i1=0;i1<${#arry1[@]};i1++)); do
					for ((i2=0;i2<${#arry2[@]};i2++)); do
						for ((i3=0;i3<${#arry3[@]};i3++)); do
							print_debug "The mix of the passwords now is ==> ${arry1[$i1]}${arry2[$i2]}${arry3[$i3]}";
							if [[ "${prt[0]}" == "${arry1[$i1]}${arry2[$i2]}${arry3[$i3]}"* ]]; then
								print_debug "Found ==> ${arry1[$i1]}${arry2[$i2]}${arry3[$i3]}
\t\ta1c ==> $i1
\t\ta2c ==> $i2
\t\ta3c ==> $i3";
								a1c=$i1;
								a2c=$i2;
								a3c=$i3;
								done="y";
							fi;
						done;
					done;
				done;
			done;
		else
			done="n";
			until [ "$done" == "y" ]; do
				for ((i1=0;i1<${#arry1[@]};i1++)); do
					for ((i2=0;i2<${#arry2[@]};i2++)); do
						for ((i3=0;i3<${#arry3[@]};i3++)); do
							print_debug "The mix of the passwords now is ==> $(rev ${arry1[$i1]}${arry2[$i2]}${arry3[$i3]})";
							if [[ "${prt[0]}" == *"$(rev ${arry1[$i1]}${arry2[$i2]}${arry3[$i3]})" ]]; then
								print_debug "Found ==> $(rev ${arry1[$i1]}${arry2[$i2]}${arry3[$i3]})
\t\ta1c ==> $i1
\t\ta2c ==> $i2
\t\ta3c ==> $i3";
								a1c=$i1;
								a2c=$i2;
								a3c=$i3;
								done="y";
							fi;
						done;
					done;
				done;
			done;
		fi;
	fi;
	all_s[0]="${arry1[$a1c]}|$a1c";
	all_s[1]="${arry2[$a2c]}|$a2c";
	all_s[2]="${arry3[$a3c]}|$a3c";
	print_debug "all_s[0] ==> ${all_s[0]}
all_s[1] ==> ${all_s[1]}
all_s[2] ==> ${all_s[2]}";
	now_pass="${arry1[$a1c]}${arry2[$a2c]}${arry3[$a3c]}";
	print_debug "now_pass ==> $now_pass";
	if [ "${prt[1]}" == "1" ]; then print_debug "The password is reversed"; now_pass="$(rev $now_pass)"; fi;
	print_debug "now_pass ==> $now_pass";
	for ((i=3;i<${#all_s[@]};$i++)); do
		s_arr="${all_s[$i]}";
		ok_this="n";
		prtc=($(spl "$s_arr" "|"));
		print_debug "prtc ==> ${prtc[@]}";
		if [ "${prtc[0]}" == "!" ]; then
			arryc=(${arr1[@]});
		elif [ "${prtc[0]}" == "@" ]; then
			arryc=(${arr2[@]});
		elif [ "${prtc[0]}" == "#" ]; then
			arryc=(${arr3[@]});
		else
			arryc=("${prtc[0]}");
		fi;
		until [ "$ok_this" == "y" ]; do
			for ((i1=0;i1<${#arryc[@]};$i1++)); do
				if [ "${prt[1]}" == "0" ]; then
					if [[ "${prt[0]}" == "$now_pass${arryc[$i1]}"* ]]; then
						all_s[$i]="${prtc[0]}|$i1"; ok_this="y";
					fi;
				else
					if [[ "${prt[0]}" == *"$(rev ${arryc[$i1]})$now_pass" ]]; then
						all_s[$i]="${prtc[0]}|$i1"; ok_this="y";
					fi;
				fi;
			done;
		done;
	done;
	rea="`wc -l < "$temp_path$output_file_name.tmp"`";
	>&2 echo -e "\t\tContinuing from the password ($c_b""${prt[0]}$rclrs"") which is the number ($c_b""$rea$rclrs"") and around $c_b""$(($rea*100/$res))$rclrs""%";
}
function continue_from(){
	if [ -f "$temp_path$output_file_name.tmp" ]; then >&2 echo; print_info "\t\t[!]  File with this name was detected in the temp folder......"; sleep 3; fi;
	if ! [ -f "$temp_path$output_file_name.tmp.config" ]; then return 1; fi
	config_arr=($(cat "$temp_path$output_file_name.tmp.config"));
	echo "${config_arr[@]}";
}
function write_config(){
	echo $1 > $temp_path$output_file_name.tmp.config;
	echo $2 >> $temp_path$output_file_name.tmp.config;
	echo $3 >> $temp_path$output_file_name.tmp.config;
	echo $4 >> $temp_path$output_file_name.tmp.config;
	echo $5 >> $temp_path$output_file_name.tmp.config;
	echo $6 >> $temp_path$output_file_name.tmp.config;
	echo $7 >> $temp_path$output_file_name.tmp.config;
}
function mask_all(){
	declare -a arr1=("${!1}");
	declare -a arr2=("${!2}");
	declare -a arr3=("${!3}");
	mask_arr=($(echo "$4" | grep -o .));
	d_c=${#arr1[@]};
	n_c=${#arr2[@]};
	s_c=${#arr3[@]};
	all_s=();
	final_pass="";
	first_pass="";
	res=1;
	for msk in "${mask_arr[@]}"; do
		all_s+=("$msk|0");
		arry2=();
		if [ "$msk" == "!" ]; then
			first_pass="$first_pass${arr1[0]}";
			arry2=(${arr1[@]})
			res=$(($res*$d_c));
		elif [ "$msk" == "@" ]; then
			first_pass="$first_pass${arr2[0]}";
			arry2=(${arr2[@]})
			res=$(($res*$n_c));
		elif [ "$msk" == "#" ]; then
			first_pass="$first_pass${arr3[0]}";
			arry2=(${arr3[@]})
			res=$(($res*$s_c));
		else
			first_pass="$first_pass$msk";
			arry2=("$msk");
		fi;
		final_pass="$final_pass${arry2[-1]}"
	done;
	all_c=${#all_s[@]};
	if [ "$normal_mode" == "n" ]; then res=$(($res*2)); fi;
	>&2 echo -e "\t\tYou'll have ($c_b"""$res"$rclrs"") Passwords or $c_r""less$rclrs";
	sleep 2;
	if ! [ "$6" == "" ]; then
		config_arr=($(continue_from));
		if ! [ "$!" == "1" ]; then
			first_pass="${config_arr[0]}";
			all_s=($(spl "${config_arr[1]}" ","))
			all_c=${#all_s[@]};
			mask_v="${config_arr[2]}";
			dtl="${config_arr[3]}";
			nmb="${config_arr[4]}";
			spcl="${config_arr[5]}";
			if [[ "$dtl" == *","* ]]; then dtl_arr=($(spl "$dtl" ",")); else dtl_arr=($dtl); fi;
			if [[ "$nmb" == *","* ]]; then nmb_arr=($(spl "$nmb" ",")); else nmb_arr=($nmb); fi;
			if [[ "$spcl" == *","* ]]; then spcl_arr=($(spl "$spcl" ",")); else spcl_arr=($spcl); fi;
			if [ -f "$temp_path$output_file_name.tmp" ]; then 
				rea="`wc -l < "$temp_path$output_file_name.tmp"`";
			else
				rea=0;
			fi;
			>&2 echo -e "\t\tContinuing from the password ($c_b""${config_arr[-1]}$rclrs"") which is the number ($c_b""$rea$rclrs"") and around $c_b""$(($rea*100/$res))$rclrs""%";
		else
			print_error "\t\t[!]  No configuration file was found! Try --config or delete the file from the temp folder..";
			print_error "\t\tAborting....";
			sleep 3;
			exit;
		fi;
	fi;
	last_pass="";
	until [ "$last_pass" == "$final_pass" ]; do
		now_ps="";
		first_pass="";
		for ((i=0;i<$all_c;i++)); do
			prt=($(spl ${all_s[$i]} "|"));
			print_debug "${prt[0]} == ${prt[1]}";
			arry2=();
			if [ "${prt[0]}" == "!" ]; then
				arry2=(${arr1[@]})
			elif [ "${prt[0]}" == "@" ]; then
				arry2=(${arr2[@]})
			elif [ "${prt[0]}" == "#" ]; then
				arry2=(${arr3[@]})
			else
				arry2=("${prt[0]}");
			fi;
			now_ps="$now_ps$(getitfrom "arry2[@]" ${prt[1]})";
			first_pass="$first_pass$(getitfrom "arry2[@]" "0")";
			if [ "${prt[0]}" == "!" ] || [ "${prt[0]}" == "@" ] || [ "${prt[0]}" == "#" ]; then
				if [ "${prt[1]}" -gt "$(cof ${prt[0]} $d_c $n_c $s_c)" ] || [ "${prt[1]}" == "$(cof ${prt[0]} $d_c $n_c $s_c)" ]; then
					print_debug "prt[1] is [greater than] $(cof ${prt[0]} $d_c $n_c $s_c)";
					prt1=($(spl ${all_s[$i+1]} "|"));
					if [ "${prt1[0]}" == "!" ]; then
						all_s[$i+1]="${prt1[0]}|$((${prt1[1]}+1))";
					elif [ "${prt1[0]}" == "@" ]; then
						all_s[$i+1]="${prt1[0]}|$((${prt1[1]}+1))";
					elif [ "${prt1[0]}" == "#" ]; then
						all_s[$i+1]="${prt1[0]}|$((${prt1[1]}+1))";
					else
						for (( ii = $i+2; ii < $all_c; ii++ )); do
							prt2=($(spl ${all_s[$ii]} "|"));
							if [ "${prt2[0]}" == "!" ] || [ "${prt2[0]}" == "@" ] || [ "${prt2[0]}" == "#" ]; then
								all_s[$ii]="${prt2[0]}|$((${prt2[1]}+1))";
								break;
							fi
						done;
					fi;
					prt[1]="0";
					all_s[$i]="${prt[0]}|0";
				fi;
				if [[ "$i" == "0" ]]; then
					all_s[$i]="${prt[0]}|$((${prt[1]}+1))";
				fi;
			else
				if [ "$i" == "0" ]; then
					for (( ii = 1; ii < $all_c; ii++ )); do
						prt2=($(spl ${all_s[$ii]} "|"));
						if [ "${prt2[0]}" == "!" ] || [ "${prt2[0]}" == "@" ] || [ "${prt2[0]}" == "#" ]; then
							all_s[$ii]="${prt2[0]}|$((${prt2[1]}+1))";
							break;
						fi
					done;
				fi;
			fi;
		done;
		last_pass=$now_ps;
		print_debug $first_pass;
		print_debug $now_ps;
		all_ss="";
		for ss in "${all_s[@]}"; do
			all_ss="$all_ss,$ss";
		done;
		echo_it $now_ps "$2";
		write_config "$first_pass" "$all_ss" "$mask_v" "$dtl" "$nmb" "$spcl" "$now_ps";
		if [ "$normal_mode" == "n" ]; then
			echo_it $(rev $now_ps) "$2";
			write_config "$first_pass" "$all_ss" "$mask_v" "$dtl" "$nmb" "$spcl" "$(rev $now_ps)";
		fi;
	done;
}
if ! [ "$1" == "" ];then
	if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
		>&2 echo -e "$hlogo";
		sleep 5;
		exit;
	fi;
	args_len=$#;
	args=("$@");
	for ((i=0;i<$args_len;i++)); do
		if [ "${args[$i]}" == "-p" ]; then
			pipe="yes";
			pipe_input="$(str_replace "${args[$(($i+1))]}" " " "%20")";
			spl_arr=($(spl "$pipe_input" ";"));
			dtl="${spl_arr[0]}";
			nmb="${spl_arr[1]}";
			if [ "${spl_arr[2]}" == "" ]; then
				spcl="";
			elif [ "${spl_arr[2]}" == "," ]; then
				spcl="$dflt_spcl";
			else
				spcl="${spl_arr[2]}";
			fi;
		elif [ "${args[$i]}" == "-m" ]; then
			if ! [ "${args[$(($i+1))]}" == ""  ]; then mask_v="${args[$(($i+1))]}"; fi;
		elif [ "${args[$i]}" == "-l" ]; then
			if [ $(check_int "${args[$(($i+1))]}") == "y"  ]; then long_l=${args[$(($i+1))]}; fi;
		elif [ "${args[$i]}" == "-s" ]; then
			if [ $(check_int "${args[$(($i+1))]}") == "y"  ]; then short_l=${args[$(($i+1))]}; fi;
		elif [ "${args[$i]}" == "-o" ]; then
			output_file="$(realpath "${args[$(($i+1))]}")";
			output_file_name=$(file_name "$output_file");
		elif [ "${args[$i]}" == "-n" ]; then
			normal_mode="y";
		elif [ "${args[$i]}" == "-M" ]; then
			msk_file="$(realpath "${args[$(($i+1))]}")";
		elif [ "${args[$i]}" == "-S" ]; then
			spcl_file="$(realpath "${args[$(($i+1))]}")";
		elif [ "${args[$i]}" == "-N" ]; then
			nmb_file="$(realpath "${args[$(($i+1))]}")";
		elif [ "${args[$i]}" == "-D" ]; then
			dtl_file="$(realpath "${args[$(($i+1))]}")";
		elif [ "${args[$i]}" == "-O" ]; then
			output2file="$(realpath "${args[$(($i+1))]}")";
		elif [ "${args[$i]}" == "-ap" ]; then
			advanced_pipe="yes";
			arrays=($(spl "${args[$(($i+1))]}" ";"));
		elif [ "${args[$i]}" == "-d" ]; then
			debug_mode="on";
		fi;
	done;
fi;
if [ "$advanced_pipe" == "no" ]; then
	if [ "$pipe" == "no" ]; then
		>&2 echo -e "$logo";
		if [ "$dtl_file" == "" ]; then
			read -r -p "Details Please > " dtl;
			if [ "$dtl" == "" ] ;then
				print_info "\t\tDid you know that empty details' line will never make a passwords list 0.0?
\t\tPlease enter a minimum of two details Or I'll kill myself again.


";
				sleep 3;
				print_error "\t\tKilling my self in :";
				sleep 1;
				>&2 echo -e "\t\t5";
				sleep 1;
				>&2 echo -e "\t\t4";
				sleep 1;
				>&2 echo -e "\t\t3";
				sleep 1;
				>&2 echo -e "\t\t2";
				sleep 1;
				>&2 echo -e "\t\t1";
				sleep 1;
				print_error "\t\t\tR.I.P [Me] |':";
				sleep 3;
				exit;
			fi;
		fi;
		if [ "$nmb_file" == "" ]; then read -r -p "Numbers Please > " nmb; fi;
		if [ "$spcl_file" == "" ]; then
			read -r -p "Specials Please > " spcl;
			if [ "$spcl" == "" ]; then
				read -r -p "Do you want to use the default Specials? [ Write anything for NO or nothing for YES ] > " ansr;
				if [ "$ansr" == "" ]; then
					spcl="$dflt_spcl";
				fi;
			fi;
		fi;
		read -r -p "Shortest password length [Default: $short_l] > " shrt;
		if ! [ "$shrt" == "" ]; then
			if [ $(check_int $shrt) == "y" ]; then
				short_l=$shrt;
			else
				print_error "Error: Input was not integer!! Using default value!";
			fi;
		fi;
		read -r -p "Longest password length [Default: $long_l] > " lng;
		if ! [ "$lng" == "" ]; then
			if [ $(check_int $lng) == "y" ]; then
				long_l=$lng;
			else
				print_error "Error: Input was not integer!! Using default value!";
			fi;
		fi;
		if [ "$msk_file" == "" ]; then
			read -r -p "Mask [Default: $mask_v] Write a white space for NO (If not empty) > " msk;
			if ! [ "$lng" == "" ]; then
				if ! [ "$msk" == "" ]; then
					mask_v="$mask_v";
				elif [ "$msk" == " " ]; then
					mask_v="";
				else
					mask_v="$msk";
				fi;
			fi;
		fi;
	fi;
	if [[ "$dtl" == *","* ]]; then dtl_arr=($(spl "$dtl" ",")); else dtl_arr=($dtl); fi;
	if [[ "$nmb" == *","* ]]; then nmb_arr=($(spl "$nmb" ",")); else nmb_arr=($nmb); fi;
	if [[ "$spcl" == *","* ]]; then spcl_arr=($(spl "$spcl" ",")); else spcl_arr=($spcl); fi;
	if [ "${#dtl_arr[@]}" == "1" ]; then
		echo "";
		print_error "** Only one detail was given!! and that's not enough!! **";
		sleep 5;
		exit;
	fi;
fi;
if [ ! -d "$temp_path" ]; then
	mkdir -p "$temp_path";
fi;
print_good "\t\tNow will start working ^^";
sleep 3;
function dtl_mix(){
	declare -a dtls=("${!1}");
	now_dtl=();
	for dtl in "${dtls[@]}"; do
		tmp_arr=($(all_cases "$dtl"));
		for tmp_s in "${tmp_arr[@]}"; do
			tmp_here="n";
			for now_d in "${now_dtl[@]}"; do
				if [ "$now_d" == "$tmp_s" ]; then
					tmp_here="y";
					break;
				fi;
			done;
			if [ "$tmp_here" == "n" ]; then now_dtl+=("$tmp_s"); fi;
			if ! [[ "${now_dtl[@]}" =~ "$(rev $tmp_s)" ]]; then now_dtl+=("$(rev $tmp_s)"); fi;
		done;
	done;
	echo "${now_dtl[@]}";
}
function advanced_mix(){
	declare -a arrys=("${!1}");
	for a in "${arrys[@]}"; do
		a="$a,";
		tmp_a=();
		spl_arr=($(spl "$a" ","));
		for aa in "${spl_arr[@]}"; do
			tmp_arr=($(all_cases "$aa"));
			for aaa in "${tmp_arr[@]}"; do
				tmp_here='n';
				for t in "${tmp_a[@]}"; do
					if [ "$t" == "$aaa" ]; then
						tmp_here="y"; break;
					fi;
				done;
				if [ "$tmp_here" == "n" ]; then tmp_a+=("$aaa"); fi
				if ! [[ "${tmp_a[@]}" =~ "$(rev $aaa)" ]]; then tmp_a+=("$(rev $aaa)"); fi;
			done;
		done;
		final_a="${tmp_a[0]}";
		for ((ta=1;ta<${#tmp_a[@]};ta++)); do
			final_a="$final_a,${tmp_a[$ta]}";
		done;
		echo "$final_a";
	done;
}
function do_files(){
	declare -a arr1=("${!1}");
	declare -a arr2=("${!2}");
	declare -a arr3=("${!3}");
	mask_v="$4";
	m2use="1";
	d2use="1";
	n2use="1";
	s2use="1";
	if ! [ "$msk_file" == "" ]; then
		if ! [ -f "$msk_file" ] || [ "`wc -l < "$msk_file"`" == "0" ]; then
			>&2 echo "";
			print_error "\t\t[!]  Masks' file was not found or was empty!! Using mask input...";
			m2use="0";
			sleep 3;
		fi;
	else
		m2use="0";
	fi;
	if ! [ "$dtl_file" == "" ]; then
		if ! [ -f "$dtl_file" ] || [ "`wc -l < "$dtl_file"`" == "0" ]; then
			>&2 echo "";
			print_error "\t\t[!]  Detials' file was not found or was empty!! Using details input...";
			d2use="0";
			sleep 3;
		fi;
	else
		d2use="0";
	fi;
	if ! [ "$nmb_file" == "" ]; then
		if ! [ -f "$nmb_file" ] || [ "`wc -l < "$nmb_file"`" == "0" ]; then
			>&2 echo "";
			print_error "\t\t[!]  Numbers' file was not found or was empty!! Using numbers input...";
			n2use="0";
			sleep 3;
		fi;
	else
		n2use="0";
	fi;
	if ! [ "$spcl_file" == "" ]; then
		if ! [ -f "$spcl_file" ] || [ "`wc -l < "$spcl_file"`" == "0" ]; then
			>&2 echo "";
			print_error "\t\t[!]  Specials' file was not found or was empty!! Using specials input...";
			s2use="0";
			sleep 3;
		fi;
	else
		s2use="0";
	fi;
	if [ "$d2use" == "0" ] && [ "${#dtl_arr[@]}" == "0" ]; then
		>&2 echo "";
		print_error "\t\t[!]   No details were found!! Aborting.......";
		sleep 3;
		exit;
	fi;
	>&2 echo "";
	print_info "\t\t[!]  Now will start generating multiple passwords' counts. It may take so long!!!";
	>&2 echo "";
	print_info "\t\t[~]  Every passwords' count means another deferent passwords, so, be patient....";
	>&2 echo "";
	sleep 2;
	if [ "$m2use" == "1" ]; then
		msk_fl="`wc -l < "$msk_file"`";
		for ((i1=1;i1<$(($msk_fl+1));i1++)); do
			mask_v="`sed "$i1"q";d" "$msk_file"`";
			if ! [ "$output2file" == "" ]; then
				last_name="-";
				for msk in $(echo "$mask_v" | grep -o .); do
					if [ "$msk" == "!" ]; then
						last_name="$last_name""d";
					elif [ "$msk" == "@" ]; then
						last_name="$last_name""n";
					elif [ "$msk" == "#" ]; then
						last_name="$last_name""s";
					else
						last_name="$last_name$msk";
					fi;
				done;
				last_name="$last_name.txt";
				output_file="$output2file$last_name";
				output_file_name=$(file_name "$output_file");
			fi;
			print_good "\t\t[!]  Choosing mask number ($i1) which is ==> $mask_v";
			>&2 echo "";
			if [ "$d2use" == "1" ]; then
				dtl_fl="`wc -l < "$dtl_file"`";
				for ((i2=1;i2<$(($dtl_fl+1));i2++)); do
					cdfl="`sed "$i2"q";d" "$dtl_file"`";
					dtl_arr=($(spl "$cdfl" ","))
					if [ "$n2use" == "1" ]; then
						nmb_fl="`wc -l < "$nmb_file"`";
						for ((i3=1;i3<$(($nmb_fl+1));i3++)); do
							cnfl="`sed "$i3"q";d" "$nmb_file"`";
							nmb_arr=($(spl "$cnfl" ","))
							if [ "$s2use" == "1" ]; then
								spcl_fl="`wc -l < "$spcl_file"`";
								for ((i4=1;i4<$(($spcl_fl+1));i4++)); do
									csfl="`sed "$i4"q";d" "$spcl_file"`";
									spcl_arr=($(spl "$csfl" ","))
									mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
									echo_done "$output_file";
								done;
							else
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
								echo_done "$output_file";
							fi;
						done;
					else
						if [ "$s2use" == "1" ]; then
							spcl_fl="`wc -l < "$spcl_file"`";
							for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
								csfl="`sed "$i3"q";d" "$spcl_file"`";
								spcl_arr=($(spl "$csfl" ","))
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
								echo_done "$output_file";
							done;
						else
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							echo_done "$output_file";
						fi;
					fi;
				done;
			else
				if [ "$n2use" == "1" ]; then
					nmb_fl="`wc -l < "$nmb_file"`";
					for ((i2=1;i2<$(($nmb_fl+1));i2++)); do
						cnfl="`sed "$i2"q";d" "$nmb_file"`";
						nmb_arr=($(spl "$cnfl" ","))
						if [ "$s2use" == "1" ]; then
							spcl_fl="`wc -l < "$spcl_file"`";
							for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
								csfl="`sed "$i3"q";d" "$spcl_file"`";
								spcl_arr=($(spl "$csfl" ","))
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
								echo_done "$output_file";
							done;
						else
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							echo_done "$output_file";
						fi;
					done;
				else
					if [ "$s2use" == "1" ]; then
						spcl_fl="`wc -l < "$spcl_file"`";
						for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
							csfl="`sed "$i3"q";d" "$spcl_file"`";
							spcl_arr=($(spl "$csfl" ","))
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							echo_done "$output_file";
						done;
					else
						mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
						echo_done "$output_file";
					fi;
				fi;
			fi;
		done;
	else
		if ! [ "$mask_v" == "" ]; then
			if ! [ "$output2file" == "" ]; then
				last_name="-";
				for msk in $(echo "$mask_v" | grep -o .); do
					if [ "$msk" == "!" ]; then
						last_name="$last_name""d";
					elif [ "$msk" == "@" ]; then
						last_name="$last_name""n";
					elif [ "$msk" == "#" ]; then
						last_name="$last_name""s";
					else
						last_name="$last_name$msk";
					fi;
				done;
				last_name="$last_name.txt";
				output_file="$output2file$last_name";
				output_file_name=$(file_name "$output_file");
			fi;
			if [ "$d2use" == "1" ]; then
				dtl_fl="`wc -l < "$dtl_file"`";
				for ((i1=1;i1<$(($dtl_fl+1));i1++)); do
					cdfl="`sed "$i1"q";d" "$dtl_file"`";
					dtl_arr=($(spl "$cdfl" ","))
					if [ "$n2use" == "1" ]; then
						nmb_fl="`wc -l < "$nmb_file"`";
						for ((i2=1;i2<$(($nmb_fl+1));i2++)); do
							cnfl="`sed "$i2"q";d" "$nmb_file"`";
							nmb_arr=($(spl "$cnfl" ","))
							if [ "$s2use" == "1" ]; then
								spcl_fl="`wc -l < "$spcl_file"`";
								for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
									csfl="`sed "$i3"q";d" "$spcl_file"`";
									spcl_arr=($(spl "$csfl" ","))
									mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
									echo_done "$output_file";
								done;
							else
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
								echo_done "$output_file";
							fi;
						done;
					else
						if [ "$s2use" == "1" ]; then
							spcl_fl="`wc -l < "$spcl_file"`";
							for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
								csfl="`sed "$i3"q";d" "$spcl_file"`";
								spcl_arr=($(spl "$csfl" ","))
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
								echo_done "$output_file";
							done;
						else
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							echo_done "$output_file";
						fi;
					fi;
				done;
			else
				if ! [ "$output2file" == "" ]; then
					output_file="$output2file.txt";
					output_file_name=$(file_name "$output_file");
				fi;
				if [ "$n2use" == "1" ]; then
					nmb_fl="`wc -l < "$nmb_file"`";
					for ((i2=1;i2<$(($nmb_fl+1));i2++)); do
						cnfl="`sed "$i2"q";d" "$nmb_file"`";
						nmb_arr=($(spl "$cnfl" ","))
						if [ "$s2use" == "1" ]; then
							spcl_fl="`wc -l < "$spcl_file"`";
							for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
								csfl="`sed "$i3"q";d" "$spcl_file"`";
								spcl_arr=($(spl "$csfl" ","))
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
								echo_done "$output_file";
							done;
						else
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							echo_done "$output_file";
						fi;
					done;
				else
					if [ "$s2use" == "1" ]; then
						spcl_fl="`wc -l < "$spcl_file"`";
						for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
							csfl="`sed "$i3"q";d" "$spcl_file"`";
							spcl_arr=($(spl "$csfl" ","))
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							echo_done "$output_file";
						done;
					else
						mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
						echo_done "$output_file";
					fi;
				fi;
			fi;
		else
			if [ "$d2use" == "1" ]; then
				dtl_fl="`wc -l < "$dtl_file"`";
				for ((i1=1;i1<$(($dtl_fl+1));i1++)); do
					cdfl="`sed "$i1"q";d" "$dtl_file"`";
					dtl_arr=($(spl "$cdfl" ","))
					if [ "$n2use" == "1" ]; then
						nmb_fl="`wc -l < "$nmb_file"`";
						for ((i2=1;i2<$(($nmb_fl+1));i2++)); do
							cnfl="`sed "$i2"q";d" "$nmb_file"`";
							nmb_arr=($(spl "$cnfl" ","))
							if [ "$s2use" == "1" ]; then
								spcl_fl="`wc -l < "$spcl_file"`";
								for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
									csfl="`sed "$i3"q";d" "$spcl_file"`";
									spcl_arr=($(spl "$csfl" ","))
									final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
									echo_done "$output_file";
								done;
							else
								final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
								echo_done "$output_file";
							fi;
						done;
					else
						if [ "$s2use" == "1" ]; then
							spcl_fl="`wc -l < "$spcl_file"`";
							for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
								csfl="`sed "$i3"q";d" "$spcl_file"`";
								spcl_arr=($(spl "$csfl" ","))
								final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
								echo_done "$output_file";
							done;
						else
							final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
							echo_done "$output_file";
						fi;
					fi;
				done;
			else
				if [ "$n2use" == "1" ]; then
					nmb_fl="`wc -l < "$nmb_file"`";
					for ((i2=1;i2<$(($nmb_fl+1));i2++)); do
						cnfl="`sed "$i2"q";d" "$nmb_file"`";
						nmb_arr=($(spl "$cnfl" ","))
						if [ "$s2use" == "1" ]; then
							spcl_fl="`wc -l < "$spcl_file"`";
							for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
								csfl="`sed "$i3"q";d" "$spcl_file"`";
								spcl_arr=($(spl "$csfl" ","))
								final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
								echo_done "$output_file";
							done;
						else
							final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
							echo_done "$output_file";
						fi;
					done;
				else
					if [ "$s2use" == "1" ]; then
						spcl_fl="`wc -l < "$spcl_file"`";
						for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
							csfl="`sed "$i3"q";d" "$spcl_file"`";
							spcl_arr=($(spl "$csfl" ","))
							final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
							echo_done "$output_file";
						done;
					else
						final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
						echo_done "$output_file";
					fi;
				fi;
			fi;
		fi;
	fi;
}
function a_d(){
	declare -a ni_arr=("${!1}");
	declare -a ys_arr=("${!2}");
	wat=();
	for ((ni=0;ni<${#ni_arr[@]};ni++)); do
		yc_arr=($(spl "${ys_arr[$ni]}" ","));
		yc_c=${#yc_arr[@]};
		if [ "${ni_arr[$ni]}" == "$yc_c" ]; then
			wat+=("y")
		else
			wat+=("n")
		fi;
	done;
	for w in "${wat[@]}"; do
		if [ "$w" == "n" ]; then echo "n"; return; fi;
	done;
	echo "y";
}
function advanced(){
	declare -a arrys=("${!1}");
	res=1;
	now_in=();
	config_res=($(continue_from "ap"));
	if [ "$!" == "0" ]; then
		arrys=($(spl "${config_res[0]}" ";"));
		now_in=($(spl "${config_res[1]}" ","));
	fi;
	for arr in "${arrys[@]}"; do
		tmp_arr=($(spl "$arr" ","));
		res=$(($res*${#tmp_arr[@]}));
	done;
	if [ "$normal_mode" == "n" ]; then res=$(($res*2)); fi;
	>&2 echo -e "\t\tYou'll have ($c_b"""$res"$rclrs"") Passwords or $c_r""less$rclrs";
	if [ "${#now_id[@]}" == "0" ]; then for ((ia=0;ia<${#arrays[@]};ia++)); do now_in+=(0); done; fi;
	until [ "$(a_d "now_in[@]" "arrays[@]")" == "y" ]; do
		now_pass="";
		for ((ia=0;ia<${#arrays[@]};ia++)); do
			c_arr=($(spl "${arrays[$ia]}" ","));
			c_arr_c=${#c_arr[@]};
			if [ "${now_in[$ia]}" -gt "$c_arr_c" ]; then
				now_in[$ia]=0;
				now_in[$ia+1]=$((${now_in[$ia+1]}+1));
			fi;
			now_pass="$now_pass${c_arr[${now_in[$ia]}]}";
			if [ "$ia" == "0" ]; then now_in[$ia]=$((${now_in[$ia]}+1)); fi;
		done;
		echo_it "$now_pass" "$temp_path$output_file_name.tmp";
	done;
}
if [ "$advanced_pipe" == "no" ]; then
	if [ "$normal_mode" == "n" ]; then
		dtl_arr=($(dtl_mix "dtl_arr[@]"));
		nmb_arr=($(dtl_mix "nmb_arr[@]"));
		spcl_arr=($(dtl_mix "spcl_arr[@]"));
	fi;
	if [ "$msk_file" == "" ] && [ "$dtl_file" == "" ] && [ "$nmb_file" == "" ] && [ "$spcl_file" == "" ]; then
		if ! [ "$mask_v" == "" ]; then
			if ! [ "$output2file" == "" ]; then
				last_name="-";
				for msk in $(echo "$mask_v" | grep -o .); do
					if [ "$msk" == "!" ]; then
						last_name="$last_name""d";
					elif [ "$msk" == "@" ]; then
						last_name="$last_name""n";
					elif [ "$msk" == "#" ]; then
						last_name="$last_name""s";
					else
						last_name="$last_name$msk";
					fi;
				done;
				last_name="$last_name.txt";
				output_file="$output2file$last_name";
				output_file_name=$(file_name "$output_file");
			fi;
			if ! [[ -f "$temp_path$output_file_name.tmp" ]]; then
				mask_arr=($(echo $mask_v | grep -o .));
				all_s=();
				d_c=${#dtl_arr[@]};
				n_c=${#nmb_arr[@]};
				s_c=${#spcl_arr[@]};
				res=1;
				for msk in "${mask_arr[@]}"; do
					all_s+=("$msk|0");
					arry2=();
					if [ "$msk" == "!" ]; then
						first_pass="$first_pass${arr1[0]}";
						arry2=(${dtl_arr[@]})
						res=$(($res*$d_c));
					elif [ "$msk" == "@" ]; then
						first_pass="$first_pass${arr2[0]}";
						arry2=(${nmb_arr[@]})
						res=$(($res*$n_c));
					elif [ "$msk" == "#" ]; then
						first_pass="$first_pass${arr3[0]}";
						arry2=(${spcl_arr[@]})
						res=$(($res*$s_c));
					else
						first_pass="$first_pass$msk";
						arry2=("$msk");
					fi;
					final_pass="$final_pass${arry2[-1]}"
				done;
			fi
			all_ss="";
			for ss in "${all_s[@]}"; do
				all_ss="$all_ss,$ss";
			done;
			dtl='';
			nmb='';
			spcl='';
			for dt in ${dtl_arr[@]}; do
				dtl="$dtl,$dt";
			done
			for nm in ${nmb_arr[@]}; do
				nmb="$nmb,$nm";
			done
			for sp in ${spcl_arr[@]}; do
				spcl="$spcl,$sp";
			done
			write_config "$first_pass" "$all_ss" "$mask_v" "$dtl" "$nmb" "$spcl" "$first_pass";
			mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp" "n";
			echo_done "$output_file";
		else
			if ! [ "$output2file" == "" ]; then
				output_file="$output2file.txt";
				output_file_name=$(file_name "$output_file");
			fi;
			final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
			echo_done "$output_file";
		fi;
	else
		do_files "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v";
	fi;
else
	if [ "$normal_mode" == "n" ]; then
		arrays=($(advanced_mix "arrays[@]"));
	fi;
	advanced "arrays[@]";
	echo_done "$output_file";
fi;
