#! /bin/sh 
#
# BDD check: 
#   Load BDDs
#   Make some operations
#   Store BDDs
#

EXE=
srcdir=/home/pjw/Desktop/mlcuddidil/cudd-3.0.0
where=${srcdir}/dddmp/exp
dest=.
exitval=0

echo "---------------------------------------------------------------------------"
echo "----------------------- TESTING basic Load/Store ... ----------------------"
echo "---------------------------------------------------------------------------"
../testdddmp$EXE << END
mi
50
hlb
${where}/0or1.bdd
bl
${where}/0.bdd
0
bl
${where}/1.bdd
1
op
or
0
1
2
bs
${dest}/0or1.bdd.tmp
2
bl
${where}/2.bdd
2
bl
${where}/3.bdd
3
op
and
2
3
4
bs
${dest}/2and3.bdd.tmp
4
hlb
${where}/4xor5.bdd
bl
${where}/4.bdd
4
bl
${where}/5.bdd
5
op
xor
4
5
6
bs
${dest}/4xor5.bdd.tmp
6
mq
quit
END
test $? != 1 && exitval=1
echo "----------------------------- ... RESULTS ... -----------------------------"
diff --strip-trailing-cr --brief ${where}/0or1.bdd ${dest}/0or1.bdd.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${where}/2and3.bdd ${dest}/2and3.bdd.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${where}/4xor5.bdd ${dest}/4xor5.bdd.tmp
test $? != 0 && exitval=1
echo "-------------------------------- ... END ----------------------------------"
rm -f ${dest}/0or1.bdd.tmp ${dest}/2and3.bdd.tmp ${dest}/4xor5.bdd.tmp
exit $exitval
