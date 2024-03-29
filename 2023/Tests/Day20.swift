import XCTest

@testable import AdventOfCode

final class Day20Tests: XCTestCase {
    let testData = """
        %vn -> ts, lq
        &ks -> dt
        %zt -> vl
        %xg -> ts, pb
        &xd -> qz, bc, zt, vk, hq, qx, gc
        &pm -> dt
        %gb -> vj, xd
        %qx -> gb
        %rl -> qn
        %lq -> gk
        %qm -> bf
        %zn -> vh, pf
        %lz -> kk, vr
        %bf -> rr
        %gx -> vr
        %zr -> vx, pf
        %lt -> ng, vr
        %hd -> mg, xd
        %mg -> xd
        %tx -> jg, vr
        %gk -> kx, ts
        &vr -> tr, vf, tx, ks, kk, jg
        broadcaster -> qz, tx, jr, hk
        %bc -> qx
        %xz -> lt, vr
        %jg -> sb
        %qn -> zr, pf
        %gc -> xv
        %vx -> lj, pf
        %vf -> cn
        &dt -> rx
        %sb -> lz, vr
        %kx -> xg
        %hk -> pf, tv
        %cb -> pf
        &dl -> dt
        %vl -> xd, bc
        %fl -> pp, pf
        %ng -> vr, gx
        %jr -> ts, qm
        %cd -> vn, ts
        %mt -> ts
        %rr -> ts, cd
        %tr -> xz
        %hq -> zt
        %xv -> hq, xd
        %vj -> xd, hd
        %pp -> zn
        %vh -> pf, cb
        %cn -> vr, tr
        %kk -> vf
        &pf -> pp, tv, rl, pm, hk
        &ts -> dl, qm, kx, lq, bf, jr
        %tv -> rl
        &vk -> dt
        %pb -> ts, mt
        %lj -> pf, fl
        %qz -> xd, gc
        """

    func testPart1() throws {
        let challenge = Day20(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "711650489")
    }

    func testPart2() throws {
        let challenge = Day20(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "219388737656593")
    }
}
