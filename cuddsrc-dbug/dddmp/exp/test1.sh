#! /bin/sh 
#
# Check Header Load/Store for BDD/ADD/CNFs:
#   Load Header
#   Write Information on Standard Output
#

EXE=
srcdir=/home/pjw/Desktop/mlcuddidil/cudd-3.0.0
where=${srcdir}/dddmp/exp
exitval=0

echo "---------------------------------------------------------------------------"
echo "--------------------- TESTING Load and Write Header -----------------------"
echo "---------------------------------------------------------------------------"
../testdddmp$EXE << END
mi
50
hlb
${where}/4.bdd
hw
hlb
${where}/0.add
hw
hlc
${where}/4.cnf
hw
mq
quit
END
test $? != 1 && exitval=1
echo "-------------------------------- ... END ----------------------------------"
exit $exitval
