#! /bin/sh 
#
# Check CNF (short check - only NodeByNode method involved):
#   Load BDDs
#   Store corresponding CNF
#   Read CNF
#   Store corresponding BDD
#   Compare original and final BDDs
#

EXE=
srcdir=/home/pjw/Desktop/mlcuddidil/cudd-3.0.0
where=${srcdir}/dddmp/exp
dest=.
exitval=0

echo "---------------------------------------------------------------------------"     
echo "--------------------- TESTING Load BDD and Store CNF ----------------------"
echo "---------------------------------------------------------------------------"     
../testdddmp$EXE << END1
mi
150
hlc
${where}/4.cnf.bis
bl
${where}/4.bdd
0
cs
${dest}/4.cnf.tmp
0
N
100
mq
quit
END1
test $? != 1 && exitval=1
echo "--------------------- TESTING Load CNF and Store BDD ----------------------"
../testdddmp$EXE << END2
mi
150
hlc
${where}/4.cnf.bis
cl
${dest}/4.cnf.tmp
0
hw
bs
${dest}/4.bdd.tmp
0
mq
quit
END2
test $? != 1 && exitval=1
echo "----------------------------- ... RESULTS ... -----------------------------"
diff --strip-trailing-cr --brief ${where}/4.cnf.bis ${dest}/4.cnf.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${where}/4.bdd.bis1 ${dest}/4.bdd.tmp
test $? != 0 && exitval=1
echo "-------------------------------- ... END ----------------------------------"
rm -f ${dest}/4.cnf.tmp ${dest}/4.bdd.tmp
exit $exitval
