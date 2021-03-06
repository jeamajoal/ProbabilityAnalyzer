#!/bin/bash
basedir=notset1234
basename=notset1234
mypasswds=notset1234

while getopts "b:n:f:" option
do
 case "${option}"
 in
 b) basedir=${OPTARG};;
 n) basename=${OPTARG};;
 f) mypasswds=${OPTARG};;
\?) echo ""
echo "USAGE:  analstrings.sh -b /root/wordlists/analysis -n MyNewAnalysis -f MyPasses"
echo "-b Base Directory    Used to specify the new projects working directory"
echo "-n Base Name         Used to specify the name of the project folder"
echo "-f File to analyze   Used to specify the password file to analyze">&2; exit 1;;
 :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
 *) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
 esac
done

if [ "$basedir" = "notset1234" ]
then 
basedir="$(pwd)"
fi

if [ "$basename" = "notset1234" ]
then 
echo "-n is Required"
echo "USAGE:  analstrings.sh -b /root/wordlists/analysis -n MyNewAnalysis -f MyPasses"
echo "-b Base Directory    Used to specify the new projects working directory"
echo "-n Base Name         Used to specify the name of the project folder"
echo "-f File to analyze   Used to specify the password file to analyze"
exit 1
fi

if [ "$mypasswds" = "notset1234" ]
then 
echo "-f is Required"
echo "USAGE:  analstrings.sh -b /root/wordlists/analysis -n MyNewAnalysis -f MyPasses"
echo "-b Base Directory    Used to specify the new projects working directory"
echo "-n Base Name         Used to specify the name of the project folder"
echo "-f File to analyze   Used to specify the password file to analyze"
exit 1
fi

if [ ! -e "$mypasswds" ] 
then
echo "$mypasswds doesn't exist!!"
exit 1
fi

if [ ! -f "$mypasswds" ] 
then
echo "$mypasswds is not a file!!"
exit 1
fi

if [ ! -r "$mypasswds" ] 
then
echo "You dont have permission to read $mypasswds !!"
exit 1
fi

[ -d  /TMPS ] && rm /TMPS -R
[ -d $basedir/$basename ] && rm $basedir/$basename -R

mkdir /TMPS
mkdir $basedir/$basename
mkdir $basedir/$basename/statistical
mkdir $basedir/$basename/rawdata
mkdir $basedir/$basename/thebabies

cd $basedir/$basename

tp="_top_10perc"
fip="_top_20perc"
tfp="_top_33perc"
thp="_top_50perc"
uc="_uniq_count"
u="_uniq"

