#! /bin/sh 
#
# Check ADD:
#   Load an ADD
#   Store the same ADD
#   Compare the two
# (done twice on a small - 0.add - and a medium - 1.add - ADD).
#

EXE=
srcdir=/home/pjw/Desktop/mlcuddidil/cudd-3.0.0
where=${srcdir}/dddmp/exp
dest=.
exitval=0

echo "---------------------------------------------------------------------------"
echo "--------------------- TESTING Load ADD and Store ADD ----------------------"
echo "---------------------------------------------------------------------------"     
../testdddmp$EXE << END1
mi
3
hlb
${where}/0.add
al
${where}/0.add
0
as
${dest}/0.add.tmp
0
mq
mi
50
hlb
${where}/1.add
al
${where}/1.add
1
as
${dest}/1.add.tmp
1
mq
quit
END1
test $? != 1 && exitval=1
echo "----------------------------- ... RESULTS ... -----------------------------"
diff --strip-trailing-cr --brief ${where}/0.add ${dest}/0.add.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${where}/1.add ${dest}/1.add.tmp
test $? != 0 && exitval=1
echo "-------------------------------- ... END ----------------------------------"
rm -f ${dest}/0.add.tmp ${dest}/1.add.tmp
exit $exitval
