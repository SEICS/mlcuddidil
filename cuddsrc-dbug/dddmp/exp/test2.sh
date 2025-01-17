#! /bin/sh 
#
# Check BDDs from DDDMP-1.0:
#   Load an Array of BDDs from DDDMP-1.0
#   Store them
#

EXE=
srcdir=/home/pjw/Desktop/mlcuddidil/cudd-3.0.0
where=${srcdir}/dddmp/exp
dest=.
exitval=0

echo "---------------------------------------------------------------------------"     
echo "-------------------- TESTING Load BDD from DDDMP-1.0 ----------------------"
echo "---------------------------------------------------------------------------"     
../testdddmp$EXE << END
mi
10
hlb
${where}/s27deltaDddmp1.bdd
hw
bal
${where}/s27deltaDddmp1.bdd
0 
bas
${dest}/s27deltaDddmp1.bdd.tmp
0
mq
quit
END
test $? != 1 && exitval=1
echo "----------------------------- ... RESULTS ... -----------------------------"
diff --strip-trailing-cr --brief ${dest}/s27deltaDddmp1.bdd.tmp \
     ${where}/s27deltaDddmp1.bdd.bis
test $? != 0 && exitval=1
echo "-------------------------------- ... END ----------------------------------"
rm -f ${dest}/s27deltaDddmp1.bdd.tmp
exit $exitval
