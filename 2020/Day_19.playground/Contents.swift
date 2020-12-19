
import Cocoa

let input = """
0: 8 11
4: 92 5 | 5 5
123: 5 3 | 92 99
22: 103 92 | 88 5
90: 92 70 | 5 117
73: 24 92
27: 92 12 | 5 109
14: 55 5 | 4 92
109: 5 21 | 92 78
63: 92 91 | 5 64
118: 92 116 | 5 49
131: 103 92 | 111 5
115: 46 5 | 93 92
93: 92 89 | 5 107
84: 92 100 | 5 57
98: 5 40 | 92 72
39: 5 4 | 92 21
102: 59 5 | 131 92
55: 92 92 | 5 92
92: "b"
20: 92 103 | 5 21
110: 121 92 | 35 5
47: 78 5 | 4 92
48: 92 92 | 92 5
96: 92 73 | 5 1
106: 110 5 | 56 92
101: 92 83 | 5 127
105: 5 53 | 92 55
91: 117 5 | 117 92
60: 5 21 | 92 4
85: 92 55 | 5 33
103: 5 44 | 92 5
45: 108 5 | 119 92
82: 5 53 | 92 68
78: 92 92 | 5 5
58: 28 92 | 133 5
121: 92 90 | 5 14
16: 117 5 | 111 92
31: 92 114 | 5 87
112: 41 5 | 132 92
65: 53 5 | 48 92
19: 64 5 | 1 92
1: 5 24 | 92 70
77: 21 92 | 78 5
61: 92 32 | 5 102
52: 92 15 | 5 101
79: 92 75 | 5 38
64: 92 70
99: 67 92 | 23 5
94: 21 5 | 111 92
30: 92 24 | 5 117
26: 5 34 | 92 61
126: 5 45 | 92 113
50: 53 92 | 48 5
83: 5 48 | 92 111
25: 92 111 | 5 4
49: 33 5 | 21 92
40: 24 5 | 24 92
124: 92 55 | 5 4
7: 5 36 | 92 106
62: 128 5 | 60 92
97: 92 78 | 5 2
69: 2 5 | 111 92
70: 44 44
21: 5 92 | 5 5
117: 92 92
116: 92 70 | 5 2
23: 44 70
72: 92 55 | 5 24
87: 130 5 | 126 92
86: 5 115 | 92 18
36: 92 71 | 5 43
108: 59 5 | 81 92
80: 5 39 | 92 6
34: 92 9 | 5 134
119: 25 5 | 85 92
120: 5 129 | 92 47
10: 5 70 | 92 48
42: 7 92 | 86 5
125: 95 92 | 80 5
17: 65 5 | 77 92
43: 120 92 | 122 5
6: 78 5 | 88 92
81: 21 5 | 68 92
89: 5 54 | 92 47
35: 104 5 | 10 92
134: 129 5 | 76 92
66: 5 24
122: 5 66 | 92 22
53: 92 5
51: 5 111 | 92 117
68: 5 5 | 44 92
3: 1 5 | 97 92
56: 74 92 | 62 5
12: 92 117 | 5 21
57: 33 5 | 70 92
113: 118 92 | 84 5
104: 5 117
5: "a"
107: 124 92 | 90 5
9: 16 92 | 50 5
2: 5 5 | 92 44
88: 44 92 | 92 5
8: 42
41: 5 70 | 92 4
54: 5 4 | 92 78
15: 92 51 | 5 105
75: 63 92 | 112 5
67: 4 92
46: 98 92 | 19 5
132: 21 5 | 24 92
29: 94 5 | 65 92
13: 92 88 | 5 117
33: 5 92
76: 92 70 | 5 53
127: 117 5 | 55 92
71: 29 5 | 96 92
129: 5 111 | 92 88
44: 5 | 92
95: 37 92 | 105 5
100: 53 92 | 2 5
18: 125 5 | 58 92
59: 5 88 | 92 24
114: 79 92 | 26 5
11: 42 31
37: 88 92 | 68 5
38: 27 5 | 17 92
32: 40 5 | 13 92
111: 92 5 | 5 92
28: 92 30 | 5 109
128: 92 2 | 5 68
74: 92 20 | 5 82
24: 5 5
133: 5 100 | 92 69
130: 92 52 | 5 123

baabbabbbabbaaabababaabbbaaaaababaaaabab
bbabbbaaababaaaaaaabaaab
aabbbbbababbbbbbbbbbababbbabbbbb
bbaaaabbaabbaabaaaaababa
bbbbababbabbbbbaaaabbbab
aaaaaaaaaabababbaaaaaaabbbbabbbbbbabbabbababbbbabbbbabaabbaabbaa
babababaabbabbabbabbbaaa
abaaaaababaaaabbbabababaabbbbbbaaabbbbaa
aaaaaaabbbbabaaababbbaabaabbabbabbbbbbba
bbabbbbaaaaaaabaaaaabaabaaabbaaaababaabbbbabaabbabbbbabaabaaaabbbbbbabab
abbabaabababaababaabbbaa
aaababbaaaaabaaabbbababbabbaabbbbbabbbabbaaaabaa
abbbbaaaaababababbaabbaa
bbabbaaaaabbbbbababbaababbbabbaa
bbaaabbbbaaababbbabbabbb
abbaaaaaababbaaabaababaa
aaaaabbbbabbbbbbabbbbabb
aaaabbaaaabababaabaabbaa
aaabbababbbaaababbaaaaab
abaaaabaabaaaabbaabbaabb
bbbabbbaaaaabaabbabbbabbbbbbabbbabaaaabbabababba
bbbbaabaaaabbbbbaaaaabab
aabaaabbaababbbbbbabababbabbbaababbaaaaaabbaaababbaabbbaaabaaabbaaaababa
abbabaabaabbbabababbbaba
ababaaabbabbaabababbbbab
abaaaababbbabaaabbabaaaa
aabaaababbabbbabaaabaabb
aaaabaaabbbbbaaababaabaaabaababbabaababb
bbbabababbabbababbaaaaab
abaaaaaabbbabbbbbbaabbab
aaaabbaabaababababbbabab
bbaaaaaababbaaababbbaabb
babaaaaabaaaaaaaabbbabbb
ababbaaaaabaaabbbbbaabbbbabbabaaababbbab
baaabbabbbbabaaaabaaabab
bbbabbbbaaababbbbaaaaaaaabbabbabaaabaaba
babaabbabaabbabbbbaaabbbbbbbbabbbbbbbbbbbabbbaab
aabbbbbaaaaabaaabbbbabba
bbbbaababbaaaabbaaabaaaa
abbaaabaaabaababbbbaaaaa
babaaaaaaaababbaaaabaabb
baababbbaabababaaaaaabab
bbbbbbaabbbbabbbaaabaaaa
baabbabbaaaaabbabbbaabaabaaaabaaababbbaaabaabbab
baababbbbbbbaabaaaabaaba
baaaabbabbbaaabaaaababab
abbaabbbaaaabbaaaabaaaaa
aabbababaabbabbbababbbbbbaabbabababaabab
bbbababbbababaabbabbbaba
bbbabaaabbbabbaaaabaaaaa
babbbbbbbaababbbaabbbbab
aaaaabbbababaaababbbaaab
bbbaaababbaaabbbabbaababbbbaababbaaabbababaabbbbbbababbabbbabbba
abbaabbabaaaabbabababbba
abbbbaaaababbbbbbaabbbaa
bbbbabababbaaabaaaaaabbbbababbaaaabbbaab
aaaabbaaabaabababbaababa
bbaaabbbababaaabaaaabbba
bbbbabaababaaaaaaabababbbbabbabbabaaabba
abbaaaaaaaabbabbabbaaaab
aaaabaaaaababbabbaabbbba
aabbbbbabababaaabbbababbabaababb
baaabbabbbaababbabababba
babaabbaaababaabbaabaaaaababaabaaaabaaab
abaaaaababbbbbabaabaaaaa
abbbbbabbaabbaababbbbabaabbbaaba
baababbbaabaabbbbbbbaaaabbaabaab
bbbbbbabbaaabbbabaabbabbabbaaaab
abaaaababbbaabbabbaabbaa
abababbbbabbbbbaaaabaaab
bbbaabbbbbaaaaabaabbabaabbbbaaaaaaababbbaaabababbbbbbbba
aaaaabbbbbbaabbaabaabaab
aabbaababaaabbbaabaabbab
abbabbaaabaaabaabaabbbbb
bbbaaabbaabaaababbbaabaa
bbaabbbbbbbaaaaabaabbaaa
ababaabbaabaabbbbbabaaaa
ababaaaaaaaabbbbbabbabbbabbaaaaaaabbbaaaaabbabbabbabbaaabaabbbaabaaabbabaabaaabaabbababa
abbaaabababbbababbbaaaabaaaaabab
abbbbbabbababbbbbabbbbab
baabbaabbbbbababbbbaaaab
abbbbbaababbaabbbaabaaba
aabbaaababaaabaaaaabbbab
bbbbbbaabbababaabbbabbaabbababbaaaaababa
abaabababbaabbbbabbbbbba
bbabbbaabbbbbbabaaaaabbbabbaaabaabbbbbaaabbababaaaabaaaa
aabbababaabbbabbbabaaaab
bababaaabbbbbaaaaaaaabaaaaabaabbababaabababbababaaabbbaaabbbaaaa
bbbbbbaaaabaaabaabbbbabaaaabbbbb
bababaababbbbbaabbaaabab
babaabbabbbbbbaababbabba
ababaaabaabbbbbababaaabb
bbbbabaaabbabbabbabbaaaa
ababbaabbabbaababbbaaababaabbaaa
abaaaaabbaaaaababbabbabb
bbaababbbaabbaababaababaabbaaababaabbabbbbbbbbbbaaabbbbbbbaababaabaabbbb
bbbbbbaaabaaabaaabbbabbb
aabbbababaaababbaaaaaaba
abbabaaaaabbaababbbaaabbabababba
babbababaabaabbbaaabbbbbbbbbaabbababbbab
bababbaaabaaabaabbbabbaabbababaabbbbbaaabaabbbbbbbbbbbbbaaabbaab
ababbaaabbbbbaaabababbba
aabbaaababaabaaaabaabaab
bbaabaaabbabaabaabbababbabaababababbbbaabbbaababaabbabab
aababaababaaabaaabbbbbba
ababbbaababbabababbaaabbaaaaaaaaabaabababbaabaaabaababababaaaaabababbabababbbabaaaabbbbabaaabaab
baabaabbbaaaaabbaaabbaab
aaaabaaaabaabaaabbabaaab
bbabbaaaaaababbaabbbbaaaaaaabaaabbabbbbb
ababbaabaababbbaaabbbbaa
bababbbbbbbabaabbbbabaaaabaaaaaaaabbabaa
aaabbbbbabbbabbaabbabaaaaabbbabbbababbabbbababbaabababaa
babaabbbabbaaaaabaaabbbaaaabbbaabaababaa
aabbaababbabbbabbaaaabaa
abbbbaaabababbbbbbabbaaaababaaabbbbbbbbb
baaaaaaababbaaabaabbabba
abbbaaaabbaaaaaaabbaaaab
bbabbbbbbaaababbabaabababbbaabababbabbbaabbabbaaabbababbaabbbabbbbbabbba
abbaaaaaabbabaaaabbaabbbababbaaaaaaaaabbaabbbaaaabaaabba
aabaabaaababaabbbaaabaababaabbaabaabbbbbaabbbabbbbaaabaa
aaaababbaababbabaaaaabaaabbbbaaaaabbaaaa
bbbabaaaabaaaaaaaaabaaaa
aababbbaabbbbababbbabbbbaaabaaaa
aaaaabbabbabbabaaaabbbba
aabaababababbbbbbaaaaababaabbabbbababaaaaabababb
babbbbbaaabbbabbabaabbbb
bbabbbaaabaaaaabbbaabbbbbabaaaab
bbbbaabbabbaaaaabababbbbababaaaa
abaaabaaabbaabbaabaaabbb
aaababbaababaabbaaababab
bbabbaaabaaabbabaaaaabbaaababaaa
aabbabbbbbbbababbbbbbaabbabbabaa
aaaaabaabbbbbabbaaaaabaabbbaabbbbaabaabaabbbaaabbaabbabaaabbbbbabaaaabaaabaaabbb
abbabbaabbbababbbabbabba
babbbaababbaaabaaaabaaab
bbabbaaaabbaaabaaaaabbaaaaababaaabbaabba
abaabababaababababababba
aabbbaabbaaaaabaaabbaaba
abbaaabbbbbababaabbbaabbbabbababbbbbbbaabbbbbaabbabaabaaababbbbabbbabbaaabaabbaa
aabbbaaaabbbaabaabaabbbbabbabbaa
bbbbabaababababaabababaabbabbbbbaaaaababaababbbaaabbbbabbabbbabb
babaaababaabbabbbbaabbbbbaababbaaabbbbaa
aaabbbbbaaaaabbbaabbabba
baaabbbaaabbababbababbbbabbbaaaabbabaabbabaabbba
baaabaabaabaabbbbaababba
aaababbbbabbbbaaaaaaabbbababaaaabbabaabbbaaaabababbaabaa
bbbbbaaabaaabaabbbbaaabbaabbbababbbaabbbbaaaabbb
baaaaaaabaaabbabbabbabaa
abbaabbaabbaabbbabababab
aaaaabbaaabaaabbbbaaabab
bababbaaaaaaabaaaaaababa
aabbbabbbbbbaaaaabbbaaaabaabbbbb
aabaabbbbbbbbbaabaaaaaab
bbabbababbbbabbbbbbbabaaaaaaabbbbaaaabbb
aabaababbbbbbbaaaabbaabb
aabbaabaababbbbabbababab
bbababaabbbaaabaabbbabaa
aaaababbabaaaabbabbbaabb
abbbbbababbbbbaaaaabbbaa
ababaabbaabbababbbaaabaa
bbbbababbabbbbbbbbbbabbbaaaabaabbaaabaaa
bbbabaaabaabbabbbaaabaaa
abbaaaaaabaabbabbbaaabbaabbbabababaaabab
aaabaabaaabaaabbabbbbbbabaabbaaabaabbbbabbbbbbbbabababaaaaababababababab
babbbaababbbbbaaabaaaaabaaabababaabbaabb
bbbaaabbbbbbaaaaabbbbababababbaabababaaaabbabbbaaaabbbab
babaaabaabaaaaabababbbaa
abaaaaababbbaaaaaaabbaab
bbbaaabaaabaabababaaabba
bbbababbaabbaaabbbaabbaa
babaaabaabbabaaaaabbbbbb
bbbbababbbbabbababaaabba
aabbaabaababaabbababaabbbabaabbbabbbbabbbaaabaaa
bbbaaabaaabbbabbabbababb
ababaaabbabbbbbababbbaba
bbbbabbbaaaaaaababababaa
ababaaabbbbbabaabaaabaaa
bababababbbabbabbaaaabab
baabbaababbbbaaabbbabbba
bbabbababbbbabababbbaaab
aaabbababaabaaaaababbbab
aababababbbaaabaabbbbbba
baaabbaabaabaaabaaaabbaabbaaabbababaabbbaababaabaabbabaaababaaaaaabbbbaabbaabbbabbabbaaa
bbbaaababbbababbaabbbbbb
bbabbbaabbbbbbbbabbbbbaaabbaaabbbbbbababbbaaaabbbababaabbbbaaaaaababbaba
abaaaaaabbabbabbaaaaaabb
bbbabbaaaaabbbbbbbbbbaba
aaabbabbaaaaabbbaabaabaa
bababababaababbbaabbaabb
abbbbabaabbbbabaabaabbaa
bbaabbbbbbbabbaaaaabbbab
abaabababbbaaabbaaaabbab
bbbababaabaaaababbabbbbaaaaabbbabbabaaab
aabaaabbbbabbaaaabbbabaa
ababaabbaabbbaabbbabaaba
ababbabbaabbaaabaababbbb
aabbaababaabbabaabaaabab
babbababbabbaaabaaaaabbabbabbbaababaaaab
baabbaabaabababaabababab
bbabbbabababbaabaabbbaaa
bababbaaaabaaabbaabbabaa
abbabaabbbbbababbbbaaabaabaaabaabbabaabbbabbbaba
abbbbababbaabbbbababbbaa
aaabbbbbaaabbbbbabbbbaab
aabbababababbbbabbaababbaabaabbaabaababb
babababaaabbabbbbbaabaab
abbbabbababbaabbaabbbaaa
bababbabbbaababbaababbaa
abababbbababbbbbaabaabaa
bbbabaaabaabbaababaaaabbaaaaaaababababbaaabbbbaaabbaaaab
baaabbabababaaaababaabab
bababaaabaaabbaabaaaabab
babbbbaabaaaabbabaabababaaabbabbbabbbaabbaaabbbb
baabaabbbbbbaababbababaabbbababbbabbbbaabaaababa
bbbababbbaaabbaababababaababbaba
abaaaabaabbaabbabbaaabbbabbabaababaabababaaabbbbbbaaaaab
bbabbbaabbaababbbbaaabba
baabbaabababbabbaababaaa
aaaaabbaaabbbabbaabbabbbbababbababbabbabaaabaaaa
aaaabaaababbbbbaaaabbabbbbbbabba
aabbbbbabababaaaaababbaa
aaabbabbabbabaaaabbaaabb
bbbaabbababaaabaaaaabaab
abbbbbabaabbababaabbbbbb
aabababaaaababbbabaaabab
abbabaaabbbabbbbaabbaaaa
bbbabaabbaaaaabbabbabbababbababb
abbbbbaababbbbaabbbaababbbbbaaabbbbbaaab
bbbabaabbabaabbbabaaaaaabababababaabbbbaaaaababa
bbbbaabaabbaaababbabaaaa
abbbbabaaaaaabbaababaaaabaaaababbabbaaaa
abaaaabababaabbbaaabbaab
bbbaababbbaabbbbbbaaabba
aababbabbbbaabababbbaaab
aababbababaaabaaaaaaaaabaabbbbbb
baaaaabaabbbbaaaabbbaaba
abbaaabababbbbbaabbbbbaabababaaaaaaabbaaaaabbbbabbbaaaaaababbbabaaaaaabb
bbbababbbbaaaabaabaababb
bbbaaabbbababbbbabaabbbb
baababbbbaaabbababbbbbbb
abbbaabbbabbabaaaaababbabbbbabbbaabbbbabbbabbaaa
aaabbabaabaaabaaabbbabbabaabbaaa
bbbaabbbbbabbaaaaaaabaab
baabbaabbbaaaabbbaabbbba
ababbaaababaabbbbbabaabbabbbabbbabbbbabbbbbbabbaabbaaaabbbabababbaabaaaa
abbabbaabaababbbabbabbba
bbababaaababababbbababbabaaaabaaaabbabaaaaabbabaaaababab
aaaaabbaababbaaababbbabb
babaaabababaabaaaaababaa
baababbbaabbbbbaababbaba
bbbabababbbaabbabbabaaba
bbbaabbabbaaaabbabbababb
bbababaaaaababbaaaababaa
aabbababbabaaabaaababbaa
abbbbbaabbbaababaaabaaaa
abaaaababbabbababaaabbabababaaabbbaaaabbbbaaababbbaabaab
abbbbaaabbaaabbbaaaababa
ababaaaababbababbabababb
bbbbababbaaaaababaaabbbaaabbaabaabaabaabaabbabaa
aabaaababaababbbbaabbbaa
abbbaaaaabbaababaabaaaabbbbbaabbaabaabbbabbbaaababbbbaabbbbabaabaabaabba
bbbabababaabbabbbbabaaaa
aaaaababaabaabaabbaabaabbaabbbbbbbababab
ababaaabaababaababbbaaab
aaabbaabbabbbabaabbaababbaaaaaaababaaabbbbbbbbabbbbaabaa
abbabbabbaabaababbaaabab
bbababaaabbaaababbbbbaaaabbaabbabbaababbaabbbbbbabaaabab
bbbbaaaaabaaaaaaaabababaabbababbaaaaaabbbbbbaaaabbbabbbb
baababbbbbbbaabbbabaaabb
baaaaabbaaabbaabbaabbbbbbbaabbbbbbbaabbbbbbababbabbaabaabbbbbbbabaaabaabaabbaabb
baababbbbabbaaabbabbbbaabbaaaaaabbbaaaaabbbaabaa
baaabaabaabbbaabbabbaaaa
aaababbbaaaaabbabbabaaab
babaabbaababbaabaabaaabababbabbb
abbaaaaaabbaabbbabaabbaa
bababbababaaaabbabaabbba
babaabaaabaaaaaaaabbbaaa
abbabbaababaabbabbaababa
bbaaabbbbabbababaababaabbabbaabb
ababbbbbbaabbaabaaaaabab
bbbaaabbbabaabaabaababba
abbbaaaabbababaababaaaab
bbbbbbaabbbabbaabbbaabaa
aabaaabaabababbbbaabaaab
bbbaababaaaabbbaabaabbbbbbabaabbbbaaabbabbabbabb
aabbaaababaaaaaaabababba
bbbbabbbbaabaaaaabbbbbbb
bbbbaabaaaababbabaabbaba
baaababbbbbbbaaabbbbbbbb
bbbababbbbbbbaaaababaaaababaabaaabbaaabb
abbabaaaabbaabbbaaaababbbbbaaaababaabaab
aabaababbbbabaaabaaabbaaaabaabbbaaaababa
babaaaaababbaababbbbaabbaabbaabb
aabbababbabaabaabbbaaaab
abbabbabbaaababbaaaabbab
baaabbaabbabbbabaaabaabb
aabbaabaaaaaabbaaaaaaabb
bbbabaaabbbabbaabbaaabba
bbbaaabbbbbbaabaabbaaababaaaaaaababaaaab
abbaaababbabbbabbbabbbaabbabbbaabbaabbba
abaaaabaababaaaaababbaba
bababbbbbbbbabbbaabaaabbbaabbaabbababbbababaabab
bbaaaabbaaaaabaababaabbaaaaabbbbabaabbba
baaabbaabbbaabbbbaaaabab
aabbbabbbbbaaabababbbbab
baaaaabbaababbabaabaaaaa
babbaabbbbababaaaaaaabab
baababbbbabaaaaababbabbb
abaaaaabaaabbabaaabbaabb
ababbbbababbaabaabbabbaaabbabbaaaaababbabbaaabaa
ababaabbbabaaaaabbababbb
bbbbaabbbabbaabbbabbaaaa
bbbbbaaaaabbabbbbbbbbaba
bbbbabbbaababaabbbaababa
babaaaaabbbaabbbabbabaabbbabbabbbaaabbbb
aababbbaaabbbababababbabaabaabababbababa
baaaabbabababaaaababbbaa
babbaabaaaaaabbbaaabbbababbbbbba
bbaaaabbbbbaababbbabaaaa
aaababbbaababaababbbaaba
baaaaaaababbbbaabbbaababbbbaabbaaaaabbaaabababaabaaaabaaaaababaa
bbbbababababaabbbabaabbaaaabaabbbbbaabaa
baabaabbabbbbbabbbbbbaaaabbbbabb
bababababaabaaaaaabbaaabaababbbabbbaaaaa
abbabaabbaababbbabaabbab
aaaaabbbaabaaabaabbbbaaabbbaabbbbababaaaabbbbbbaaabababbaababaaa
bbababbbbaaaabaaabbababaabaaababbabaabab
abbbbababbaaaababaabbbab
aabbaababababbabbababbba
bababbbbababbaababbbabaa
bbbaabbbaababaabbbbbaaab
babbaaabababbaabbbabbabb
ababbbbbbabbbbbabbbabaaaababaaabaaababbabbbabbabbabababb
aabaaabbabaaaabbbaaaaaab
abaaaabbabaaaabbaababbababbaabaabbaaabaa
baaaaabbabbbaaaaaaabbbaa
bababbaaaabbbabbbaabaaba
bbbbaabaababbaaaaaabbbba
bbbbaabaaabbaaabbbbabbbbababbaba
abababbbabbaaaabaaabaabb
baaaaabbbabbbaababbbaaab
bbbbabaaaaaababbbaabbbab
bbbaaabaaabaababbaababaa
abaabababaaaabbabaaaaababababbbbbbaabbabbbbaaaaa
abaaaaabbbbaaabaabbbbbba
abbbbbaaaaaaaaababbbbbaaabaaaaababbbaaaaabbbaaba
aababbaabaabbabababbbbab
baabbaaabbbaaabaaabbbbaabbbabbabbbababababbbbabbaabaaaba
bababbbbaaabbababaabbaabbabbabbb
babaaabaaaababbbaaaaaaabbaaabbbaaabbabaa
aaaababbbbbbabbbabaaaabbabbbbabb
abbbbaaaabbbbbaaaaaababbaabbbabbbaabbaababbbabbabbbbabbaabaaabba
abbbbbabbaabaaaabbaabbba
aabbbaabaabaabbbbbabbbababbabbbabaabaaba
babaaabaababbbbbbbbaabbababaababbaaababaabbbabbbbabbabba
baabaaaabababaabbaababaa
abaaabaabaabbabbabbaabbababbaaaa
bbbbababaaabbbbbbabaaabb
bbbbaabaaabaababbbaaabba
ababbaaabaaaabbaaaaaabbaaaaaabaaaabaaabbabbbabbb
aabbbaabaaaabbaaabbbbabababbabaa
aababbbabaababbbbbababba
bbbabbbbbaaaaabbbabbaaaa
bbbbbaaaabaaabaaaababbbb
aaababbabbabbbababaabbba
bbabbbababbbaaaabaaaaaab
babbbaabaaaabaaababaabbbaabbabbbbabbabbabbbbbbbb
aaabababbbbaaaaaaaabaaba
aababbabaaaabaaaabbaaaab
baaabbabbbbababbaabaabbbbbabbabaaaaaaababaaababa
bababbabbbababaabbbbbaaabbababab
baabababbabbaabbbbaabaaa
baaababbabbbaaaaaaabaabb
bbbbbaabaaaababbabbbabbb
babbababbaaaaaaabbabbababaabbaabbbbbbbbabbaabaaabbaaaaab
abbabbaababbbbbabbaabbba
bbbbbaabbaaaaabaabbabaaaaababbaa
babaabbaaaaaaaabaaabaaaa
abbbabaaabaabbbbabbaaabbababababbbababab
bbbbabbbabbbaaaaababbabbbbbbabba
aabbbbbbabaabbbbabbaaaabbaababaabbaaabaa
abbbaaaabababababaabaabbbbbaabbbbabbbaabbaababaa
abaaabaabbbababbababaaabaabbbabbabbabaab
aababaabbaaababbbaabbaaa
babaaaaababaaaaabaaababbbbbbbbaaabbbbbbabbaabbbaaabbaabb
abbbabbaaabaaabaaaabbaab
bbabbabababbaaabbababaaaaaaabbabbbabaaba
abbbbabaaaaababbabbbbbba
baaaaaaaabbaabbbaabaabaa
bababbaabbbbababbbabbaab
abbbabbabababbaaaababbbabbaababa
baaabaabbbbabbaabaababaa
bbbabbabaaababbbbaabaaab
ababbaabbbabbbabaaaaabab
bababbaabbaababbbbbababaababbbaaaaabababbbaabbbabaababbaaabaaaaaaababaaa
abaaaaabbbbaabbbbabbaabbabaaabaabbaaaabbabaabbab
abbbabbabaaabbabbabaaaaaaabbaaabbbbbabba
bbaaaaaabbabbbabbbbbbbbb
baababbbabaaaabaaaaaabbbaaaaabab
baaaaababbababaaabbbbbba
bbaababbabbabaaabaabbbab
baaabbabbbbbbaabbaabbbbb
abbaabbbbbbaaabaabbabbba
aaaabaaaabbbbbabbababbba
bbbbbbaaababaababbbaaaab
baabaaaabbbbbbaaaaaaabbbbabaabbabbbababaaaaababa
babbababaabbaabababaabab
aaaaaaababaaaabbbaaababa
aabaaabaabbbbaaababbabbb
ababbabbbababababaaabbbabbbaabaa
babaaaaabbbbabbbabbbaaaabbabbbaabbbaaaaa
bbaaaababbbababbbbbaabbaabbababaaaaabaab
bababbaaabbbbbaabaababaa
aaabbabbababaaabbababaabaababaabaabbaabb
ababbaaabbababbbbbbaabaaaabababaabbbbababaaabbbaabbbbaaaaababbba
bbbbbbaabaabbaabaaaaaabb
aaaabbabaaaabaabbbabbabbbbaabaaaabbaabbaaababbaa
bbbababbbbbaabbaabaabbbb
ababbabbbababbaaaabaabba
babbaaabbbaaaabbabbabbba
abaabaaabbbabaaaabbababa
ababbbabbaaabaaaaaaabaabbabaaababbaaabbaaababbbbabbababb
bbbabaaaabaabaaabbabbaab
baabbabbbbaaaabbaaabbbab
babaaaaaaaaaabbaaaabaabb
abbabaabababbabbabbaaabaaaabbbabbbaabaab
aaabababbabaabbababbbabbbaaababbbaababbabbbbbababbbabababababbabababaabb
bbaaaababaaabaabbbbaaaaa
aaabbbbbbbbbbbabababbaba
aaababbaaababaabaaabbaab
bbbbabbbabbbabbabbbabbba
bbbababbabbaababababbaba
bbbabbababbbaaaaabaaaabbbbbaabaa
bbbbbaabababaabbbbababab
abababbbbaabbabbabbbbabaaabaabaa
baaabbabbababbababaabbaa
aabbbabbbaaaaaaaaaababbbaaaababa
bbaaabbabaabbaaabaababbaabaabbbb
baaaaababbaaaabbbbaababbbbababbaabbaaabbbbaabbababbabbbabaabaabaaabbabba
abbbbabaabbaabbbabbbabab
bbbbaaaaaabababaababaabaababbaba
bbabbbababaaaaabbbaaaaaaabbbbbba
aaaaabbaabbbbaaaaaaaaabb
babbbbaaaaaabaaaaabbbbaa
bbbabababababbabbaaaaabaaaabaaaaaaaabaab
abaaaaaaabbaabbaabababbbaabaabba
abbabaababaabaaabbaabaab
bbaaaabaaababaababaabbba
abaaabaaabbaabbabaaaabbb
bbbaabbbbbbbabaaababbbab
ababaabbbabbbbaaabbabaaababbbaaa
abbaaaaabbaaabbbbbaaabaa
baabaabbbaaaabbabaaaabaa
abaaaababbabbbbabbbabbba
bbaababbbababababbbbaabaaabbbbbbaabbbbab
bbbbaabababaaababbbbaaab
abbabbaabaaabbbabaaabbbb
bbabbaaaababbbbaabbaaabaabaabababbbabaaaabbbabab
abababbbaababbbabbbaabba
baaabaabababaaaabbaaabaa
abbaaababaabbaaabababaaaaabaaaabbbabaabababbababbabbaaaabaaababbbabaabab
bbbbabbbaabbaaabbbaabbab
aabbabaaaabbbabbabbabbbbaabbaaaabbaabbaabaaaabbabaaabbbababbbabaaaabbbabaaaaabbabbbbaaaa
baaaaaaababbbbaababababb
bbbabbbbaaaabaaababbbbbb
abbbbbaaaabbababbbbabaaaabababbbbbbaabbaaaaababaaaaaaabb
aaabbabababababaababbbbbabaababb
baaabbaababbabbbbbaaabab
baababbbbbabaabbbaabbbbbbaaabbbbbbaaababaaaabaabbbbbbabbbababbabaabaabbbaaaabbba
aaaababbbbaaabbbaaaabbab
aabbbabbaaaaaaabaabbbbaa
babbaabbabbbbabaaabaaaab
bababaabbbbaaabbaabbbbba
aababbbaabbabaaabbabbbbb
aabaaabbaaaababbbabbbabb
bbbaaabaabbabaaabbbbbabb
aabbaabaababaabaaabaaabaabbbbaaabaabbbab
ababaababaababbbaabbbaaa
abbaaaaaabbabbabbaabaaba
abbbbbaabaaaaabbaaaaaabb
""".components(separatedBy: "\n\n")

