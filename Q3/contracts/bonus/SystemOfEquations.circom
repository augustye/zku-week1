pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib-matrix/circuits/matMul.circom";

template SystemOfEquations(n) { // n is the number of variables in the system of equations
    signal input x[n]; // this is the solution to the system of equations
    signal input A[n][n]; // this is the coefficient matrix
    signal input b[n]; // this are the constants in the system of equations
    signal output out; // 1 for correct solution, 0 for incorrect solution

    //verify Ax=b
    component mul = matMul(n,n,1); // shape: (n,n) x (n,1) --> (n,1)
    component zero = IsZero();
    component eq[n];

    for (var i=0; i<n; i++) {
        for (var j=0; j<n; j++) {
            mul.a[i][j] <== A[i][j];
        }
        mul.b[i][0] <== x[i];
    }

    var count = n;
    for (var i=0; i<n; i++) {
        eq[i] = IsEqual();
        eq[i].in[0] <== mul.out[i][0];
        eq[i].in[1] <== b[i];
        count -= eq[i].out;
    }

    zero.in <== count;
    out <== zero.out;
}

component main {public [A, b]} = SystemOfEquations(3);