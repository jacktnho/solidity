{
	mstore(0x40, memoryguard(0))
	let $x := 0
	sstore(0, $x)
	function h($hx) -> y {
		y := $hx
	}
	sstore(1, h(32))
}
// ----
// step: fakeStackLimitEvader
//
// {
//     mstore(0x40, memoryguard(0x40))
//     let $x_1 := 0
//     mstore(0x00, $x_1)
//     sstore(0, mload(0x00))
//     function h($hx) -> y
//     { y := $hx }
//     sstore(1, h(32))
// }
