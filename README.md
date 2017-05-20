# analstrings
My password string analysis work geared to making focused wordlists for seperate projects.

USAGE:  analstrings.sh -b /root/wordlists/analysis -n MyNewAnalysis -f MyPasses
-b Base Directory    Used to specify the new projects working directory
-n Base Name         Used to specify the name of the project folder
-f File to analyze   Used to specify the password file to analyze


5-20-2017
At current this script will create a lot of data. Many times more space is needed that the input file you are analyzing. It can take a very long time to complete on larger lists. 

Script creates and ranks:
mixalpha strings
digitstrings
possible 3-10 character words
and 3-10 character mixed strings

thebabies folder holds several top x percent lists that i experiment with combo and hybrid attacks with.  Let me know if you see anything you like and feel free to make suggestions.
