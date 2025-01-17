#! /bin/sh 
#
# Check CNF (long check - all methods involved):
#   Load BDDs
#   Store corresponding CNF in different format:
#     NodeByNode method -> file 4.node1.tmp
#     MaxtermByMaxterm -> file 4.max1.tmp
#     Best with different options:
#       MaxEdge=-1 MaxPath= 0 -> similar to NodeByNode -> file 4.node2.tmp
#       MaxEdge= 0 MaxPath=-1 -> similar to NodeByNode -> file 4.node3.tmp
#       MaxEdge=-1 MaxPath=-1 -> = MaxtermByMaxterm -> file 4.max2.tmp
#       MaxEdge= 1 MaxPath=-1 -> = Original Best -> file 4.best1.tmp
#       MaxEdge= 1 MaxPath= 2 -> = Original Best, With Path Shorter than 3 
#                                  file 4.best2.tmp
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
${dest}/4.node1.tmp
0
N
100
cs
${dest}/4.max1.tmp
0
M
100
cs
${dest}/4.node2.tmp
0
B
-1
0
100
cs
${dest}/4.node3.tmp
0
B
0
-1
100
cs
${dest}/4.max2.tmp
0
B
-1
-1
100
cs
${dest}/4.best1.tmp
0
B
1
-1
100
cs
${dest}/4.best2.tmp
0
B
1
2
100
mq
quit
END1
test $? != 1 && exitval=1
echo "---------------------------------------------------------------------------"     
echo "--------------------- TESTING Load CNF and Store BDD ----------------------"
echo "---------------------------------------------------------------------------"     
../testdddmp$EXE << END2
mi
150
hlc
${dest}/4.node2.tmp
cl
${dest}/4.node2.tmp
0
hw
bs
${dest}/4.node2.bdd.tmp
0
mq
quit
END2
test $? != 1 && exitval=1
../testdddmp$EXE << END3
mi
150
hlc
${dest}/4.node3.tmp
cl
${dest}/4.node3.tmp
0
hw
bs
${dest}/4.node3.bdd.tmp
0
mq
quit
END3
test $? != 1 && exitval=1
../testdddmp$EXE << END4
mi
150
hlc
${dest}/4.best1.tmp
cl
${dest}/4.best1.tmp
0
hw
bs
${dest}/4.best1.bdd.tmp
0
mq
quit
END4
test $? != 1 && exitval=1
../testdddmp$EXE << END5
mi
150
hlc
${dest}/4.best2.tmp
cl
${dest}/4.best2.tmp
0
hw
bs
${dest}/4.best2.bdd.tmp
0
mq
quit
END5
test $? != 1 && exitval=1
echo "----------------------------- ... RESULTS ... -----------------------------"
diff --strip-trailing-cr --brief ${where}/4.max1 ${dest}/4.max1.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${where}/4.max2 ${dest}/4.max2.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${where}/4.bdd.bis1 ${dest}/4.node2.bdd.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${where}/4.bdd.bis2 ${dest}/4.node3.bdd.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${where}/4.bdd.bis3 ${dest}/4.best1.bdd.tmp
test $? != 0 && exitval=1
diff --strip-trailing-cr --brief ${where}/4.bdd.bis4 ${dest}/4.best2.bdd.tmp
test $? != 0 && exitval=1
echo "-------------------------------- ... END ----------------------------------"
rm -f ${dest}/4.max1.tmp ${dest}/4.max2.tmp ${dest}/4.node2.bdd.tmp \
   ${dest}/4.node3.bdd.tmp ${dest}/4.best1.bdd.tmp ${dest}/4.best2.bdd.tmp \
   ${dest}/4b.bdd.tmp ${dest}/4.best1.tmp ${dest}/4.best2.tmp \
   ${dest}/4.node1.tmp ${dest}/4.node2.tmp ${dest}/4.node3.tmp
exit $exitval
