#!/bin/bash
#
#  [Program]
#
#  CDPG v1.0(Build 29)
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
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  any later version.
#
#  [A.R.M-Y H4CK3RZ]
#  
#  This program is made by A.R.M-Y H4CK3RZ for the penetration testing course here http://www.arm-y.org/course | http://fb.com/A.R.M.Libya.Official
#  It's included in the course files folder which is named "AlMAPRO" if you have the folder then put it on the desktop of your ROOT user so all files
#  work fine! And be sure to focus on the "UPPERCASE" and "lowercase" letters.
#  This course is made for educational purposes ONLY. We are NOT responsible for any harmful use of the files or techniques of hacking included in
#  the course. All victims in the course are not hacked for joy, but for either showing the people how it's done or personal purposes.
#  All victims, even the ones whom deserve it are NOT harmed by our hack attacks as we UNDO all the hacks and exploits afterwards.
#
#
folder_name="AlMAPRO"; # Free to name it ^^
#
#	Here comes the Logo :v
#	Our pride "This is a very emotional moment, I'm very vulnerable right now :'|";
#
main_logo="\t\t \x1B[01;32mCommon Detailed Passwords Generator\x1B[0m - \x1B[01;31mA.R.M-Y H4CK3RZ\x1B[0m
\t\t\t\thttp://www.arm-y.org
\t \t \t \t ------------------
\t\t\t\t  \x1B[01;31mUse it wisely ^^\x1B[0m";
#
#
#
#
>&2 echo -e "$main_logo";
final=();
spl_arr=();
spc_arr=();
pipe="no";
temp_path="/root/Desktop/$folder_name/cdpg_tmp/"; # Temp files path. NOTE: Do NOT set it to /tmp folder or any folder inside of it. Why?
# because if you turn off your computer you'll never continue from the last password and will start all over again.
dtl="";
nmb="";
spcl="";
dflt_spcl='_,.,+,-,(,)'; # Default special chars. free to modify ^^
output_file="";
output_file_name=""; # Do NOT modify this.
newline=$'\n'; # Do NOT modify this.
check_arr="";
short_l=0; # If = 0 or 1 then disable shortest length.
long_l=0;  # If = 0 then disable longest length.
mask_v=""; # If empty then no mask will be used.
res=1; # Passwords count.
normal_mode="n"; # By default normal mode is off so the passwords are more aggressive.
#
#	The files below are set to empty by default! If you modify them to real files, your masks, details, numbers and specials
#	will be read from the files.
#
#The files are modifiable xD		-----.
dtl_file=""; # Details' file.		     |======================================================================================
nmb_file=""; # Numbers' file.		     | Those files were founded after suggestion of Zeko Ly https://www.facebook.com/Zeko.Ly
spcl_file=""; # Specials' file.		     |======================================================================================
msk_file=""; # Masks' file.		_____|
#
#
#	Here comes the Help :v
#
hlogo="\t\t\t\t~*[\x1B[01;34mHelp Message\x1B[0m]*~

\t\tIt's so simple

\t\t[\x1B[01;34mNormal stdout Mode\x1B[0m]
\t\t\x1B[01;31mDetails\x1B[0m first, \x1B[01;33mExample\x1B[0m : alma,pro,leader,hacker,libya,MrRobot,anything,..
\t\tThen \x1B[01;31mNumbers\x1B[0m, Phone number,birthdate,...
\t\tAny \x1B[01;31mnumbers\x1B[0m that the victim may have in \x1B[01;34mhis\x1B[0m/\x1B[01;34mher\x1B[0m \x1B[01;31mlife\x1B[0m, \x1B[01;33mExample\x1B[0m: 911,12345678,87654321,..
\t\tThen \x1B[01;31mSpecials\x1B[0m, Any Characters that the victim might use! Or let it empty so you'll be asked about using \x1B[01;31mspecials\x1B[0m.

\t\t[\x1B[01;34mPipe Mode\x1B[0m]
\t\tWrite the \x1B[01;31mdetails\x1B[0m normaly but... Add (\x1B[01;31m;\x1B[0m) at the \x1B[01;31mdetails\x1B[0m' end, then write the \x1B[01;31mnumbers\x1B[0m normaly, then the \x1B[01;31mspecials\x1B[0m
\t\t(\x1B[01;31mDon't forget to write them inside\x1B[0m \x1B[01;34m''\x1B[0m) \x1B[01;33mExample\x1B[0m : 'alma,pro,leader,....;911,12345678,0912345678;-,_,.,+....'
\t\tIf you write (\x1B[01;31m,\x1B[0m) in the \x1B[01;31mspecials\x1B[0m' place at the end of the pipe mode input,
\t\t[\x1B[01;33mEx\x1B[0m: 'detail,..;911,..;,' ], the default \x1B[01;31mspecials\x1B[0m will be used.
\t\tAnd if you don't want to use \x1B[01;31mspecials\x1B[0m, then write \x1B[01;31mnothing\x1B[0m in \x1B[01;31mspecials\x1B[0m' place.
\t\t[\x1B[01;33mEx\x1B[0m: 'detail,...,911,...;' ]

\t\tIf the script starts with:
\t\t-h \tThis message will visit your screen ^^ - Use also --help
\t\t-p \tPipe mode is on and you have to write in pipe mode input.
\t\t-l \tLongest password length - if you want to set a limit for the passwords length.
\t\t-s \tShortest password length - if you want to set a limit for the passwords length.
\t\t-n \tNormal passwords mode - Set normal_mode to on, if off, then passwords are more aggressive. (Default: Off)
\t\t-m \tMask mix - if you have a specific mask for your passwords then add it after this.
\t\t   \t(\x1B[01;31mYou must add the mask inside \x1B[0m\x1B[01;34m''\x1B[0m).
\t\t   \t\x1B[01;34mNow the format\x1B[0m:
\t\t   \t\t ! = Detail.
\t\t   \t\t @ = Number.
\t\t   \t\t # = Special.
\t\t   \t\x1B[01;33mExample\x1B[0m: -m \x1B[01;34m'\x1B[0m#!#@#\x1B[01;34m'\x1B[0m
\t\t   \t: This will generate passwords of the format,
\t\t   \t: 'Special Detail Special Number Special' ==> '-alma-123-'. And so...
\t\t-M Read masks from file - Read more than one mask from a file in the format of one mask per line.
\t\t-D Read details from file - Read more than one details' input
\t\t   \t\x1B[01;33mExample\x1B[0m: Let's say you have alot of details, but you don't want them in the same input,
\t\t   \t: so you use -D to read from a file with the format of one details' input per line.
\t\t   \t: Every details input will be used alone with the current mask, current numbers and the current specials.
\t\t-N Read numbers from file - Read more than one numbers' input
\t\t   \t\x1B[01;33mExample\x1B[0m: Let's say you have alot of number, phone numbers' list,
\t\t   \t: so you use -N to read from a file with the format of one numbers' input per line.
\t\t   \t: Every numbers input will be used alone with the current mask, current detials and the current specials.
\t\t   \t: The numbers' list format could be one number in each numbers' input.
\t\t-S Read specials from file - Read more than one specials' input
\t\t   \t\x1B[01;33mExample\x1B[0m: Let's say you have alot of specials, but you don't want them in the same input,
\t\t   \t: so you use -S to read from a file with the format of one specials' input per line.
\t\t   \t: Every specials input will be used alone with the current mask, current numbers and the current details.

\t\t*~* [\x1B[01;34mOutput File\x1B[0m] *~*
\t\tIf you add -o to the startup command, you'll have the passwords in a file of your choise.
\t\t\x1B[01;33mExample\x1B[0m: -o alma-ps.txt | \x1B[01;33mExample 2\x1B[0m: -o 'alma pro.txt'

\t\t\x1B[01;31mGot it\x1B[0m? Okay then, \x1B[01;32mgo get them\x1B[0m ^_*
";
logo="\t\tAny Detail you get, add it with (\x1B[01;31m,\x1B[0m) [\x1B[01;31mex\x1B[0m: \x1B[01;34mdetail\x1B[0m\x1B[01;31m,\x1B[0m\x1B[01;34mdetail\x1B[0m\x1B[01;31m,\x1B[0m\x1B[01;34m...\x1B[0m]
\t\tNumbers and Specials come after details, so don't rush ^^

\t\t\x1B[01;31mBut!!\x1B[0m If you want to \x1B[01;31mskip details\x1B[0m and use \x1B[01;31monly Numbers\x1B[0m, then write numbers in details and press \x1B[01;34m[ENTER]\x1B[0m when asked for numbers.

";
#
#
#
function print_error(){
	>&2 echo -e "\x1B[01;31m$1\x1B[0m";
}
function print_good(){
	>&2 echo -e "\x1B[01;32m$1\x1B[0m";
}
function print_info(){
	>&2 echo -e "\x1B[01;34m$1\x1B[0m";
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
		if grep -Fxq -e "$(str_replace "$1" " " "")$newline" "$2"; then return 1; fi;
	fi;
	if [ "$2" == "$temp_path.tmp" ]; then
		echo "$(str_replace "$1" " " "")";
	fi;
	echo "$(str_replace "$1" " " "")" >> "$2";
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
	if ! [[ "$1" == "" ]]; then
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
	if ! [[ "$1" == "" ]]; then
		if ! [ "$3" == "" ]; then check_ps "$1" "$2"; return; fi;
		if [ -f "$2" ]; then
			if grep -Fxq -e "$(str_replace "$1" " " "")$newline" "$2"; then return; fi;
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
					check_ps "${now_ps::-$btween_def}" "$2";
					now_ps_=$(rev $now_ps);
					if [ "$normal_mode" == "n" ]; then check_ps "$(rev ${now_ps::-$btween_def})" "$2"; fi;
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
		if [ "$ok" == "y" ]; then check_ps "$now_ps" "$2"; fi;
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
	if [ "$1" == "" ]; then return; fi;
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
	res=0;
	res=$(($res+$((${#arr1[@]}*${#arr1[@]}))*$((${#arr3[@]}+1))));
	res=$(($res+$((${#arr2[@]}*${#arr2[@]}))*$((${#arr3[@]}+1))));
	res=$(($res+$((${#arr1[@]}*${#arr2[@]}))*$((${#arr3[@]}+1))));
	res=$(($res+$((${#arr2[@]}*${#arr1[@]}))*$((${#arr3[@]}+1))));
	res=$(($res*2));
	>&2 echo -e "\t\tYou'll have (\x1B[01;34m"$res"\x1B[0m) Passwords";
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
	for r1 in "${arr1[@]}"; do
		for ((i=0;i<$((${#arr3[@]}+1));i++)); do
			for rr1 in "${arr1[@]}"; do
				echo_it "$r1${arr3[$i]}$rr1" "$temp_path$output_file_name.tmp";
				echo_it "$(rev $r1${arr3[$i]}$rr1)" "$temp_path$output_file_name.tmp";
			done;
		done;
	done;
	for r1 in "${arr2[@]}"; do
		for ((i=0;i<$((${#arr3[@]}+1));i++)); do
			for rr1 in "${arr2[@]}"; do
				echo_it "$r1${arr3[$i]}$rr1" "$temp_path$output_file_name.tmp";
				echo_it "$(rev $r1${arr3[$i]}$rr1)" "$temp_path$output_file_name.tmp";
			done;
		done;
	done;
	for r1 in "${arr1[@]}"; do
		for ((i=0;i<$((${#arr3[@]}+1));i++)); do
			for rr1 in "${arr2[@]}"; do
				echo_it "$r1${arr3[$i]}$rr1" "$temp_path$output_file_name.tmp";
				echo_it "$(rev $r1${arr3[$i]}$rr1)" "$temp_path$output_file_name.tmp";
			done;
		done;
	done;
	for r1 in "${arr2[@]}"; do
		for ((i=0;i<$((${#arr3[@]}+1));i++)); do
			for rr1 in "${arr1[@]}"; do
				echo_it "$r1${arr3[$i]}$rr1" "$temp_path$output_file_name.tmp";
				echo_it "$(rev $r1${arr3[$i]}$rr1)" "$temp_path$output_file_name.tmp";
			done;
		done;
	done;
}
function cof(){ #Count of
	if [ "$1" == "!" ]; then
		echo "$2";
	elif [ "$1" == "@" ]; then
		echo "$3";
	elif [ "$1" == "#" ]; then
		echo "$4";
	else
		echo "0";
	fi;
}
function getitfrom(){
	declare -a arrayis=("${!1}");
	echo "${arrayis[$2]}";
}
function getpos(){
	declare -a arrayis=("${!1}");
	for ((i=0;i<${#arrayis[@]};i++)); do
		if [ "${arrayis[$i]}" == "$2" ]; then echo "$i"; return; fi;
	done;
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
		last_c=0;
		if [ "$msk" == "!" ]; then
			first_pass="$first_pass${arr1[0]}";
			arry2=(${arr1[@]})
			res=$(($res*$d_c));
			last_c=$((${#arr1[@]}-1));
		elif [ "$msk" == "@" ]; then
			first_pass="$first_pass${arr2[0]}";
			arry2=(${arr2[@]})
			res=$(($res*$n_c));
			last_c=$((${#arr2[@]}-1));
		elif [ "$msk" == "#" ]; then
			first_pass="$first_pass${arr3[0]}";
			arry2=(${arr3[@]})
			res=$(($res*$s_c));
			last_c=$((${#arr3[@]}-1));
		else
			first_pass="$first_pass$msk";
			prt=($(spl ${all_s[$i]} "|"));
			arry2=("$msk");
		fi;
		final_pass="$final_pass$(getitfrom arry2[@] $last_c)"
	done;
	all_c=${#all_s[@]};
	res=$(($res*2));
	>&2 echo -e "\t\tYou'll have (\x1B[01;34m"$res"\x1B[0m) Passwords";
	sleep 2;
	if ! [ "$6" == "" ]; then
		if [ -f "$temp_path$output_file_name.tmp" ] && ! [ "$output_file_name.tmp" == ".tmp" ]; then
			>&2 echo;
			print_info "\t\t[!]  File with this name was detected in the temp folder......";
			sleep 3;
			if [ "`head -n 1 "$temp_path$output_file_name.tmp"`" == "$first_pass" ]; then
				pass_here="`tail -n 1 "$temp_path$output_file_name.tmp"`|0";
				bpass_here=""`tail -n 2 "$temp_path$output_file_name.tmp" | head -n 1 -`;
				prt=($(spl "$pass_here" "|"));
				if [ "$(rev ${prt[0]})" == "$bpass_here" ]; then pass_here="${prt[0]}|1"; fi;
				pass2find="";
				for ((i=0;i<$all_c;i++)); do
					prt=($(spl "${all_s[$i]}" "|"));
					if [ "${prt[0]}" == "!" ]; then
						arry2=(${arr1[@]})
					elif [ "${prt[0]}" == "@" ]; then
						arry2=(${arr2[@]})
					elif [ "${prt[0]}" == "#" ]; then
						arry2=(${arr3[@]})
					else
						arry2=("${prt[0]}");
					fi;
					prt1=($(spl "${all_s[$i+1]}" "|"));
					if [ "${prt1[0]}" == "!" ]; then
						arry1=(${arr1[@]})
					elif [ "${prt1[0]}" == "@" ]; then
						arry1=(${arr2[@]})
					elif [ "${prt1[0]}" == "#" ]; then
						arry1=(${arr3[@]})
					else
						arry1=("${prt1[0]}");
					fi;
					found_arr=();
					found_arr=($(isitthis "arry2[@]" "0" "$pass_here" "$pass2find" "arry1[@]"));
					pos=$(getpos "arry2[@]" ${found_arr[1]});
					pass2find="${found_arr[0]}";
					all_s[$i]="${prt[0]}|$pos";
				done;
				prt=($(spl "$pass_here" "|"));
				if [ "${prt[1]}" == "1" ]; then pass2find="$(rev $pass2find)"; fi;
				rea="`wc -l < "$temp_path$output_file_name.tmp"`";
				>&2 echo -e "\t\tContinuing from the password (\x1B[01;34m$pass2find\x1B[0m) which is the number (\x1B[01;34m$rea\x1B[0m) and around \x1B[01;34m$(($rea*100/$res))\x1B[0m%";
			else
				>&2 echo -e "\t\t  ....";
				print_error "\t\t[!]  The mask in the current file does not match the current mask.....";
				sleep 3;
				print_error "\t\t[!]  If you continue to create the password list, your current list will be gone!";
				sleep 3;
				read -r -p "Do you want to erase the current list? [Defualt NO] Write anything for Yes >" ansr;
				if [ "$ansr" == "" ]; then exit; fi;
				rm "$temp_path$output_file_name.tmp";
			fi;
		fi;
	fi;
	last_pass="";
	until [ "$last_pass" == "$final_pass" ]; do
		now_ps="";
		for ((i=0;i<$all_c;i++)); do
			prt=($(spl ${all_s[$i]} "|"));
			if [ "${prt[1]}" -gt "$(cof ${prt[0]} $d_c $n_c $s_c)" ] || [ "${prt[1]}" == "$(cof ${prt[0]} $d_c $n_c $s_c)" ]; then
				prt1=($(spl ${all_s[$i+1]} "|"));
				all_s[$i+1]="${prt1[0]}|$((${prt1[1]}+1))";
				prt[1]="0";
				all_s[$i]="${prt[0]}|0";
			fi;
			arry2=();
			if [ "${prt[0]}" == "!" ]; then
				arry2=(${arr1[@]})
			elif [ "${prt[0]}" == "@" ]; then
				arry2=(${arr2[@]})
			elif [ "${prt[0]}" == "#" ]; then
				arry2=(${arr3[@]})
			else
				prt=($(spl ${all_s[$i]} "|"));
				arry2=("${prt[0]}");
			fi;
			now_ps="$now_ps$(getitfrom "arry2[@]" ${prt[1]})";
			if [ "$i" == "0" ]; then
				all_s[$i]="${prt[0]}|$((${prt[1]}+1))";
			fi;
		done;
		last_pass=$now_ps;
		echo_it $now_ps "$5";
		echo_it $(rev $now_ps) "$5";
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
	for ((i=0;i<args_len;i++)); do
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
		fi;
	done;
fi;
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
dtl="$dtl,";
dtl_arr=($(spl "$dtl" ","));
nmb="$nmb,";
nmb_arr=($(spl "$nmb" ","));
spcl="$spcl, ";
spcl_arr=($(spl "$spcl" ","));
if [ "${#dtl_arr[@]}" == "1" ]; then
	echo "";
	print_error "** Only one detail was given!! and that's not enough!! **";
	sleep 5;
	exit;
fi;
if [ ! -d "$temp_path" ]; then
	mkdir "$temp_path";
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
								done;
							else
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							fi;
						done;
					else
						if [ "$s2use" == "1" ]; then
							spcl_fl="`wc -l < "$spcl_file"`";
							for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
								csfl="`sed "$i3"q";d" "$spcl_file"`";
								spcl_arr=($(spl "$csfl" ","))
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							done;
						else
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
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
							done;
						else
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
						fi;
					done;
				else
					if [ "$s2use" == "1" ]; then
						spcl_fl="`wc -l < "$spcl_file"`";
						for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
							csfl="`sed "$i3"q";d" "$spcl_file"`";
							spcl_arr=($(spl "$csfl" ","))
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
						done;
					else
						mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
					fi;
				fi;
			fi;
		done;
	else
		if ! [ "$mask_v" == "" ]; then
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
								done;
							else
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							fi;
						done;
					else
						if [ "$s2use" == "1" ]; then
							spcl_fl="`wc -l < "$spcl_file"`";
							for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
								csfl="`sed "$i3"q";d" "$spcl_file"`";
								spcl_arr=($(spl "$csfl" ","))
								mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
							done;
						else
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
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
							done;
						else
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
						fi;
					done;
				else
					if [ "$s2use" == "1" ]; then
						spcl_fl="`wc -l < "$spcl_file"`";
						for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
							csfl="`sed "$i3"q";d" "$spcl_file"`";
							spcl_arr=($(spl "$csfl" ","))
							mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
						done;
					else
						mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp";
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
								done;
							else
								final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
							fi;
						done;
					else
						if [ "$s2use" == "1" ]; then
							spcl_fl="`wc -l < "$spcl_file"`";
							for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
								csfl="`sed "$i3"q";d" "$spcl_file"`";
								spcl_arr=($(spl "$csfl" ","))
								final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
							done;
						else
							final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
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
							done;
						else
							final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
						fi;
					done;
				else
					if [ "$s2use" == "1" ]; then
						spcl_fl="`wc -l < "$spcl_file"`";
						for ((i3=1;i3<$(($spcl_fl+1));i3++)); do
							csfl="`sed "$i3"q";d" "$spcl_file"`";
							spcl_arr=($(spl "$csfl" ","))
							final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
						done;
					else
						final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
					fi;
				fi;
			fi;
		fi;
	fi;
}
if [ "$normal_mode" == "n" ]; then
	dtl_arr=($(dtl_mix "dtl_arr[@]"));
	nmb_arr=($(dtl_mix "nmb_arr[@]"));
	spcl_arr=($(dtl_mix "spcl_arr[@]"));
fi;
if [ "$msk_file" == "" ] && [ "$dtl_file" == "" ] && [ "$nmb_file" == "" ] && [ "$spcl_file" == "" ]; then
	if ! [ "$mask_v" == "" ]; then
		mask_all "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v" "$temp_path$output_file_name.tmp" "n";
	else
		final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
	fi;
else
	do_files "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v";
fi;
echo_done "$output_file";
