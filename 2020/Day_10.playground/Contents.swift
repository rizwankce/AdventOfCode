import Cocoa

let input = """
79
142
139
33
56
133
138
61
125
88
158
123
65
69
105
6
81
31
60
70
159
114
71
15
13
72
118
14
9
93
162
140
165
1
80
148
32
53
102
5
68
101
111
85
45
25
16
59
131
23
91
92
115
103
166
22
145
161
108
155
135
55
86
34
37
78
28
75
7
104
121
24
153
167
95
87
94
134
154
84
151
124
62
49
38
39
54
109
128
19
2
98
122
132
141
168
8
160
50
42
46
110
12
152
""".components(separatedBy: "\n").map { Int($0)! }

print(input)



func partOne() -> Int {
    var sorted = input.sorted()
    sorted.append(sorted.max()! + 3)
    print(sorted)
    var oneJ = 0
    var threeJ = 0
    var cur = 0

    for i in sorted {
        if cur + 1 == i {
            oneJ += 1
            cur = i
        }
        else if cur + 3 == i {
            threeJ += 1
            cur = i
        }
    }
    print(oneJ)
    print(threeJ)
    return oneJ * threeJ
}

func partTwo() -> Int {
    var result: [Int : Int] = [0: 1]
    var sorted = input.sorted()
    sorted.append(sorted.max()! + 3)

    for i in sorted {
        result[i] = result[i - 1, default: 0] + result[i - 2, default: 0] + result[i - 3, default: 0]
    }

    let last = sorted.last!
    print(result)
    return result[last]!
}


print("Part One Answer is: \(partOne())")
print("Part Two Answer is: \(partTwo())")
