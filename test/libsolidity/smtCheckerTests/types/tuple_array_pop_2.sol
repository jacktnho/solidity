pragma experimental SMTChecker;
contract C {
	int[] a;
	function f() public { (((((a))))).pop();}
}
// ----
// Warning 2529: (78-95): Empty array "pop" detected here.
