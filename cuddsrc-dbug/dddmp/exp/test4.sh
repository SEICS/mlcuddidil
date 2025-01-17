#! /bin/sh 
#
# BDD Check:
#   Load BDDs
#   Make some operations (with reordering)
#   Store BDDs
#

EXE=
srcdir=/home/pjw/Desktop/mlcuddidil/cudd-3.0.0
where=${srcdir}/dddmp/exp
dest=.
exitval=0

echo "---------------------------------------------------------------------------"     
echo "---------- TESTING Load/Store with sifting, varnames & varauxids ----------"
echo "---------------------------------------------------------------------------"     
../testdddmp$EXE << END1
mi
50
onl
${where}/varnames.ord
bl
${where}/4.bdd
4
oil
${where}/varauxids.ord
bs
${dest}/4a.bdd.tmp
4
dr
4
bs
${dest}/4b.bdd.tmp
4
mq
quit
END1
test $? != 1 && exitval=1
echo "------------------------- ... END PHASE 1 ... -----------------------------"
../testdddmp$EXE << END2
mi
50
onl
${where}/varnames.ord
slm
3
bl
${dest}/4b.bdd.tmp
4
oil
${where}/varauxids.ord
bs
${dest}/4c.bdd.tmp
4
mq
quit
END2
test $? != 1 && exitval=1
echo "----------------------------- ... RESULTS ... -----------------------------"
diff --strip-trailing-cr --brief ${where}/4.bdd ${dest}/4a.bdd.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${dest}/4a.bdd.tmp ${dest}/4c.bdd.tmp
test $? != 0 && exitval=1
echo "-------------------------------- ... END ----------------------------------"
rm -f ${dest}/4a.bdd.tmp ${dest}/4c.bdd.tmp
exit $exitval
