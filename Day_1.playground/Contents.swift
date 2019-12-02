import Cocoa

/// --- Day 1: The Tyranny of the Rocket Equation ---

let input = """
93326
54591
106194
129163
110634
81294
59548
77988
66354
108990
91097
102076
67526
135820
109167
94391
78323
75009
61836
55751
54229
145159
103821
136601
119830
57607
69157
115099
53756
136063
62243
111594
57598
83789
130669
67435
112187
141492
109872
84640
119694
119030
75716
119017
106547
101674
120137
93759
115976
119378
86245
93317
53712
69079
92125
62397
102365
115860
111618
65452
83625
90951
110774
114943
99559
101417
100651
98412
109963
68158
121405
85002
119519
92200
125104
71018
131892
92342
51671
94691
136330
64877
65449
65008
91656
144705
130867
74732
61977
129490
91928
109200
94488
99216
89115
89756
52113
83463
101765
62363
"""

func fuel(forMass mass: Int) -> Int {
    return Int((Double(mass) / 3).rounded(.down) - 2)
}

print(fuel(forMass:12))
print(fuel(forMass:14))
print(fuel(forMass:1969))
print(fuel(forMass:100756))

func partOne() {
    var total = 0
    input.components(separatedBy: .newlines).map{ input in
        total = total + fuel(forMass: Int(input) ?? 0)
    }
    print(total)
}

func fuel(forMass mass: Int, includesFuelMass: Bool) -> Int {
    if !includesFuelMass {
        return fuel(forMass: mass)
    }

    var currentFuel = mass
    var total = 0
    while true {
        let fuels = fuel(forMass: currentFuel)
        if fuels < 0 {
            break
        }
        currentFuel = fuels
        total = total + currentFuel
    }
    return total
}

print(fuel(forMass: 14, includesFuelMass: true))
print(fuel(forMass: 1969, includesFuelMass: true))
print(fuel(forMass: 100756, includesFuelMass: true))

func partTwo() {
    var total = 0
    input.components(separatedBy: .newlines).map{ input in
        total = total + fuel(forMass: Int(input) ?? 0, includesFuelMass: true)
    }
    print(total)
}

partOne()
partTwo()
