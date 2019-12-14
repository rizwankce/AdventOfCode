import Cocoa

let input = """
14 LQGXD, 6 TDLQ => 9 VGLV
1 WBQF, 2 JZKMJ => 5 TRSK
5 MGHZ, 5 ZLDQF => 8 HMVG
1 JWQH, 1 QFBC, 2 ZXVNM => 8 JFJZH
8 QTPX, 8 LDLWS => 6 NVZPS
2 QPWF, 1 PRWSM => 5 WHWF
1 QPWF, 8 LDLWS => 5 LZBQ
127 ORE => 1 MDPJB
4 WHWF => 4 KQHW
1 QBCKX, 3 TMTH => 4 WLFTZ
15 NPMPT, 4 TMTH => 6 QFBC
12 MDPJB => 9 PRWSM
5 QXHFH, 3 LCDVR, 24 MWFP, 1 MSFV, 1 BPDJL, 3 LQGXD, 2 DVGW => 2 KCPSH
6 FPZXN, 1 FQSK, 3 TMTH => 1 FBHW
25 PRWSM => 1 MGHZ
6 XWKXC, 5 TMTH, 1 PZTGX => 6 NTQZ
3 BPDJL, 3 DJWCL, 2 JZKMJ => 7 MWFP
5 JFJZH => 3 DJWCL
22 WRNJ, 12 TRSK => 5 TBGJC
3 HKWP => 1 PDRN
3 JWQH => 5 JZKMJ
4 WBQF => 2 BJNS
1 GNBQ => 9 FQSK
8 HMVG, 1 HQHD => 5 NJFNC
7 QBCKX, 1 FQSK => 9 NDCQ
3 XWKXC, 7 QFBC, 3 GPFRS, 2 LPQZ, 2 LQGXD, 20 LZKM, 1 QRTH => 8 TDTKT
1 QTPX => 3 LPQZ
2 QGVQC, 14 LDLWS => 1 NPMPT
1 QRTH, 7 BPDJL => 7 XWKXC
9 WLFTZ, 8 TDLQ => 6 GKPK
4 GNBQ => 3 QXHFH
3 TBGJC, 1 LPQZ => 3 DVGW
3 NDCQ, 1 KGZT => 7 FPZXN
36 WLFTZ, 1 KCPSH, 1 GKPK, 1 TDTKT, 3 CSPFK, 27 JZKMJ, 5 VGLV, 39 XWKXC => 1 FUEL
115 ORE => 7 QGVQC
21 NTQZ, 11 HQHD, 33 JFJZH, 3 NJFNC, 3 MSFV, 1 TRSK, 7 WRNJ => 9 CSPFK
3 DVGW => 4 TDLQ
5 FPZXN => 6 WRNJ
10 TSDLM, 17 XDKP, 3 PDRN => 2 HQHD
1 PCWS => 3 PZTGX
2 QXHFH => 5 JWQH
17 KQHW => 2 WBQF
139 ORE => 5 LDLWS
3 TSDLM => 9 KGZT
16 NPMPT => 3 QTPX
3 DVGW, 5 KVFMS, 3 WLFTZ => 6 GPFRS
1 PZTGX, 2 LCDVR, 13 TBGJC => 6 LZKM
5 ZXVNM, 2 QXHFH => 4 MSFV
4 XDKP, 7 FBHW, 2 PCWS => 3 LCDVR
3 TRSK => 7 KVFMS
10 LDLWS => 9 TMTH
2 TBGJC => 6 LQGXD
2 TRSK => 6 ZXVNM
4 KQHW, 1 NVZPS => 8 ZLDQF
2 LZBQ => 4 QBCKX
7 QBCKX => 6 TSDLM
152 ORE => 3 QPWF
2 TSDLM, 8 WHWF => 3 HKWP
19 FQSK => 8 QRTH
19 QTPX => 3 GNBQ
4 PDRN, 12 HKWP, 4 PCWS => 3 XDKP
6 LZBQ, 19 BJNS => 5 BPDJL
5 HKWP, 6 NVZPS => 3 PCWS
""".components(separatedBy: "\n").map{ $0.components(separatedBy: " => ").map{ $0.components(separatedBy: ", ")}}

print(input)

struct Item: Hashable, CustomStringConvertible {
    var count: Int
    let name: String

    init(_ count: Int, _ name: String) {
        self.count = count
        self.name = name
    }

    init(_ string: String) {
        let value = string.components(separatedBy: " ")
        self.count = Int(value.first!) ?? 0
        self.name = value.last!
    }

    var description: String {
        get {
            return "\(count) \(name)"
        }
    }

    func scaled(by scale: Int) -> Item {
        return Item(count * scale,name)
    }
}
struct Reaction {
    var inputs: [Item]
    var output: Item
}
var reactions = input.map { line in
    Reaction.init(inputs: line.first.map { $0.map{ Item($0) }}!, output: Item(line.last!.first!))
}

func cost(_ count: Int) -> Int {
    var req: [Item] = [Item.init(count, "FUEL")]
    var excess: [String: Int] = [:]
    var done = false

    while !done {
        //print(req)
        if !req.contains(where: { $0.name != "ORE"}) {
            done = true
        }
        var next: [Item] = []
        for item in req {
            if item.name == "ORE" {
                excess["ORE", default: 0] += item.count
            }
            else {
                //print(excess)
                var quantity = item.count
                if let extra = excess[item.name] {
                    if extra > quantity {
                        excess[item.name, default: 0] = extra - quantity
                        continue
                    } else {
                        quantity -= extra
                        excess.removeValue(forKey: item.name)
                    }
                }
                let current = reactions.filter{ $0.output.name == item.name }.first!
                let scale = Int(ceil(Double(quantity) / Double(current.output.count)))
                current.inputs.map { i in
                    var x = i
                    x.count *= scale
                    next.append(x)
                }

                let a = current.output.count * scale - quantity
                if a > 0 {
                    excess[item.name, default: 0] += a
                }
            }
        }
        req = next
    }
    //print(excess)
    return req.filter { (item) -> Bool in
        item.name == "ORE"
    }.first?.count ?? 0 + (excess["ORE"] ?? 0)
}

func partOne() {
    let result = cost(1)
    print("Part 1 answer is :\(result)")
}

func partTwo() {
    var low = 0
    var high = Int(1e12)
    while low < high {
        let mid = (low + high + 1) / 2

        if cost(mid) <= Int(1e12) {
            low = mid
        }
        else {
            high = mid - 1
        }
    }

    print("Part 2 answer is :\(low)")
}

partOne()
partTwo()
