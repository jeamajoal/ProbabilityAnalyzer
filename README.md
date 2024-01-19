# ProbabilityAnalyzer<br>
My password string analysis work geared to making focused wordlists for seperate projects.<br>
<br>
USAGE:  probanalyzer.sh -b /root/wordlists/analysis -n MyNewAnalysis -f MyPasses<br>
-b Base Directory    Used to specify the new projects working directory<br>
-n Base Name         Used to specify the name of the project folder<br>
-f File to analyze   Used to specify the password file to analyze<br>
<br>
<br>
5-20-2017<br>
At current this script will create a lot of data. Many times more space is needed than the input file you are analyzing. It can take a very long time to complete on larger lists. <br>
<br>
Script creates and ranks:<br>
mixalpha strings<br>
digitstrings<br>
possible 3-10 character words<br>
and 3-10 character mixed strings<br>
<br>
thebabies folder holds several top x percent lists that i experiment with combo and hybrid attacks with.  Let me know if you see anything you like and feel free to make suggestions.<br>