currentfile=mixalphastrings
egrep -oa '[a-zA-Z]{3,25}' $mypasswds > rawdata/$currentfile
sort -S 100 rawdata/$currentfile --parallel=8 -T /TMPS| uniq -c | sort -S 100 -h -r --parallel=8 -T /TMPS> statistical/$currentfile$uc
sort -S 100 -u --parallel=8 -T /TMPS rawdata/$currentfile > statistical/$currentfile$u
head -n $(( $(wc -l < statistical/$currentfile$u) / 10 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tp
head -n $(( $(wc -l < statistical/$currentfile$u) / 5 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$fip
head -n $(( $(wc -l < statistical/$currentfile$u) / 3 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tfp
head -n $(( $(wc -l < statistical/$currentfile$u) / 2 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$thp
echo "TOTAL UNIQ $currentfile STRINGS"
wc -l statistical/$currentfile$u
echo "Top 10 $currentfile"
head -n 10 statistical/$currentfile$uc

currentfile=digitstrings
egrep -oa '[0-9]{3,8}' $mypasswds > rawdata/$currentfile
sort -S 100 rawdata/$currentfile --parallel=8 -T /TMPS| uniq -c | sort -S 100 -h -r --parallel=8 -T /TMPS> statistical/$currentfile$uc
sort -S 100 -u --parallel=8 -T /TMPS rawdata/$currentfile > statistical/$currentfile$u
head -n $(( $(wc -l < statistical/$currentfile$u) / 10 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tp
head -n $(( $(wc -l < statistical/$currentfile$u) / 5 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$fip
head -n $(( $(wc -l < statistical/$currentfile$u) / 3 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tfp
head -n $(( $(wc -l < statistical/$currentfile$u) / 2 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$thp
echo "TOTAL UNIQ $currentfile STRINGS"
wc -l statistical/$currentfile$u
echo "Top 10 $currentfile"
head -n 10 statistical/$currentfile$uc

currentfile=3charfound
cat $mypasswds |egrep -oa '.{3}' > rawdata/$currentfile
cat $mypasswds | cut -c 2- | egrep -oa '.{3}' >> rawdata/$currentfile
cat $mypasswds | cut -c 3- | egrep -oa '.{3}' >> rawdata/$currentfile
sort -S 100 rawdata/$currentfile --parallel=8 -T /TMPS| uniq -c | sort -S 100 -h -r --parallel=8 -T /TMPS> statistical/$currentfile$uc
sort -S 100 -u --parallel=8 -T /TMPS rawdata/$currentfile > statistical/$currentfile$u
head -n $(( $(wc -l < statistical/$currentfile$u) / 10 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tp
head -n $(( $(wc -l < statistical/$currentfile$u) / 5 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$fip
head -n $(( $(wc -l < statistical/$currentfile$u) / 3 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tfp
head -n $(( $(wc -l < statistical/$currentfile$u) / 2 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$thp
echo "TOTAL UNIQ $currentfile STRINGS"
wc -l statistical/$currentfile$u
echo "Top 10 $currentfile"
head -n 10 statistical/$currentfile$uc

currentfile=4charfound
cat $mypasswds |egrep -oa '.{4}' > rawdata/$currentfile
cat $mypasswds | cut -c 2- | egrep -oa '.{4}' >> rawdata/$currentfile
cat $mypasswds | cut -c 3- | egrep -oa '.{4}' >> rawdata/$currentfile
cat $mypasswds | cut -c 4- | egrep -oa '.{4}' >> rawdata/$currentfile
sort -S 100 rawdata/$currentfile --parallel=8 -T /TMPS| uniq -c | sort -S 100 -h -r --parallel=8 -T /TMPS> statistical/$currentfile$uc
sort -S 100 -u --parallel=8 -T /TMPS rawdata/$currentfile > statistical/$currentfile$u
head -n $(( $(wc -l < statistical/$currentfile$u) / 10 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tp
head -n $(( $(wc -l < statistical/$currentfile$u) / 5 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$fip
head -n $(( $(wc -l < statistical/$currentfile$u) / 3 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tfp
head -n $(( $(wc -l < statistical/$currentfile$u) / 2 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$thp
echo "TOTAL UNIQ $currentfile STRINGS"
wc -l statistical/$currentfile$u
echo "Top 10 $currentfile"
head -n 10 statistical/$currentfile$uc

currentfile=5charfound
cat $mypasswds |egrep -oa '.{5}' > rawdata/$currentfile
cat $mypasswds | cut -c 2- | egrep -oa '.{5}' >> rawdata/$currentfile
cat $mypasswds | cut -c 3- | egrep -oa '.{5}' >> rawdata/$currentfile
cat $mypasswds | cut -c 4- | egrep -oa '.{5}' >> rawdata/$currentfile
cat $mypasswds | cut -c 5- | egrep -oa '.{5}' >> rawdata/$currentfile
sort -S 100 rawdata/$currentfile --parallel=8 -T /TMPS| uniq -c | sort -S 100 -h -r --parallel=8 -T /TMPS> statistical/$currentfile$uc
sort -S 100 -u --parallel=8 -T /TMPS rawdata/$currentfile > statistical/$currentfile$u
head -n $(( $(wc -l < statistical/$currentfile$u) / 10 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tp
head -n $(( $(wc -l < statistical/$currentfile$u) / 5 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$fip
head -n $(( $(wc -l < statistical/$currentfile$u) / 3 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tfp
head -n $(( $(wc -l < statistical/$currentfile$u) / 2 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$thp
echo "TOTAL UNIQ $currentfile STRINGS"
wc -l statistical/$currentfile$u
echo "Top 10 $currentfile"
head -n 10 statistical/$currentfile$uc

currentfile=6charfound
cat $mypasswds |egrep -oa '.{6}' > rawdata/$currentfile
cat $mypasswds | cut -c 2- | egrep -oa '.{6}' >> rawdata/$currentfile
cat $mypasswds | cut -c 3- | egrep -oa '.{6}' >> rawdata/$currentfile
cat $mypasswds | cut -c 4- | egrep -oa '.{6}' >> rawdata/$currentfile
cat $mypasswds | cut -c 5- | egrep -oa '.{6}' >> rawdata/$currentfile
cat $mypasswds | cut -c 6- | egrep -oa '.{6}' >> rawdata/$currentfile
sort -S 100 rawdata/$currentfile --parallel=8 -T /TMPS| uniq -c | sort -S 100 -h -r --parallel=8 -T /TMPS> statistical/$currentfile$uc
sort -S 100 -u --parallel=8 -T /TMPS rawdata/$currentfile > statistical/$currentfile$u
head -n $(( $(wc -l < statistical/$currentfile$u) / 10 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tp
head -n $(( $(wc -l < statistical/$currentfile$u) / 5 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$fip
head -n $(( $(wc -l < statistical/$currentfile$u) / 3 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$tfp
head -n $(( $(wc -l < statistical/$currentfile$u) / 2 )) statistical/$currentfile$uc | cut -c 9- > thebabies/$currentfile$thp
echo "TOTAL UNIQ $currentfile STRINGS"
wc -l statistical/$currentfile$u
echo "Top 10 $currentfile"
head -n 10 statistical/$currentfile$uc