let rulesCom = input[0].components(separatedBy: .newlines)
let msgs = input[1].components(separatedBy: .newlines)

var rulesD: [Int: [[Int]]] = [:]
var rulesV: [Int: String] = [:]

rulesCom.forEach {
    let com = $0.components(separatedBy: ": ")
    let k = Int(com[0])!

    if com[1].contains("\"") {
        rulesV[k] = com[1].replacingOccurrences(of: "\"", with: "")
    }
    else {
        let vCom = com[1].components(separatedBy: " | ")
        let v = vCom.map { $0.components(separatedBy: " ").map { Int($0)! } }
        rulesD[k] = v
    }
}

func check(_ message: String, _ index: Int) -> String? {
    var msg = message
    if let value = rulesV[index] {
        return msg.hasPrefix(value) ? String(msg.dropFirst(value.count)) : nil
    }
    else if let rules = rulesD[index] {
        let test = rules.contains { rs in
            msg = message
            for r in rs {
                if let text = check(msg, r) {
                    msg = text
                }
                else {
                   return false
                }
            }
            return true
        }
        return test ? msg : nil
    }

    return nil
}

func partOne() -> Int {
    var result = 0
    for msg in msgs {
        if let test = check(msg, 0), test.isEmpty {
            result += 1
        }
    }
    return result
}

func partTwo() -> Int {
    var changes: [[Int]] = []
    for c1 in (2...10).reversed() {
        let low = 1
        let high = min(11 - c1, c1 - 1)

        for c2 in (low...high).reversed() {
            let new42 = Array.init(repeating: 42, count: c1)
            let new31 = Array.init(repeating: 31, count: c2)
            changes.append(new42 + new31)
        }
    }

//    changes.map {
//        print($0, separator: "\n", terminator: "\n")
//    }

    rulesD[0] = changes

    return partOne()
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

