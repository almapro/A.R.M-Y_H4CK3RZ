#!/bin/bash
#
#  [Program]
#
#  CDPG v1.0(Build 24)
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

main_logo="\t\t \x1B[01;32mCommon Detailed Passwords Generator\x1B[0m - \x1B[01;31mA.R.M-Y H4CK3RZ\x1B[0m    \r\n\t\t\t\thttp://www.arm-y.org			\r\n\t \t \t \t ------------------\r\n\t\t\t\t  \x1B[01;31mUse it wisely ^^\x1B[0m"; # Our pride "This is a very emotional moment, I'm very vulnerable right now :'|"; 
>&2 echo -e "$main_logo";
final=();
spl_arr=();
spc_arr=();
pipe="no";
temp_path="/root/Desktop/AlMAPRO/cdpg_tmp/"; # Temp files path. NOTE: Do NOT set it to /tmp folder or any folder inside of it. Why?
# because if you turn off your computer you'll never continue from the last password and will start all over again.
dtl="";
nmb="";
spcl="";
dflt_spcl="_,.,+,-,(,)"; # Default special chars. free to modify ^^
output_file="";
output_file_name=""; # Do NOT modify this.
newline=$'\n'; # Do NOT modify this.
check_arr="";
short_l=0; # If = 0 or 1 then disable shortest length.
long_l=0;  # If = 0 then disable longest length.
mask_v=""; # If empty then no mask will be used.
res=1; # Passwords count.
normal_mode="n"; # By default normal mode is off so the passwords are more aggressive.
hlogo="\t\t\t\t~*[\x1B[01;34mHelp Message\x1B[0m]*~\r\n\r\n\t\tIt's too simple\r\n\r\n\t\t[\x1B[01;34mNormal stdout Mode\x1B[0m]\r\n\t\t\x1B[01;31mDetails\x1B[0m first, \x1B[01;33mExample\x1B[0m : alma,pro,leader,hacker,libya,MrRobot,anything,..\r\n\t\tThen \x1B[01;31mNumbers\x1B[0m, Phone number,birthdate,...\r\n\t\tAny \x1B[01;31mnumbers\x1B[0m that the victim may have in \x1B[01;34mhis\x1B[0m/\x1B[01;34mher\x1B[0m \x1B[01;31mlife\x1B[0m, \x1B[01;33mExample\x1B[0m: 911,12345678,87654321,..\r\n\t\tThen \x1B[01;31mSpecials\x1B[0m, Any Characters that the victim might use! Or let it empty so you'll be asked about using \x1B[01;31mspecials\x1B[0m.\r\n\r\n\t\t[\x1B[01;34mPipe Mode\x1B[0m]\r\n\t\tWrite the \x1B[01;31mdetails\x1B[0m normaly but... Add (\x1B[01;31m;\x1B[0m) at the \x1B[01;31mdetails\x1B[0m' end, then write the \x1B[01;31mnumbers\x1B[0m normaly, then the \x1B[01;31mspecials\x1B[0m\r\n\t\t(\x1B[01;31mDon't forget to write them inside\x1B[0m \x1B[01;34m''\x1B[0m) \x1B[01;33mExample\x1B[0m : 'alma,pro,leader,....;911,12345678,0912345678;-,_,.,*....'\r\n\t\tIf you write (\x1B[01;31m,\x1B[0m) in the \x1B[01;31mspecials\x1B[0m place at the end of the pipe mode input,\r\n\t\t[\x1B[01;33mEx\x1B[0m: 'detail,..;911,..;,' ], the default \x1B[01;31mspecials\x1B[0m will be used.\r\n\t\tAnd if you don't want to use \x1B[01;31mspecials\x1B[0m, then write \x1B[01;31mnothing\x1B[0m in \x1B[01;31mspecials\x1B[0m place.\r\n\t\t[\x1B[01;33mEx\x1B[0m: 'detail,...,911,...;' ]\r\n\r\n\t\tIf the script starts with:\r\n\t\t-h \tThis message will visit your screen ^^\r\n\t\t-p \tPipe mode is on and you have to write in pipe mode input.\r\n\t\t-l \tLongest password length - if you want to set a limit for the passwords length.\r\n\t\t-s \tShortest password length - if you want to set a limit for the passwords length.\r\n\t\t-n \tNormal passwords mode - Set normal_mode to on, if off, then passwords are more aggressive. (Default: Off)\r\n\t\t-m \tMask mix - if you have a specific mask for your passwords then add it after this.\r\n\t\t   \t(\x1B[01;31mYou must add the mask inside \x1B[0m\x1B[01;34m''\x1B[0m).\r\n\t\t   \t\x1B[01;34mNow the format\x1B[0m:\r\n\t\t   \t\t ! = Detail.\r\n\t\t   \t\t @ = Number.\r\n\t\t   \t\t # = Special.\r\n\t\t   \t\x1B[01;33mExample\x1B[0m: -m \x1B[01;34m'\x1B[0m#!#@#\x1B[01;34m'\x1B[0m - this will generate passwords of the format ==> 'Special Detail Special Number Special' that is '-alma-123-'. And so...\r\n\r\n\t\t*~* [\x1B[01;34mOutput File\x1B[0m] *~*\r\n\t\tIf you add -o to the startup command, you'll have the passwords in a file of your choise.\r\n\t\t\x1B[01;33mExample\x1B[0m: -o alma-ps.txt | \x1B[01;33mExample 2\x1B[0m: -o 'alma pro.txt'\r\n\r\n\t\t\x1B[01;31mGot it\x1B[0m? Okay then, \x1B[01;32mgo get them\x1B[0m ^_*\r\n";
logo="\t\tAny Detail you get, add it with (\x1B[01;31m,\x1B[0m) [\x1B[01;31mex\x1B[0m: \x1B[01;34mdetail\x1B[0m\x1B[01;31m,\x1B[0m\x1B[01;34mdetail\x1B[0m\x1B[01;31m,\x1B[0m\x1B[01;34m...\x1B[0m]\r\n\t\tNumbers and Specials come after details, so don't rush ^^\r\n\r\n\t\t\x1B[01;31mBut!!\x1B[0m If you want to \x1B[01;31mskip details\x1B[0m and use \x1B[01;31monly Numbers\x1B[0m, then write numbers in details and press \x1B[01;34m[ENTER]\x1B[0m when asked for numbers.\r\n\r\n";
function check_let(){
	ok="n";
	if [[ $1 =~ ^[A-Za-z]+$ ]]; then
		ok="y";
	fi;
	echo "$ok";
}
function get_fin_arr(){
	if [ -f "$temp_path$output_file_name-fin_array.tmp" ]; then
		arrrrr=(`cat "$temp_path$output_file_name-fin_array.tmp"`);
		rm "$temp_path$output_file_name-fin_array.tmp";
		echo "${arrrrr[@]}";
	fi;
}
function arrays_mix(){
	declare -a array1=("${!1}");
	declare -a array2=("${!2}");
	file_to_out="$temp_path$3-fin_array.tmp";
	if [ "${#array1[@]}" == "0" ]; then
		for i1 in "${array2[@]}"; do
			if [ "$(check_let "$i1")" == "y" ]; then
				r1_=($(all_cases "$i1"));
				for r1_a in "${r1_[@]}"; do
					echo_it "$r1_a" "$temp_path$3-fin_array.tmp" " " &
					if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1_a)" "$temp_path$3-fin_array.tmp" " " & fi;
				done;
			else
				echo_it "$i1" "$temp_path$3-fin_array.tmp" " " &
			fi;
			wait;
		done;
	else
		for i1 in "${array1[@]}"; do
			if [ "$(check_let "$i1")" == "y" ]; then
				r1_=($(all_cases "$i1"));
				for r1_a in "${r1_[@]}"; do
					for i2 in "${array2[@]}"; do
						if [ "$(check_let "$i2")" == "y" ]; then
							r2_=($(all_cases "$i2"));
							for r2_a in "${r2_[@]}"; do
								echo_it "$r1_a$r2_a" "$temp_path$3-fin_array.tmp" " " &
								if [ "$normal_mode" == "n" ]; then echo_it "$r1_a$(rev $r2_a)" "$temp_path$3-fin_array.tmp" " " & fi;
								if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1_a)$r2_a" "$temp_path$3-fin_array.tmp" " " & fi;
								if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1_a)$(rev $r2_a)" "$temp_path$3-fin_array.tmp" " " & fi;
							done;
						else
							echo_it "$r1_a$i2" "$temp_path$3-fin_array.tmp" " " &
							if [ "$normal_mode" == "n" ]; then echo_it "$r1_a$(rev $i2)" "$temp_path$3-fin_array.tmp" " " & fi;
							if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1_a)$i2" "$temp_path$3-fin_array.tmp" " " & fi;
							if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1_a)$(rev $i2)" "$temp_path$3-fin_array.tmp" " " & fi;
						fi;
						wait;
					done;
				done;
			else
				for i2 in "${array2[@]}"; do
					if [ "$(check_let "$i2")" == "y" ]; then
						r2_=($(all_cases "$i2"));
						for r2_a in "${r2_[@]}"; do
							echo_it "$i1$r2_a" "$temp_path$3-fin_array.tmp" " " &
							if [ "$normal_mode" == "n" ]; then echo_it "$i1$(rev $r2_a)" "$temp_path$3-fin_array.tmp" " " & fi;
							if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1_a)$r2_a" "$temp_path$3-fin_array.tmp" " " & fi;
							if [ "$normal_mode" == "n" ]; then echo_it "$(rev $r1_a)$(rev $r2_a)" "$temp_path$3-fin_array.tmp" " " & fi;
						done;
					else
						echo_it "$i1$i2" "$temp_path$3-fin_array.tmp" " " &
						if [ "$normal_mode" == "n" ]; then echo_it "$i1$(rev $i2)" "$temp_path$3-fin_array.tmp" " " & fi;
						if [ "$normal_mode" == "n" ]; then echo_it "$(rev $i1)$i2" "$temp_path$3-fin_array.tmp" " " & fi;
						if [ "$normal_mode" == "n" ]; then echo_it "$(rev $i1)$(rev $i2)" "$temp_path$3-fin_array.tmp" " " & fi;
					fi;
					wait;
				done;
			fi;
		done;
	fi;
	array1=(); # Memory gone wild 0.0
	array2=(); # Memory gone wild 0.0
}
function mask_it(){
	declare -a dtl_arr_=("${!1}");
	declare -a nmb_arr_=("${!2}");
	declare -a spcl_arr_=("${!3}");
	alna=($(echo "$4" | grep -o .));
	array_fin=();
	for let in "${alna[@]}"; do
		if [ "$let" == "#" ]; then
			array_fin=($(get_fin_arr));
			arrays_mix "array_fin[@]" "spcl_arr_[@]" "$output_file_name";array_fin=();
		elif [ "$let" == "@" ]; then
			array_fin=($(get_fin_arr));
			arrays_mix "array_fin[@]" "nmb_arr_[@]" "$output_file_name";array_fin=();
		elif [ "$let" == "!" ]; then
			array_fin=($(get_fin_arr));
			arrays_mix "array_fin[@]" "dtl_arr_[@]" "$output_file_name";array_fin=();
		else
			array_fin=($(get_fin_arr));
			let_arr=("$let");
			arrays_mix "array_fin[@]" "let_arr[@]" "$output_file_name";array_fin=();
		fi;
	done;
	array_fin=($(get_fin_arr));
	>&2 echo -e "\t\tYou'll have (\x1B[01;34m"$((${#array_fin[@]}*2))"\x1B[0m) Passwords";
	readfrom=0;
	if [ -f "$temp_path$output_file_name.tmp" ]; then
		fromwhat=(`cat "$temp_path$output_file_name.tmp"`);
		readfrom=$((${#fromwhat[@]}-1));
	fi;
	last_string="${fromwhat[$readfrom]}";
	readfrom=0;
	lenthofarray_fin=${#array_fin[@]};
	for ((i=0;i<$lenthofarray_fin;i++)); do
		if [[ "$last_string" == "${array_fin[$i]}" ]] || [[ "$last_string" == "${array_fin[$i]:1}" ]]; then
			readfrom=$i;
			break;
		fi;
	done;
	if [ ! "$readfrom" == "0" ]; then
		fromwhat=(`cat "$3"`);
		rea=$((${#fromwhat[@]}));
		fromwhat=();
		>&2 echo -e "\t\tContinuing from the password (\x1B[01;34m${array_fin[$readfrom]}\x1B[0m) which is the number (\x1B[01;34m$rea\x1B[0m) and around \x1B[01;34m$(($rea*100/$res))\x1B[0m%";
	fi;
	for array_fin1 in "${array_fin[@]:$readfrom}"; do
		echo_it "$array_fin1" "$temp_path$output_file_name.tmp";
		array_fin2="${array_fin1:1}";
		if [ "$normal_mode" == "n" ]; then echo_it "$array_fin2" "$temp_path$output_file_name.tmp"; fi;
	done;
}
function print_error(){
	>&2 echo -e "\x1B[01;31m$1\x1B[0m";
}
function print_good(){
	>&2 echo -e "\x1B[01;32m$1\x1B[0m";
}
function print_info(){
	>&2 echo -e "\x1B[01;34m$1\x1B[0m";
}
if ! [ -d "/root/Desktop/AlMAPRO" ]; then
	echo ;
	print_error "You don't have AlMAPRO folder on Desktop!!";
	sleep 2;
	print_good "Creating AlMAPRO folder....."
	mkdir /root/Desktop/AlMAPRO;
	sleep 2;
	print_good "Done."
	sleep 2;
	print_info "If you don't know why AlMAPRO folder, then follow the link *_^ http://facebook.com/A.R.M.Libya"
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
function words_back(){
        w_back=();
        declare -a wors=("${!1}");
        for w in "${wors[@]}";do
             w_back=("$w" "${w_back[@]}");
        done;
        echo "${w_back[@]}";
}
function spc(){
        echo "${!3}";
        spc_arr=("${!3}");
        spc_arr=("$1");
	declare -a words=("${!2}");
	for w in "${words[@]}";do
                if ! [[ "$w" == "$1" ]];then
		        spc_arr+=("$w");
		fi;
        done;
        ws_back=$(words_back "spc_arr[@]");
        spc_arr+=("$ws_back");
        echo "${spc_arr[@]}";
	c=${#words[@]};
	c=$(($c-1));
        echo $c;
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
array_fixed=(); # Do NOT remove this array!! It's what keeps me not destroying this Laptop -_- 
function array_fix(){
	array_fixed=();
	declare -a arr_fix=("${!1}");
	for fix in "${arr_fix[@]}"; do
		if [[ "$fix" == *"%20"* ]]; then
			fix_arr=($(echo "$fix" | grep -o .));
			skip_fix="n";
			fin_arr_fix="";
			fix_arr_fix_let="";
			for fix_ in "${fix_arr[@]}"; do
				if [ "$fin_arr_let" == " " ]; then
					skip_fix="n";
				fi;
				if [ "$skip_fix" == "n" ]; then
					fin_arr_fix="$fin_arr_fix$fin_arr_let";
					fin_arr_let="";
				else
					if [ "$fix_" == "0" ]; then
						fin_arr_let=" ";
					fi;
				fi;
				if [ "$fix_" == "%" ]; then
					skip_fix="y";
				else
					if [ "$skip_fix" == "n" ]; then
						fin_arr_let="$fix_";
					fi;
				fi;
			done;
			if ! [ "$fin_arr_let" == "" ]; then
				fin_arr_fix="$fin_arr_fix$fin_arr_let";
				fin_arr_let="";
			fi;
			array_fixed+=("$fin_arr_fix");
		else
			array_fixed+=("$fix");
		fi;
	done;
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
function echo_dn(){
	if [ -f "$2" ]; then
		if grep -Fxq -e "$(str_replace "$1" " " "")$newline" "$2"; then return 1; fi;
	fi;
	if ! [ "$1" == "" ]; then
		echo "$(str_replace "$1" " " "")" >> "$2";
	fi;
}
function arr_mix(){
	arrr=();
	declare -a arr1_=("${!1}");
	r2_="$2";
	declare -a arr3_=("${!3}");
	for r1_ in "${arr1_[@]}"; do
		for r3_ in "${arr3_[@]}"; do
			r2_arr=($(all_cases "$r2_"));
			for r2_arr_ in "${r2_arr[@]}"; do
				_now_ps="$r1_$r2_arr_$r3_";
				ta=$(echo_dn "$_now_ps" "$4");
				at=$(echo_it "$_now_ps" "$temp_path$output_file_name.tmp");
				if ! [ "$at" == "" ]; then echo "$at"; fi;
				_now_ps="$r1_$(rev $r2_arr_)$r3_";
				ta=$(echo_dn "$_now_ps" "$4");
				at=$(echo_it "$_now_ps" "$temp_path$output_file_name.tmp");
				if ! [ "$at" == "" ]; then echo "$at"; fi;
			done;
		done;
	done;
}
_r1_=();
function final_mix(){
	declare -a arr1=("${!1}");
	declare -a arr2=("${!2}");
	declare -a arr3=("${!3}");
	for rr1 in "${arr1[@]}"; do
		if [ "${#_r1_[@]}" == "0" ]; then
			arr_mix "arr3[@]" "$rr1" "arr3[@]" "$temp_path$output_file_name-D.tmp";
			_r1_=(`cat "$temp_path$output_file_name-D.tmp"`);
		else
			arr_mix "_r1_[@]" "$rr1" "arr3[@]" "$temp_path$output_file_name-D.tmp";
			_r1_=(`cat "$temp_path$output_file_name-D.tmp"`);
		fi;
	done;
	_r1_=();
	for rr2 in "${arr2[@]}"; do
		if [ "${#_r1_[@]}" == "0" ]; then
			arr_mix "arr3[@]" "$rr2" "arr3[@]" "$temp_path$output_file_name-N.tmp";
			_r1_=(`cat "$temp_path$output_file_name-N.tmp"`);
		else
			arr_mix "_r1_[@]" "$rr2" "arr3[@]" "$temp_path$output_file_name-N.tmp";
			_r1_=(`cat "$temp_path$output_file_name-N.tmp"`);
		fi;
	done;
	_r1_=();
	for ii in "${arr1[@]}"; do
		iii=($(all_cases "$ii"));
		for iiii in "${iii[@]}"; do
			for s1 in "${arr3[@]}"; do
				for s2 in "${arr3[@]}"; do
					for s3 in "${arr3[@]}"; do
						for nn in "${arr2[@]}"; do
							echo_it "$s1$iiii$s2$nn$s3" "$temp_path$output_file_name.tmp";
							if [ "$normal_mode" == "n" ]; then echo_it "$s1$(rev $iiii)$s2$nn$s3" "$temp_path$output_file_name.tmp"; fi;
							if [ "$normal_mode" == "n" ]; then echo_it "$s1$nn$s2$iiii$s3" "$temp_path$output_file_name.tmp"; fi;
							if [ "$normal_mode" == "n" ]; then echo_it "$s1$nn$s2$(rev $iiii)$s3" "$temp_path$output_file_name.tmp"; fi;
						done;
					done;
				done;
			done;
		done;
	done;
}
function mask_more(){
	declare -a arr_1=("${!1}");
	declare -a arr_2=("${!2}");
	declare -a arr_3=("${!3}");
	alna_=($(echo "$4" | grep -o .));
	array_fin_=();
	for let in "${alna_[@]}"; do
		if [ "$let" == "#" ]; then
			array_fin_=($(get_fin_arr));
			arrays_mix "array_fin_[@]" "arr_3[@]"  "$output_file_name";array_fin_=();
		elif [ "$let" == "@" ]; then
			array_fin_=($(get_fin_arr));
			arrays_mix "array_fin_[@]" "arr_2[@]"  "$output_file_name";array_fin_=();
		elif [ "$let" == "!" ]; then
			array_fin_=($(get_fin_arr));
			arrays_mix "array_fin_[@]" "arr_1[@]"  "$output_file_name";array_fin_=();
		else
			array_fin_=($(get_fin_arr));
			let_arr_=("$let");
			arrays_mix "array_fin_[@]" "let_arr_[@]"  "$output_file_name";array_fin_=();
		fi;
	done;
	array_fin_=($(get_fin_arr));
	for array_fin1 in "${array_fin_[@]}"; do
		echo_it "$array_fin1" "$5";
		array_fin2="${array_fin1:1}";
		if [ "$normal_mode" == "n" ]; then echo_it "$array_fin2" "$5"; fi;
	done;
	arr_1=(); # Memory gone wild 0.0
	arr_2=(); # Memory gone wild 0.0
	arr_3=(); # Memory gone wild 0.0
	alna_=(); # Memory gone wild 0.0
	array_fin_=(); # Memory gone wild 0.0
}
function arrays_bind(){
	declare -a array1=("${!1}");
	declare -a array2=("${!2}");
	readfrom=0;
	readfrom2=0;
	fromwhat=();
	res=$4;
	if [ -f "$3" ]; then
		fromwhat=(`cat "$3"`);
		readfrom=$((${#fromwhat[@]}-1));
	fi;
	last_string="${fromwhat[$readfrom]}";
	readfrom=0;
	if [ "${#array1[@]}" == "0" ]; then
		lenthofarray2=${#array2[@]};
		for ((i=0;i<$lenthofarray2;i++)); do
			if [[ "$last_string" == "${array2[$i]}"* ]]; then
				readfrom=$i;
				break;
			fi;
		done;
	else
		lenthofarray1=${#array1[@]};
		for ((i=0;i<$lenthofarray1;i++)); do
			if [[ "$last_string" == "${array1[$i]}"* ]]; then
				readfrom=$i;
				break;
			fi;
		done;
		lenthofarray2=${#array2[@]};
		for ((i=0;i<$lenthofarray2;i++)); do
			if [ "$last_string" == "${array1[$readfrom]}${array2[$i]}" ]; then
				readfrom2=$i;
				break;
			fi;
		done;
	fi;
	if [ ! "$readfrom" == "0" ] && [ ! "$readfrom2" == "0" ]; then
		fromwhat=(`cat "$3"`);
		rea=$((${#fromwhat[@]}));
		fromwhat=();
		>&2 echo -e "\t\tContinuing from the password (\x1B[01;34m${array1[$readfrom]}${array2[$readfrom2]}\x1B[0m) which is the number (\x1B[01;34m$rea\x1B[0m) and around \x1B[01;34m$(($rea*100/$res))\x1B[0m%";
	fi;
	if [ "${#array1[@]}" == "0" ]; then
		for i1 in "${array2[@]:$readfrom}"; do
			echo_it "$i1" "$3" " " &
		done;
		wait;
	else
		for i1 in "${array1[@]:$readfrom}"; do
			for i2 in "${array2[@]:$readfrom2}"; do
				echo_it "$i1$i2" "$3" " " &
			done;
			wait;
		done;
	fi;
	array1=(); # Memory gone wild 0.0
	array2=(); # Memory gone wild 0.0
}
function check_path(){
	foo="$1";
	if [ -f "$foo*.tmp" ]; then
		check_path "$foo.tmp";
	else
		echo "$foo-";
	fi;
}
function does_it_need_files(){ # The name matters :P
	path_of_files="$1";
	current_count_c=$2;
	current_count_=0;
	c_leno_=0;
	masks_arr_temp1=();
	masks_arr_temp2=();
	for ((i=0;i<$(($current_count_c+1));i++)); do
		if [ $c_leno_ == 2 ]; then
			if [ -f "${c_files_arr[0]}" ]; then masks_arr_temp1=(`cat "${c_files_arr[0]}"`); else >&2 echo -e "Opps :( File ==> ${c_files_arr[0]}"; fi;
			if [ -f "${c_files_arr[1]}" ]; then masks_arr_temp2=(`cat "${c_files_arr[1]}"`); else >&2 echo -e "Opps :( File ==> ${c_files_arr[1]}"; fi;
			arrays_bind "masks_arr_temp1[@]" "masks_arr_temp2[@]" "$(check_path $path_of_files)$current_count_.tmp" "$res" &
			c_leno_=0;
			current_count_=$(($current_count_+1));
			for c_file in "${c_files_arr[@]}"; do
				if [ -f "$c_file" ]; then
					rm "$c_file";
				fi;
			done;
			c_files_arr=();
		fi;
		c_files_arr+=("$path_of_files$i.tmp");
		c_leno_=$(($c_leno_+1));
	done;
	if [ $c_leno_ -gt 0 ]; then
		if [ "${#c_files_arr[@]}" == "2" ]; then
			if [ -f "${c_files_arr[0]}" ]; then masks_arr_temp1=(`cat "${c_files_arr[0]}"`); fi;
			if [ -f "${c_files_arr[1]}" ]; then masks_arr_temp2=(`cat "${c_files_arr[1]}"`); fi;
			arrays_bind "masks_arr_temp1[@]" "masks_arr_temp2[@]" "$(check_path $path_of_files)$current_count_.tmp" "$res" &
			for c_file in "${c_files_arr[@]}"; do
				if [ -f "$c_file" ]; then
					rm "$c_file";
				fi;
			done;
		elif [ "${#c_files_arr[@]}" == "1" ]; then
			if [ -f "${c_files_arr[0]}" ]; then
				masks_arr_temp2=(`cat "${c_files_arr[0]}"`);
				for masks_arr_temp1_f in "${masks_arr_temp2[@]}"; do
					echo_it "$masks_arr_temp1_f" "$(check_path $path_of_files)$current_count_.tmp" " ";
				done;
				rm "${c_files_arr[0]}";
			fi;
		fi;
		c_leno_=0;
		c_files_arr=();
	fi;
	wait;
	if [ $current_count_ -gt 1 ]; then
		does_it_need_files "$(check_path "$path_of_files")" "$current_count_" "$3";
	elif [ $current_count_ == 1 ]; then
		if [ -f "$(check_path $path_of_files)0.tmp" ]; then masks_arr_temp1=(`cat "$(check_path $path_of_files)0.tmp"`); rm "$(check_path $path_of_files)0.tmp"; fi;
		if [ -f "$(check_path $path_of_files)1.tmp" ]; then masks_arr_temp2=(`cat "$(check_path $path_of_files)1.tmp"`); rm "$(check_path $path_of_files)1.tmp"; fi;
		arrays_bind "masks_arr_temp1[@]" "masks_arr_temp2[@]" "$temp_path$3.tmp" "$res";
	elif [ $current_count_ == 0 ]; then
		if [ -f "$(check_path $path_of_files)0.tmp" ]; then masks_arr_temp1=(`cat "$(check_path $path_of_files)0.tmp"`); rm "$(check_path $path_of_files)0.tmp"; fi;
		arrays_bind "" "masks_arr_temp1[@]" "$temp_path$3.tmp" "$res";
	fi;
}
function do_mask(){
	declare -a arr_fin=("${!1}");
	number=$2;
	till=$3
	los="$4";
	count_it=0;
	pass="$5";
	for ((i=0;i<$(($till+1));i++)); do
		if ! [ "$count_it" == "$number" ]; then
			for arrfin in "${arr_fin[@]}"; do
				pass="$(str_replace "$pass" "$los$i$los" "$arrfin")"
			done;
			count_it=$i;
		else
			echo "$pass"
		fi;
	done;
}
function mask_all(){
	declare -a arr1=("${!1}");
	declare -a arr2=("${!2}");
	declare -a arr3=("${!3}");
	mask_arr=($(echo "$4" | grep -o .));
	mask_aw="";
	dtl_c=${#arr1[@]};
	nmb_c=${#arr2[@]};
	spcl_c=${#arr3[@]};
	arr1_s=();
	for ((i=0;i<$(($dtl_c+1));i++)); do
		arr1_s+=("${arr1[0]}");
	done;
	arr2_s=();
	for ((i=0;i<$(($nmb_c+1));i++)); do
		arr2_s+=("${arr2[0]}");
	done;
	arr3_s=();
	for ((i=0;i<$(($spcl_c+1));i++)); do
		arr3_s+=("${arr3[0]}");
	done;
	mc="";
	count_1=1;
	dtl_pos=0;
	nmb_pos=0;
	spcl_pos=0;
	dtl_pos_n=0;
	nmb_pos_n=0;
	spcl_pos_n=0;
	d_c=0;
	n_c=0;
	s_c=0;
	until [ "${d_counter[$dtl_c]}" == "$dtl_c" ]; do
		now_ps="";
		d_now_c=0;
		d_c=0;
		n_c=0;
		s_c=0;
		for msk in "${mask_arr[@]}"; do
			if [ "$msk" == "!" ]; then
				if [ "${d_counter[$d_now_c]}" == "$dtl_c" ]; then
					d_counter[$d_now_c]=0;
					d_counter[$(($d_now_c+1))]=$((${d_counter[$(($d_now_c+1))]}+1))
				fi;
				now_ps="$now_ps${arr1[${d_counter[$d_now_c]}]}";
				d_counter[$d_now_c]=$((${d_counter[$d_now_c]}+1));
				d_now_c=$(($d_now_c+1));
				d_c=$(($d_c+1));
			elif [ "$msk" == "@" ]; then
				
				n_c=$(($n_c+1));
			elif [ "$msk" == "#" ]; then
				
				s_c=$(($s_c+1));
			else
				now_ps="$now_ps$msk"
			fi;
		done;
		d_now_c=0;
		echo $now_ps;
		read;
	done;
	exit;
	until [ "${arr1_s[-1]}" == "${arr1[-1]}" ] && [ "${arr2_s[-1]}" == "${arr2[-1]}" ] && [ "${arr3_s[-1]}" == "${arr3[-1]}" ]; do
		d_="";
		n_="";
		s_="";
		for m in "${mask_arr[@]}"; do
			d_="$d_$m";
			n_="$n_$m";
			s_="$s_$m";
			if [ "$m" == "!" ]; then
				if [ "$d_c" == "$dtl_pos" ]; then
					echo "";
				else
					echo "";
				fi;
			elif [ "$m" == "@" ]; then
				echo "";
			elif [ "$m" == "#" ]; then
				echo "";
			else
				echo "";
			fi;
		done;
		d_c=0;
		n_c=0;
		s_c=0;
		if [ "${arr1_s[$dtl_pos]}" == "${arr1[-1]}" ]; then
			if [ ! "$dtl_pos" == "$dtl_c" ]; then
				arr1_s[$dtl_pos]="${arr1[0]}";
				dtl_pos=$(($dtl_pos+1));
			fi;
		else
			arr1_s[$dtl_pos]="${arr1[$dtl_pos_n]}";
			dtl_pos_n=$(($dtl_pos_n+1));
		fi;
		echo_it "$mc" "$temp_files_path$output_file_name.tmp";
		mc="$mask_v";
		for arr2_1 in "${arr2[@]}"; do
			mc="$(str_replace "$mc" "@" "$arr2_1")";
		done;
		for arr3_1 in "${arr3[@]}"; do
			mc="$(str_replace "$mc" "#" "$arr3_1")";
		done;
		for arr1_1 in "${arr1[@]}"; do
			mc="$(str_replace "$mc" "!" "$arr1_1")";
			arr1_s[0]="${arr1[$count_1]}";
		done;
		count_1=$(($count_1+1));
		echo "$mc";
	done;
	echo "${arr1_s[-1]}";
}
if ! [ "$1" == "" ];then
	if [ "$1" == "-h" ]; then
		>&2 echo -e "$hlogo";
		sleep 5;
		exit;
	elif [ "$1" == "-t" ]; then
		arr1_=("alma" "pro" "leader");
		arr2_=("0" "1" "2");
		arr3_=("-" "+" "=");
		mask_all "arr1_[@]" "arr2_[@]" "arr3_[@]" "!!!";
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
		fi;
	done;
fi;
if [ "$pipe" == "no" ]; then
	>&2 echo -e $logo;
	read -r -p "Details Please > " dtl;
	if [ "$dtl" == "" ] ;then
		print_info "\t\tDid you know that empty details' line will never make a passwords list 0.0?\r\n\t\tPlease enter a minimum of two details Or I'll kill myself again.\r\n\r\n\r\n";
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
	read -r -p "Numbers Please > " nmb;
	read -r -p "Specials Please > " spcl;
	if [ "$spcl" == "" ]; then
		read -r -p "Do you want to use the default Specials? [ Write anything for NO or nothing for YES ] > " ansr;
		if [ "$ansr" == "" ]; then
			spcl="$dflt_spcl";
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
dtl="$dtl, ";
spl_arr=($(spl "$dtl" ","));
dtl_arr=("${spl_arr[@]}");
array_fix "dtl_arr[@]";dtl_arr=("${array_fixed[@]}");
nmb_="$nmb, ";
spl_arr=($(spl "$nmb_" ","));
nmb_arr=("${spl_arr[@]}");
array_fix "nmb_arr[@]";nmb_arr=("${array_fixed[@]}");
spcl_="$spcl, ";
spl_arr=($(spl "$spcl_" ","));
spcl_arr=("${spl_arr[@]}");
array_fix "spcl_arr[@]";spcl_arr=("${array_fixed[@]}");
spcl_arr+=(" ");
if [ "${#dtl_arr[@]}" == "1" ]; then
	echo "";
	print_error "** Only one detail was given!! and that's not enough!! **";
	sleep 5;
	exit;
fi;
if [ ! -d "$temp_path" ]; then
	mkdir "$temp_path";
else
	if [[ "$(ls -A $temp_path)" == *"$output_file_name.tmp"* ]]; then
		file_arr=("$output_file_name-D.tmp" "$output_file_name-N.tmp");
		for fff in "${file_arr[@]}"; do
			if [ -f "$temp_path$fff" ]; then
				if [ "$fff" == "-"* ]; then
					rm -- "$temp_path$fff";
				else
					rm "$temp_path$fff";
				fi;
			fi;
		done;
	fi;
fi;
print_good "\t\tNow will start working ^^";
sleep 3;
if ! [ "$mask_v" == "" ]; then
	leno_=($(echo "$mask_v" | grep -o .));
	if [ ${#leno_[@]} == 5 ] || [ ${#leno_[@]} -lt 5 ]; then
		mask_it "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$mask_v";
	else
		c_leno_=0;
		current_mask="";
		masks_arr_temp1=();
		masks_arr_temp2=();
		current_count=0;
		for lenoo_ in "${leno_[@]}"; do
			if [ $c_leno_ == 4 ]; then
				mask_more "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$current_mask" "$temp_path$output_file_name-$current_count.tmp";
				current_count=$(($current_count+1));
				current_mask="";
				c_leno_=0;
			fi;
			current_mask="$current_mask$lenoo_";
			c_leno_=$(($c_leno_+1));
		done;
		if [ $c_leno_ -gt 0 ]; then
			mask_more "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]" "$current_mask" "$temp_path$output_file_name-$current_count.tmp";
		fi;
		res=1;
		for ((i=0;i<$(($current_count+1));i++)); do
			passwords_todo=(`cat "$temp_path$output_file_name-$i.tmp"`);
			res=$(($res*${#passwords_todo[@]}));
		done;
		passwords_todo=();
		>&2 echo -e "\t\tYou'll have (\x1B[01;34m"$res"\x1B[0m) Passwords";
		does_it_need_files "$temp_path$output_file_name-" "$current_count" "$output_file_name";
	fi;
else
	final_mix "dtl_arr[@]" "nmb_arr[@]" "spcl_arr[@]";
fi;
echo_done "$output_file";
