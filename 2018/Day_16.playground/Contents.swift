import Cocoa

let input = """
Before: [0, 3, 3, 0]
5 0 2 1
After:  [0, 0, 3, 0]

Before: [0, 2, 3, 2]
3 3 2 3
After:  [0, 2, 3, 4]

Before: [2, 1, 0, 0]
10 1 2 3
After:  [2, 1, 0, 2]

Before: [0, 2, 3, 3]
14 2 2 3
After:  [0, 2, 3, 2]

Before: [3, 2, 2, 2]
10 0 3 1
After:  [3, 9, 2, 2]

Before: [2, 2, 1, 0]
10 0 3 2
After:  [2, 2, 6, 0]

Before: [1, 1, 2, 0]
7 0 2 2
After:  [1, 1, 2, 0]

Before: [2, 1, 0, 1]
9 2 1 3
After:  [2, 1, 0, 1]

Before: [1, 2, 0, 0]
0 0 1 1
After:  [1, 3, 0, 0]

Before: [2, 2, 1, 0]
3 0 2 3
After:  [2, 2, 1, 4]

Before: [2, 0, 0, 1]
3 0 2 3
After:  [2, 0, 0, 4]

Before: [1, 1, 0, 2]
9 2 1 1
After:  [1, 1, 0, 2]

Before: [2, 1, 3, 3]
15 1 3 0
After:  [3, 1, 3, 3]

Before: [1, 3, 2, 1]
4 0 1 1
After:  [1, 1, 2, 1]

Before: [0, 1, 3, 0]
14 2 2 0
After:  [2, 1, 3, 0]

Before: [1, 2, 3, 2]
3 3 2 0
After:  [4, 2, 3, 2]

Before: [0, 1, 3, 2]
5 0 2 3
After:  [0, 1, 3, 0]

Before: [0, 1, 3, 0]
15 0 1 0
After:  [1, 1, 3, 0]

Before: [0, 0, 2, 1]
12 3 2 2
After:  [0, 0, 3, 1]

Before: [1, 1, 1, 2]
2 2 1 2
After:  [1, 1, 1, 2]

Before: [0, 3, 1, 2]
3 3 2 0
After:  [4, 3, 1, 2]

Before: [0, 3, 1, 3]
4 2 1 3
After:  [0, 3, 1, 1]

Before: [2, 2, 1, 2]
10 3 3 1
After:  [2, 6, 1, 2]

Before: [1, 1, 3, 1]
12 3 2 2
After:  [1, 1, 3, 1]

Before: [3, 3, 2, 1]
12 3 2 1
After:  [3, 3, 2, 1]

Before: [0, 2, 2, 0]
5 0 1 1
After:  [0, 0, 2, 0]

Before: [0, 1, 3, 2]
7 2 3 0
After:  [6, 1, 3, 2]

Before: [1, 0, 3, 2]
10 2 3 1
After:  [1, 9, 3, 2]

Before: [3, 0, 1, 0]
0 2 0 2
After:  [3, 0, 3, 0]

Before: [0, 1, 3, 2]
12 3 1 0
After:  [3, 1, 3, 2]

Before: [0, 3, 3, 1]
0 0 1 1
After:  [0, 3, 3, 1]

Before: [3, 0, 1, 2]
0 1 3 0
After:  [2, 0, 1, 2]

Before: [1, 0, 3, 2]
11 2 3 3
After:  [1, 0, 3, 2]

Before: [2, 0, 2, 3]
1 0 2 2
After:  [2, 0, 4, 3]

Before: [1, 2, 1, 0]
7 0 1 1
After:  [1, 2, 1, 0]

Before: [1, 2, 3, 1]
7 3 1 0
After:  [2, 2, 3, 1]

Before: [1, 2, 3, 1]
14 2 2 1
After:  [1, 2, 3, 1]

Before: [0, 1, 0, 2]
9 2 1 2
After:  [0, 1, 1, 2]

Before: [2, 0, 2, 0]
1 0 2 1
After:  [2, 4, 2, 0]

Before: [1, 2, 1, 1]
0 1 2 2
After:  [1, 2, 3, 1]

Before: [1, 2, 2, 3]
7 2 3 0
After:  [6, 2, 2, 3]

Before: [2, 0, 3, 3]
7 2 3 0
After:  [9, 0, 3, 3]

Before: [2, 3, 3, 1]
14 2 2 3
After:  [2, 3, 3, 2]

Before: [0, 2, 2, 2]
1 3 2 1
After:  [0, 4, 2, 2]

Before: [2, 3, 2, 1]
8 2 2 3
After:  [2, 3, 2, 2]

Before: [0, 2, 0, 0]
13 0 0 0
After:  [0, 2, 0, 0]

Before: [1, 1, 2, 1]
6 3 0 3
After:  [1, 1, 2, 1]

Before: [2, 1, 3, 3]
14 2 2 2
After:  [2, 1, 2, 3]

Before: [3, 2, 2, 0]
15 3 2 1
After:  [3, 2, 2, 0]

Before: [2, 3, 1, 0]
4 2 1 3
After:  [2, 3, 1, 1]

Before: [3, 1, 1, 0]
2 2 1 1
After:  [3, 1, 1, 0]

Before: [0, 3, 3, 3]
8 3 1 0
After:  [3, 3, 3, 3]

Before: [0, 1, 0, 2]
9 2 1 1
After:  [0, 1, 0, 2]

Before: [1, 1, 0, 0]
9 2 1 2
After:  [1, 1, 1, 0]

Before: [0, 0, 1, 1]
13 0 0 0
After:  [0, 0, 1, 1]

Before: [0, 2, 1, 1]
13 0 0 0
After:  [0, 2, 1, 1]

Before: [3, 1, 2, 1]
12 3 2 2
After:  [3, 1, 3, 1]

Before: [2, 2, 1, 2]
3 1 2 2
After:  [2, 2, 4, 2]

Before: [2, 2, 3, 1]
11 2 0 3
After:  [2, 2, 3, 2]

Before: [1, 0, 3, 2]
7 2 3 3
After:  [1, 0, 3, 6]

Before: [2, 2, 3, 2]
11 2 0 2
After:  [2, 2, 2, 2]

Before: [2, 1, 0, 1]
2 3 1 2
After:  [2, 1, 1, 1]

Before: [1, 1, 2, 2]
15 0 3 2
After:  [1, 1, 3, 2]

Before: [2, 2, 0, 3]
3 0 2 1
After:  [2, 4, 0, 3]

Before: [3, 3, 1, 2]
10 0 3 3
After:  [3, 3, 1, 9]

Before: [2, 1, 1, 1]
2 2 1 1
After:  [2, 1, 1, 1]

Before: [0, 3, 1, 0]
13 0 0 3
After:  [0, 3, 1, 0]

Before: [3, 3, 3, 0]
10 2 3 1
After:  [3, 9, 3, 0]

Before: [0, 1, 2, 0]
5 0 2 2
After:  [0, 1, 0, 0]

Before: [2, 1, 0, 2]
12 3 1 1
After:  [2, 3, 0, 2]

Before: [3, 2, 2, 2]
1 2 2 0
After:  [4, 2, 2, 2]

Before: [1, 1, 1, 0]
9 3 1 1
After:  [1, 1, 1, 0]

Before: [0, 1, 3, 2]
12 3 1 2
After:  [0, 1, 3, 2]

Before: [1, 3, 1, 1]
6 2 0 2
After:  [1, 3, 1, 1]

Before: [0, 0, 3, 3]
8 3 0 2
After:  [0, 0, 3, 3]

Before: [2, 1, 2, 3]
1 0 2 1
After:  [2, 4, 2, 3]

Before: [1, 3, 1, 1]
4 2 1 3
After:  [1, 3, 1, 1]

Before: [1, 1, 3, 1]
12 3 2 0
After:  [3, 1, 3, 1]

Before: [0, 2, 2, 3]
14 3 2 0
After:  [2, 2, 2, 3]

Before: [1, 3, 2, 1]
10 1 3 0
After:  [9, 3, 2, 1]

Before: [3, 2, 2, 3]
14 3 2 2
After:  [3, 2, 2, 3]

Before: [0, 0, 3, 3]
8 3 1 2
After:  [0, 0, 3, 3]

Before: [1, 2, 3, 3]
14 2 2 1
After:  [1, 2, 3, 3]

Before: [2, 0, 1, 2]
3 0 2 2
After:  [2, 0, 4, 2]

Before: [1, 3, 2, 2]
1 3 2 1
After:  [1, 4, 2, 2]

Before: [1, 2, 3, 1]
12 3 2 1
After:  [1, 3, 3, 1]

Before: [1, 3, 1, 3]
6 2 0 3
After:  [1, 3, 1, 1]

Before: [0, 2, 1, 2]
0 0 1 2
After:  [0, 2, 2, 2]

Before: [0, 0, 3, 1]
12 3 2 2
After:  [0, 0, 3, 1]

Before: [3, 3, 0, 0]
10 0 3 2
After:  [3, 3, 9, 0]

Before: [2, 2, 2, 2]
1 3 2 3
After:  [2, 2, 2, 4]

Before: [3, 0, 2, 3]
7 0 2 3
After:  [3, 0, 2, 6]

Before: [0, 2, 1, 0]
13 0 0 2
After:  [0, 2, 0, 0]

Before: [1, 3, 1, 3]
15 0 3 2
After:  [1, 3, 3, 3]

Before: [3, 0, 2, 1]
1 2 2 1
After:  [3, 4, 2, 1]

Before: [2, 1, 0, 1]
9 2 1 2
After:  [2, 1, 1, 1]

Before: [1, 0, 0, 1]
6 3 0 0
After:  [1, 0, 0, 1]

Before: [0, 3, 1, 1]
10 1 3 2
After:  [0, 3, 9, 1]

Before: [3, 2, 2, 0]
0 3 1 0
After:  [2, 2, 2, 0]

Before: [3, 1, 0, 0]
9 2 1 1
After:  [3, 1, 0, 0]

Before: [0, 3, 0, 3]
13 0 0 3
After:  [0, 3, 0, 0]

Before: [1, 1, 0, 0]
9 2 1 3
After:  [1, 1, 0, 1]

Before: [0, 0, 1, 3]
15 0 3 2
After:  [0, 0, 3, 3]

Before: [0, 3, 2, 2]
14 1 2 0
After:  [2, 3, 2, 2]

Before: [0, 3, 3, 0]
10 2 3 0
After:  [9, 3, 3, 0]

Before: [0, 3, 3, 3]
0 0 1 1
After:  [0, 3, 3, 3]

Before: [0, 2, 3, 0]
11 2 1 1
After:  [0, 2, 3, 0]

Before: [0, 1, 3, 2]
7 2 3 2
After:  [0, 1, 6, 2]

Before: [1, 3, 1, 2]
4 2 1 1
After:  [1, 1, 1, 2]

Before: [1, 3, 1, 1]
6 3 0 2
After:  [1, 3, 1, 1]

Before: [0, 1, 1, 3]
2 2 1 0
After:  [1, 1, 1, 3]

Before: [2, 1, 1, 1]
2 3 1 1
After:  [2, 1, 1, 1]

Before: [2, 3, 2, 1]
14 1 2 1
After:  [2, 2, 2, 1]

Before: [1, 1, 1, 1]
2 2 1 1
After:  [1, 1, 1, 1]

Before: [1, 1, 0, 1]
9 2 1 3
After:  [1, 1, 0, 1]

Before: [1, 2, 3, 3]
7 0 1 0
After:  [2, 2, 3, 3]

Before: [3, 1, 1, 2]
15 1 3 2
After:  [3, 1, 3, 2]

Before: [0, 3, 1, 1]
0 0 2 0
After:  [1, 3, 1, 1]

Before: [3, 2, 0, 0]
5 2 0 1
After:  [3, 0, 0, 0]

Before: [1, 0, 1, 1]
6 2 0 1
After:  [1, 1, 1, 1]

Before: [3, 1, 0, 3]
9 2 1 0
After:  [1, 1, 0, 3]

Before: [2, 0, 2, 2]
1 3 2 0
After:  [4, 0, 2, 2]

Before: [3, 0, 2, 2]
1 3 2 3
After:  [3, 0, 2, 4]

Before: [3, 3, 1, 2]
4 2 1 2
After:  [3, 3, 1, 2]

Before: [2, 3, 3, 1]
14 2 2 2
After:  [2, 3, 2, 1]

Before: [0, 3, 1, 0]
13 0 0 2
After:  [0, 3, 0, 0]

Before: [0, 3, 3, 2]
10 2 3 3
After:  [0, 3, 3, 9]

Before: [0, 3, 3, 2]
10 3 3 2
After:  [0, 3, 6, 2]

Before: [0, 0, 1, 0]
5 1 0 0
After:  [0, 0, 1, 0]

Before: [2, 3, 1, 2]
3 0 2 3
After:  [2, 3, 1, 4]

Before: [2, 1, 2, 0]
1 0 2 0
After:  [4, 1, 2, 0]

Before: [1, 2, 0, 3]
3 1 2 2
After:  [1, 2, 4, 3]

Before: [1, 1, 2, 1]
2 3 1 3
After:  [1, 1, 2, 1]

Before: [2, 1, 0, 1]
9 2 1 0
After:  [1, 1, 0, 1]

Before: [1, 2, 3, 1]
4 3 1 1
After:  [1, 1, 3, 1]

Before: [0, 0, 2, 3]
15 1 2 3
After:  [0, 0, 2, 2]

Before: [3, 3, 1, 1]
10 1 3 1
After:  [3, 9, 1, 1]

Before: [3, 1, 0, 2]
9 2 1 2
After:  [3, 1, 1, 2]

Before: [0, 1, 2, 1]
15 2 1 1
After:  [0, 3, 2, 1]

Before: [1, 0, 3, 0]
10 0 2 2
After:  [1, 0, 2, 0]

Before: [1, 2, 3, 1]
12 3 2 3
After:  [1, 2, 3, 3]

Before: [0, 1, 3, 0]
13 0 0 2
After:  [0, 1, 0, 0]

Before: [1, 2, 1, 3]
6 2 0 3
After:  [1, 2, 1, 1]

Before: [0, 0, 2, 1]
5 0 3 2
After:  [0, 0, 0, 1]

Before: [3, 1, 3, 1]
2 3 1 1
After:  [3, 1, 3, 1]

Before: [2, 0, 2, 2]
1 3 2 1
After:  [2, 4, 2, 2]

Before: [1, 1, 0, 2]
9 2 1 0
After:  [1, 1, 0, 2]

Before: [1, 3, 3, 2]
4 0 1 1
After:  [1, 1, 3, 2]

Before: [1, 1, 3, 0]
9 3 1 2
After:  [1, 1, 1, 0]

Before: [0, 1, 1, 2]
12 3 1 1
After:  [0, 3, 1, 2]

Before: [3, 1, 2, 3]
14 3 2 2
After:  [3, 1, 2, 3]

Before: [1, 2, 3, 3]
7 3 3 0
After:  [9, 2, 3, 3]

Before: [0, 0, 2, 1]
8 2 2 2
After:  [0, 0, 2, 1]

Before: [1, 3, 0, 1]
4 0 1 3
After:  [1, 3, 0, 1]

Before: [1, 1, 2, 1]
6 3 0 1
After:  [1, 1, 2, 1]

Before: [2, 2, 3, 2]
14 2 2 0
After:  [2, 2, 3, 2]

Before: [2, 3, 0, 3]
3 0 2 0
After:  [4, 3, 0, 3]

Before: [2, 0, 3, 2]
5 1 0 2
After:  [2, 0, 0, 2]

Before: [3, 2, 2, 3]
7 0 3 1
After:  [3, 9, 2, 3]

Before: [0, 0, 1, 0]
0 0 2 2
After:  [0, 0, 1, 0]

Before: [2, 3, 1, 3]
7 1 3 1
After:  [2, 9, 1, 3]

Before: [2, 1, 1, 0]
9 3 1 0
After:  [1, 1, 1, 0]

Before: [2, 0, 3, 1]
11 2 0 1
After:  [2, 2, 3, 1]

Before: [0, 2, 1, 1]
5 0 1 0
After:  [0, 2, 1, 1]

Before: [3, 1, 1, 2]
12 3 1 0
After:  [3, 1, 1, 2]

Before: [1, 3, 3, 2]
7 2 3 0
After:  [6, 3, 3, 2]

Before: [2, 1, 0, 2]
3 0 2 3
After:  [2, 1, 0, 4]

Before: [2, 3, 2, 2]
8 2 2 2
After:  [2, 3, 2, 2]

Before: [0, 3, 1, 3]
7 3 3 3
After:  [0, 3, 1, 9]

Before: [2, 2, 3, 1]
11 2 0 2
After:  [2, 2, 2, 1]

Before: [0, 2, 1, 0]
5 0 1 2
After:  [0, 2, 0, 0]

Before: [2, 0, 2, 1]
10 0 3 1
After:  [2, 6, 2, 1]

Before: [1, 3, 2, 0]
14 1 2 0
After:  [2, 3, 2, 0]

Before: [1, 3, 3, 0]
4 0 1 0
After:  [1, 3, 3, 0]

Before: [1, 3, 2, 2]
10 3 3 3
After:  [1, 3, 2, 6]

Before: [1, 1, 2, 0]
7 1 2 0
After:  [2, 1, 2, 0]

Before: [1, 2, 0, 1]
6 3 0 1
After:  [1, 1, 0, 1]

Before: [0, 2, 3, 1]
11 2 1 0
After:  [2, 2, 3, 1]

Before: [0, 3, 1, 2]
3 3 2 1
After:  [0, 4, 1, 2]

Before: [2, 3, 1, 1]
10 1 3 2
After:  [2, 3, 9, 1]

Before: [1, 2, 1, 3]
15 2 3 1
After:  [1, 3, 1, 3]

Before: [1, 1, 3, 2]
14 2 2 3
After:  [1, 1, 3, 2]

Before: [2, 1, 0, 0]
9 3 1 0
After:  [1, 1, 0, 0]

Before: [1, 3, 1, 0]
4 0 1 1
After:  [1, 1, 1, 0]

Before: [3, 1, 1, 1]
10 0 3 2
After:  [3, 1, 9, 1]

Before: [1, 2, 3, 0]
10 1 3 1
After:  [1, 6, 3, 0]

Before: [3, 2, 3, 0]
0 3 1 2
After:  [3, 2, 2, 0]

Before: [0, 2, 2, 2]
8 2 0 3
After:  [0, 2, 2, 2]

Before: [2, 1, 2, 2]
15 1 3 1
After:  [2, 3, 2, 2]

Before: [0, 1, 2, 1]
2 3 1 0
After:  [1, 1, 2, 1]

Before: [3, 2, 1, 2]
10 0 3 0
After:  [9, 2, 1, 2]

Before: [2, 0, 0, 0]
3 0 2 0
After:  [4, 0, 0, 0]

Before: [1, 1, 0, 2]
12 3 1 0
After:  [3, 1, 0, 2]

Before: [3, 1, 3, 3]
7 3 3 1
After:  [3, 9, 3, 3]

Before: [2, 2, 2, 3]
8 2 0 1
After:  [2, 2, 2, 3]

Before: [0, 1, 2, 3]
14 3 2 2
After:  [0, 1, 2, 3]

Before: [1, 3, 1, 3]
4 2 1 0
After:  [1, 3, 1, 3]

Before: [2, 3, 1, 3]
3 0 2 3
After:  [2, 3, 1, 4]

Before: [2, 1, 2, 2]
1 0 2 0
After:  [4, 1, 2, 2]

Before: [1, 1, 1, 3]
2 2 1 1
After:  [1, 1, 1, 3]

Before: [1, 3, 2, 1]
4 0 1 2
After:  [1, 3, 1, 1]

Before: [0, 2, 1, 0]
5 0 2 2
After:  [0, 2, 0, 0]

Before: [3, 0, 3, 3]
8 3 0 0
After:  [3, 0, 3, 3]

Before: [1, 2, 2, 2]
7 0 2 1
After:  [1, 2, 2, 2]

Before: [0, 3, 2, 0]
5 0 1 1
After:  [0, 0, 2, 0]

Before: [3, 2, 3, 1]
12 3 2 3
After:  [3, 2, 3, 3]

Before: [1, 2, 3, 2]
3 3 2 1
After:  [1, 4, 3, 2]

Before: [1, 3, 2, 2]
7 0 2 0
After:  [2, 3, 2, 2]

Before: [3, 0, 2, 3]
15 1 3 1
After:  [3, 3, 2, 3]

Before: [2, 2, 3, 1]
4 3 1 2
After:  [2, 2, 1, 1]

Before: [2, 2, 0, 1]
3 1 2 1
After:  [2, 4, 0, 1]

Before: [0, 0, 2, 3]
14 3 2 1
After:  [0, 2, 2, 3]

Before: [1, 0, 2, 1]
6 3 0 2
After:  [1, 0, 1, 1]

Before: [1, 3, 2, 3]
4 0 1 2
After:  [1, 3, 1, 3]

Before: [0, 3, 1, 2]
5 0 3 1
After:  [0, 0, 1, 2]

Before: [0, 2, 3, 2]
0 0 2 0
After:  [3, 2, 3, 2]

Before: [0, 1, 0, 0]
9 3 1 0
After:  [1, 1, 0, 0]

Before: [3, 2, 3, 2]
14 2 2 1
After:  [3, 2, 3, 2]

Before: [0, 3, 2, 0]
5 0 1 3
After:  [0, 3, 2, 0]

Before: [3, 2, 3, 1]
14 2 2 0
After:  [2, 2, 3, 1]

Before: [3, 1, 1, 3]
8 3 1 0
After:  [3, 1, 1, 3]

Before: [0, 3, 0, 1]
13 0 0 1
After:  [0, 0, 0, 1]

Before: [2, 2, 0, 0]
3 1 2 3
After:  [2, 2, 0, 4]

Before: [1, 0, 2, 1]
6 3 0 0
After:  [1, 0, 2, 1]

Before: [1, 3, 0, 2]
4 0 1 3
After:  [1, 3, 0, 1]

Before: [1, 3, 2, 2]
0 0 1 3
After:  [1, 3, 2, 3]

Before: [0, 2, 2, 0]
1 2 2 2
After:  [0, 2, 4, 0]

Before: [0, 3, 1, 2]
0 2 1 2
After:  [0, 3, 3, 2]

Before: [0, 2, 0, 2]
0 0 1 0
After:  [2, 2, 0, 2]

Before: [0, 1, 1, 1]
13 0 0 3
After:  [0, 1, 1, 0]

Before: [2, 1, 3, 0]
9 3 1 2
After:  [2, 1, 1, 0]

Before: [1, 2, 0, 3]
7 1 3 2
After:  [1, 2, 6, 3]

Before: [0, 0, 3, 3]
0 1 2 2
After:  [0, 0, 3, 3]

Before: [1, 2, 3, 2]
3 1 2 1
After:  [1, 4, 3, 2]

Before: [0, 2, 0, 0]
3 1 2 0
After:  [4, 2, 0, 0]

Before: [2, 2, 1, 3]
7 3 3 3
After:  [2, 2, 1, 9]

Before: [3, 0, 0, 3]
10 3 2 2
After:  [3, 0, 6, 3]

Before: [1, 1, 0, 0]
9 3 1 2
After:  [1, 1, 1, 0]

Before: [2, 2, 0, 3]
3 0 2 3
After:  [2, 2, 0, 4]

Before: [0, 1, 2, 3]
1 2 2 1
After:  [0, 4, 2, 3]

Before: [1, 0, 1, 0]
6 2 0 3
After:  [1, 0, 1, 1]

Before: [1, 2, 0, 3]
0 1 0 0
After:  [3, 2, 0, 3]

Before: [0, 1, 3, 0]
9 3 1 3
After:  [0, 1, 3, 1]

Before: [0, 1, 0, 3]
9 2 1 1
After:  [0, 1, 0, 3]

Before: [1, 3, 2, 0]
4 0 1 3
After:  [1, 3, 2, 1]

Before: [2, 0, 3, 3]
3 0 2 1
After:  [2, 4, 3, 3]

Before: [2, 2, 3, 1]
11 2 1 3
After:  [2, 2, 3, 2]

Before: [3, 2, 0, 2]
3 1 2 1
After:  [3, 4, 0, 2]

Before: [0, 1, 0, 1]
13 0 0 3
After:  [0, 1, 0, 0]

Before: [1, 3, 2, 3]
7 3 3 0
After:  [9, 3, 2, 3]

Before: [0, 2, 2, 1]
4 3 1 2
After:  [0, 2, 1, 1]

Before: [0, 3, 1, 3]
13 0 0 2
After:  [0, 3, 0, 3]

Before: [0, 2, 1, 1]
0 2 1 3
After:  [0, 2, 1, 3]

Before: [3, 1, 0, 3]
10 3 2 3
After:  [3, 1, 0, 6]

Before: [2, 2, 1, 1]
7 3 1 2
After:  [2, 2, 2, 1]

Before: [0, 1, 0, 2]
15 1 3 1
After:  [0, 3, 0, 2]

Before: [2, 3, 3, 2]
7 2 3 0
After:  [6, 3, 3, 2]

Before: [2, 1, 3, 1]
2 3 1 1
After:  [2, 1, 3, 1]

Before: [1, 1, 2, 3]
15 1 2 0
After:  [3, 1, 2, 3]

Before: [3, 2, 3, 0]
14 2 2 2
After:  [3, 2, 2, 0]

Before: [0, 3, 0, 2]
0 0 1 1
After:  [0, 3, 0, 2]

Before: [0, 3, 3, 1]
13 0 0 1
After:  [0, 0, 3, 1]

Before: [1, 1, 0, 1]
9 2 1 2
After:  [1, 1, 1, 1]

Before: [1, 3, 2, 1]
10 2 3 2
After:  [1, 3, 6, 1]

Before: [2, 1, 1, 1]
2 3 1 2
After:  [2, 1, 1, 1]

Before: [0, 0, 0, 1]
5 2 0 0
After:  [0, 0, 0, 1]

Before: [0, 1, 2, 3]
5 0 2 2
After:  [0, 1, 0, 3]

Before: [2, 3, 3, 0]
11 2 0 3
After:  [2, 3, 3, 2]

Before: [2, 1, 3, 3]
7 0 3 0
After:  [6, 1, 3, 3]

Before: [3, 2, 1, 0]
0 2 0 1
After:  [3, 3, 1, 0]

Before: [3, 1, 1, 2]
2 2 1 2
After:  [3, 1, 1, 2]

Before: [1, 1, 2, 0]
1 2 2 2
After:  [1, 1, 4, 0]

Before: [2, 2, 0, 3]
7 1 3 0
After:  [6, 2, 0, 3]

Before: [3, 1, 0, 0]
9 3 1 3
After:  [3, 1, 0, 1]

Before: [3, 0, 0, 3]
0 1 0 2
After:  [3, 0, 3, 3]

Before: [3, 1, 3, 0]
9 3 1 2
After:  [3, 1, 1, 0]

Before: [0, 1, 3, 0]
5 0 1 1
After:  [0, 0, 3, 0]

Before: [2, 2, 0, 1]
4 3 1 0
After:  [1, 2, 0, 1]

Before: [0, 0, 2, 2]
1 2 2 1
After:  [0, 4, 2, 2]

Before: [0, 1, 3, 2]
14 2 2 3
After:  [0, 1, 3, 2]

Before: [1, 3, 1, 0]
4 2 1 1
After:  [1, 1, 1, 0]

Before: [2, 3, 1, 2]
15 2 3 0
After:  [3, 3, 1, 2]

Before: [1, 1, 0, 2]
12 3 1 2
After:  [1, 1, 3, 2]

Before: [1, 1, 3, 1]
10 0 2 2
After:  [1, 1, 2, 1]

Before: [2, 0, 1, 0]
0 0 2 1
After:  [2, 3, 1, 0]

Before: [0, 1, 1, 2]
12 3 1 3
After:  [0, 1, 1, 3]

Before: [3, 1, 0, 0]
9 3 1 2
After:  [3, 1, 1, 0]

Before: [3, 3, 0, 3]
7 0 3 0
After:  [9, 3, 0, 3]

Before: [3, 0, 2, 2]
5 1 0 2
After:  [3, 0, 0, 2]

Before: [0, 3, 0, 3]
0 2 1 2
After:  [0, 3, 3, 3]

Before: [2, 1, 1, 0]
0 2 0 0
After:  [3, 1, 1, 0]

Before: [0, 0, 2, 1]
13 0 0 1
After:  [0, 0, 2, 1]

Before: [1, 3, 2, 1]
6 3 0 3
After:  [1, 3, 2, 1]

Before: [0, 3, 0, 2]
3 3 2 3
After:  [0, 3, 0, 4]

Before: [0, 3, 3, 3]
13 0 0 0
After:  [0, 3, 3, 3]

Before: [2, 0, 2, 2]
1 3 2 3
After:  [2, 0, 2, 4]

Before: [1, 3, 0, 1]
6 3 0 3
After:  [1, 3, 0, 1]

Before: [0, 2, 3, 1]
13 0 0 3
After:  [0, 2, 3, 0]

Before: [1, 0, 0, 3]
8 3 3 1
After:  [1, 3, 0, 3]

Before: [1, 1, 3, 1]
6 3 0 0
After:  [1, 1, 3, 1]

Before: [1, 0, 2, 1]
6 3 0 1
After:  [1, 1, 2, 1]

Before: [0, 1, 2, 3]
13 0 0 1
After:  [0, 0, 2, 3]

Before: [2, 2, 3, 1]
11 2 1 0
After:  [2, 2, 3, 1]

Before: [2, 0, 2, 1]
12 3 2 0
After:  [3, 0, 2, 1]

Before: [0, 3, 3, 3]
14 2 2 3
After:  [0, 3, 3, 2]

Before: [3, 2, 2, 1]
12 3 2 1
After:  [3, 3, 2, 1]

Before: [3, 1, 0, 3]
15 2 3 2
After:  [3, 1, 3, 3]

Before: [0, 3, 2, 2]
8 2 0 1
After:  [0, 2, 2, 2]

Before: [2, 1, 0, 3]
0 1 0 0
After:  [3, 1, 0, 3]

Before: [3, 1, 1, 3]
2 2 1 0
After:  [1, 1, 1, 3]

Before: [1, 0, 2, 2]
1 2 2 0
After:  [4, 0, 2, 2]

Before: [2, 3, 2, 3]
1 2 2 2
After:  [2, 3, 4, 3]

Before: [1, 3, 2, 0]
14 1 2 1
After:  [1, 2, 2, 0]

Before: [3, 1, 1, 1]
0 2 0 2
After:  [3, 1, 3, 1]

Before: [1, 2, 3, 2]
11 2 3 3
After:  [1, 2, 3, 2]

Before: [1, 3, 3, 3]
8 3 3 2
After:  [1, 3, 3, 3]

Before: [0, 3, 3, 2]
13 0 0 0
After:  [0, 3, 3, 2]

Before: [0, 3, 2, 0]
1 2 2 3
After:  [0, 3, 2, 4]

Before: [3, 1, 2, 0]
10 2 3 3
After:  [3, 1, 2, 6]

Before: [3, 1, 2, 0]
9 3 1 0
After:  [1, 1, 2, 0]

Before: [3, 0, 2, 0]
5 1 0 2
After:  [3, 0, 0, 0]

Before: [0, 2, 3, 3]
13 0 0 2
After:  [0, 2, 0, 3]

Before: [2, 3, 1, 1]
0 0 2 3
After:  [2, 3, 1, 3]

Before: [1, 2, 2, 1]
0 1 0 3
After:  [1, 2, 2, 3]

Before: [1, 2, 2, 1]
4 3 1 1
After:  [1, 1, 2, 1]

Before: [1, 1, 1, 0]
2 2 1 2
After:  [1, 1, 1, 0]

Before: [1, 0, 1, 1]
6 2 0 0
After:  [1, 0, 1, 1]

Before: [0, 0, 1, 1]
13 0 0 1
After:  [0, 0, 1, 1]

Before: [3, 1, 2, 0]
9 3 1 3
After:  [3, 1, 2, 1]

Before: [3, 3, 0, 3]
8 3 3 0
After:  [3, 3, 0, 3]

Before: [3, 1, 0, 2]
5 2 0 1
After:  [3, 0, 0, 2]

Before: [2, 1, 3, 2]
11 2 3 3
After:  [2, 1, 3, 2]

Before: [1, 1, 1, 1]
6 3 0 2
After:  [1, 1, 1, 1]

Before: [3, 1, 0, 0]
9 2 1 3
After:  [3, 1, 0, 1]

Before: [0, 2, 0, 3]
8 3 0 1
After:  [0, 3, 0, 3]

Before: [1, 2, 2, 3]
0 1 0 0
After:  [3, 2, 2, 3]

Before: [1, 1, 3, 3]
15 1 2 1
After:  [1, 3, 3, 3]

Before: [1, 2, 2, 3]
7 0 1 3
After:  [1, 2, 2, 2]

Before: [3, 3, 3, 3]
14 2 2 1
After:  [3, 2, 3, 3]

Before: [0, 1, 3, 3]
8 3 1 3
After:  [0, 1, 3, 3]

Before: [2, 2, 3, 3]
11 2 1 3
After:  [2, 2, 3, 2]

Before: [0, 0, 2, 1]
8 2 2 0
After:  [2, 0, 2, 1]

Before: [1, 3, 3, 1]
12 3 2 1
After:  [1, 3, 3, 1]

Before: [0, 3, 0, 2]
0 0 3 0
After:  [2, 3, 0, 2]

Before: [1, 1, 3, 2]
3 3 2 2
After:  [1, 1, 4, 2]

Before: [1, 2, 0, 0]
3 1 2 3
After:  [1, 2, 0, 4]

Before: [2, 0, 2, 1]
0 1 0 0
After:  [2, 0, 2, 1]

Before: [0, 3, 2, 3]
1 2 2 2
After:  [0, 3, 4, 3]

Before: [2, 1, 2, 0]
7 1 2 2
After:  [2, 1, 2, 0]

Before: [3, 2, 3, 1]
4 3 1 0
After:  [1, 2, 3, 1]

Before: [2, 1, 3, 1]
12 3 2 0
After:  [3, 1, 3, 1]

Before: [0, 1, 0, 2]
13 0 0 2
After:  [0, 1, 0, 2]

Before: [2, 2, 0, 1]
3 1 2 2
After:  [2, 2, 4, 1]

Before: [1, 2, 1, 3]
6 2 0 1
After:  [1, 1, 1, 3]

Before: [3, 3, 1, 0]
10 1 3 2
After:  [3, 3, 9, 0]

Before: [3, 1, 0, 1]
10 1 2 0
After:  [2, 1, 0, 1]

Before: [1, 1, 0, 2]
9 2 1 3
After:  [1, 1, 0, 1]

Before: [2, 3, 1, 1]
4 2 1 2
After:  [2, 3, 1, 1]

Before: [0, 2, 2, 0]
1 1 2 2
After:  [0, 2, 4, 0]

Before: [0, 1, 1, 1]
2 3 1 0
After:  [1, 1, 1, 1]

Before: [1, 3, 2, 1]
14 1 2 1
After:  [1, 2, 2, 1]

Before: [1, 2, 2, 1]
7 3 1 1
After:  [1, 2, 2, 1]

Before: [2, 2, 3, 0]
3 1 2 1
After:  [2, 4, 3, 0]

Before: [2, 2, 3, 3]
3 0 2 3
After:  [2, 2, 3, 4]

Before: [3, 2, 0, 1]
4 3 1 3
After:  [3, 2, 0, 1]

Before: [1, 2, 0, 2]
10 0 2 0
After:  [2, 2, 0, 2]

Before: [1, 1, 2, 1]
6 3 0 2
After:  [1, 1, 1, 1]

Before: [0, 3, 2, 3]
13 0 0 1
After:  [0, 0, 2, 3]

Before: [3, 1, 2, 2]
14 0 2 3
After:  [3, 1, 2, 2]

Before: [1, 2, 1, 0]
6 2 0 0
After:  [1, 2, 1, 0]

Before: [3, 3, 3, 0]
14 2 2 1
After:  [3, 2, 3, 0]

Before: [0, 1, 0, 3]
8 3 0 1
After:  [0, 3, 0, 3]

Before: [1, 3, 2, 1]
14 1 2 0
After:  [2, 3, 2, 1]

Before: [0, 1, 2, 1]
5 0 3 1
After:  [0, 0, 2, 1]

Before: [3, 3, 3, 2]
10 0 3 2
After:  [3, 3, 9, 2]

Before: [0, 3, 1, 1]
4 2 1 2
After:  [0, 3, 1, 1]

Before: [3, 0, 0, 0]
5 1 0 0
After:  [0, 0, 0, 0]

Before: [2, 0, 0, 3]
5 1 0 1
After:  [2, 0, 0, 3]

Before: [1, 3, 2, 1]
1 2 2 0
After:  [4, 3, 2, 1]

Before: [2, 3, 2, 3]
8 2 0 0
After:  [2, 3, 2, 3]

Before: [1, 2, 1, 1]
6 2 0 2
After:  [1, 2, 1, 1]

Before: [3, 1, 1, 1]
2 2 1 3
After:  [3, 1, 1, 1]

Before: [3, 2, 2, 0]
1 1 2 2
After:  [3, 2, 4, 0]

Before: [2, 0, 3, 3]
8 3 3 1
After:  [2, 3, 3, 3]

Before: [1, 1, 3, 1]
6 3 0 1
After:  [1, 1, 3, 1]

Before: [0, 0, 2, 3]
14 3 2 3
After:  [0, 0, 2, 2]

Before: [1, 2, 1, 0]
6 2 0 2
After:  [1, 2, 1, 0]

Before: [3, 0, 2, 1]
7 0 2 0
After:  [6, 0, 2, 1]

Before: [0, 2, 3, 1]
11 2 1 2
After:  [0, 2, 2, 1]

Before: [2, 0, 3, 3]
3 0 2 2
After:  [2, 0, 4, 3]

Before: [0, 3, 3, 2]
14 2 2 3
After:  [0, 3, 3, 2]

Before: [1, 3, 1, 3]
6 2 0 1
After:  [1, 1, 1, 3]

Before: [1, 2, 3, 2]
11 2 3 0
After:  [2, 2, 3, 2]

Before: [1, 1, 2, 2]
12 3 1 1
After:  [1, 3, 2, 2]

Before: [3, 1, 3, 3]
14 2 2 0
After:  [2, 1, 3, 3]

Before: [3, 2, 3, 1]
4 3 1 2
After:  [3, 2, 1, 1]

Before: [0, 3, 2, 0]
8 2 0 2
After:  [0, 3, 2, 0]

Before: [3, 0, 2, 0]
10 2 3 3
After:  [3, 0, 2, 6]

Before: [1, 0, 3, 2]
14 2 2 0
After:  [2, 0, 3, 2]

Before: [1, 1, 2, 2]
12 3 1 2
After:  [1, 1, 3, 2]

Before: [0, 3, 2, 0]
5 0 1 2
After:  [0, 3, 0, 0]

Before: [1, 1, 1, 2]
2 2 1 1
After:  [1, 1, 1, 2]

Before: [0, 1, 0, 1]
9 2 1 2
After:  [0, 1, 1, 1]

Before: [2, 3, 3, 3]
11 2 0 3
After:  [2, 3, 3, 2]

Before: [0, 0, 1, 3]
15 2 3 1
After:  [0, 3, 1, 3]

Before: [1, 2, 1, 1]
3 1 2 2
After:  [1, 2, 4, 1]

Before: [2, 3, 0, 2]
3 3 2 0
After:  [4, 3, 0, 2]

Before: [3, 1, 3, 2]
12 3 1 3
After:  [3, 1, 3, 3]

Before: [3, 0, 1, 3]
15 2 3 3
After:  [3, 0, 1, 3]

Before: [1, 1, 1, 0]
9 3 1 0
After:  [1, 1, 1, 0]

Before: [2, 2, 3, 1]
10 2 3 2
After:  [2, 2, 9, 1]

Before: [0, 1, 1, 2]
12 3 1 0
After:  [3, 1, 1, 2]

Before: [0, 0, 0, 3]
15 0 3 1
After:  [0, 3, 0, 3]

Before: [3, 1, 1, 2]
2 2 1 1
After:  [3, 1, 1, 2]

Before: [1, 0, 0, 1]
6 3 0 2
After:  [1, 0, 1, 1]

Before: [1, 0, 1, 2]
6 2 0 2
After:  [1, 0, 1, 2]

Before: [1, 1, 1, 2]
2 2 1 3
After:  [1, 1, 1, 1]

Before: [1, 1, 1, 1]
6 2 0 1
After:  [1, 1, 1, 1]

Before: [2, 1, 2, 3]
8 3 1 3
After:  [2, 1, 2, 3]

Before: [3, 1, 1, 3]
7 3 3 2
After:  [3, 1, 9, 3]

Before: [2, 2, 3, 1]
11 2 1 1
After:  [2, 2, 3, 1]

Before: [1, 3, 0, 2]
4 0 1 0
After:  [1, 3, 0, 2]

Before: [0, 0, 3, 3]
0 0 2 1
After:  [0, 3, 3, 3]

Before: [0, 1, 3, 1]
2 3 1 0
After:  [1, 1, 3, 1]

Before: [3, 1, 1, 3]
8 3 0 2
After:  [3, 1, 3, 3]

Before: [1, 2, 1, 0]
6 2 0 1
After:  [1, 1, 1, 0]

Before: [1, 1, 0, 0]
9 3 1 0
After:  [1, 1, 0, 0]

Before: [3, 1, 0, 1]
9 2 1 1
After:  [3, 1, 0, 1]

Before: [0, 0, 2, 3]
8 2 0 3
After:  [0, 0, 2, 2]

Before: [0, 2, 3, 3]
14 2 2 0
After:  [2, 2, 3, 3]

Before: [2, 1, 1, 1]
15 0 1 3
After:  [2, 1, 1, 3]

Before: [3, 1, 1, 2]
3 3 2 0
After:  [4, 1, 1, 2]

Before: [0, 3, 1, 1]
5 0 3 3
After:  [0, 3, 1, 0]

Before: [0, 0, 2, 0]
15 3 2 1
After:  [0, 2, 2, 0]

Before: [1, 2, 0, 3]
8 3 3 0
After:  [3, 2, 0, 3]

Before: [1, 0, 1, 1]
6 3 0 0
After:  [1, 0, 1, 1]

Before: [0, 1, 1, 2]
0 0 2 3
After:  [0, 1, 1, 1]

Before: [1, 1, 3, 1]
6 3 0 3
After:  [1, 1, 3, 1]

Before: [1, 1, 2, 3]
8 2 2 2
After:  [1, 1, 2, 3]

Before: [0, 1, 2, 0]
9 3 1 2
After:  [0, 1, 1, 0]

Before: [1, 2, 1, 1]
6 3 0 0
After:  [1, 2, 1, 1]

Before: [2, 1, 1, 0]
9 3 1 1
After:  [2, 1, 1, 0]

Before: [1, 2, 3, 3]
0 0 1 2
After:  [1, 2, 3, 3]

Before: [0, 1, 0, 0]
13 0 0 1
After:  [0, 0, 0, 0]

Before: [2, 1, 3, 2]
12 3 1 1
After:  [2, 3, 3, 2]

Before: [3, 1, 2, 1]
2 3 1 2
After:  [3, 1, 1, 1]

Before: [0, 2, 2, 0]
5 0 2 3
After:  [0, 2, 2, 0]

Before: [1, 3, 0, 3]
4 0 1 0
After:  [1, 3, 0, 3]

Before: [2, 1, 2, 2]
12 3 1 3
After:  [2, 1, 2, 3]

Before: [2, 2, 0, 3]
3 0 2 2
After:  [2, 2, 4, 3]

Before: [2, 1, 2, 2]
8 2 0 3
After:  [2, 1, 2, 2]

Before: [1, 3, 1, 2]
6 2 0 3
After:  [1, 3, 1, 1]

Before: [0, 1, 2, 0]
15 0 1 3
After:  [0, 1, 2, 1]

Before: [2, 2, 1, 2]
3 3 2 0
After:  [4, 2, 1, 2]

Before: [3, 1, 2, 0]
1 2 2 1
After:  [3, 4, 2, 0]

Before: [1, 2, 2, 3]
7 1 3 3
After:  [1, 2, 2, 6]

Before: [2, 1, 1, 2]
0 1 0 2
After:  [2, 1, 3, 2]

Before: [0, 3, 3, 2]
11 2 3 1
After:  [0, 2, 3, 2]

Before: [0, 1, 0, 0]
9 3 1 1
After:  [0, 1, 0, 0]

Before: [1, 3, 3, 2]
11 2 3 2
After:  [1, 3, 2, 2]

Before: [1, 2, 1, 3]
6 2 0 0
After:  [1, 2, 1, 3]

Before: [1, 0, 1, 3]
6 2 0 3
After:  [1, 0, 1, 1]

Before: [0, 2, 2, 2]
15 0 2 1
After:  [0, 2, 2, 2]

Before: [3, 3, 0, 3]
5 2 0 2
After:  [3, 3, 0, 3]

Before: [3, 3, 3, 3]
14 2 2 0
After:  [2, 3, 3, 3]

Before: [3, 0, 0, 3]
8 3 3 3
After:  [3, 0, 0, 3]

Before: [0, 3, 2, 0]
13 0 0 1
After:  [0, 0, 2, 0]

Before: [3, 1, 3, 0]
9 3 1 3
After:  [3, 1, 3, 1]

Before: [0, 1, 0, 3]
9 2 1 2
After:  [0, 1, 1, 3]

Before: [3, 3, 1, 1]
4 2 1 1
After:  [3, 1, 1, 1]

Before: [0, 1, 3, 1]
12 3 2 1
After:  [0, 3, 3, 1]

Before: [1, 3, 2, 0]
8 2 2 3
After:  [1, 3, 2, 2]

Before: [0, 0, 3, 1]
13 0 0 2
After:  [0, 0, 0, 1]

Before: [0, 2, 3, 2]
13 0 0 3
After:  [0, 2, 3, 0]

Before: [0, 0, 3, 1]
13 0 0 0
After:  [0, 0, 3, 1]

Before: [1, 3, 2, 0]
7 1 2 1
After:  [1, 6, 2, 0]

Before: [3, 3, 0, 2]
0 2 0 1
After:  [3, 3, 0, 2]

Before: [3, 2, 0, 0]
10 1 3 1
After:  [3, 6, 0, 0]

Before: [3, 2, 1, 0]
10 0 3 0
After:  [9, 2, 1, 0]

Before: [1, 1, 1, 1]
2 2 1 2
After:  [1, 1, 1, 1]

Before: [2, 1, 3, 3]
11 2 0 1
After:  [2, 2, 3, 3]

Before: [2, 3, 3, 3]
14 2 2 0
After:  [2, 3, 3, 3]

Before: [0, 1, 1, 0]
9 3 1 0
After:  [1, 1, 1, 0]

Before: [1, 1, 2, 0]
9 3 1 3
After:  [1, 1, 2, 1]

Before: [2, 3, 2, 0]
1 2 2 0
After:  [4, 3, 2, 0]

Before: [3, 2, 1, 0]
3 1 2 1
After:  [3, 4, 1, 0]

Before: [1, 3, 2, 3]
15 0 2 1
After:  [1, 3, 2, 3]

Before: [2, 0, 1, 3]
8 3 3 3
After:  [2, 0, 1, 3]

Before: [3, 1, 0, 1]
2 3 1 3
After:  [3, 1, 0, 1]

Before: [0, 1, 1, 0]
13 0 0 3
After:  [0, 1, 1, 0]

Before: [1, 3, 1, 3]
0 0 1 1
After:  [1, 3, 1, 3]

Before: [1, 0, 2, 2]
15 0 2 1
After:  [1, 3, 2, 2]

Before: [1, 2, 2, 1]
12 3 2 2
After:  [1, 2, 3, 1]

Before: [1, 3, 3, 1]
10 0 2 0
After:  [2, 3, 3, 1]

Before: [2, 1, 0, 1]
2 3 1 0
After:  [1, 1, 0, 1]

Before: [1, 0, 1, 1]
6 3 0 1
After:  [1, 1, 1, 1]

Before: [3, 3, 1, 1]
4 2 1 0
After:  [1, 3, 1, 1]

Before: [0, 3, 0, 3]
13 0 0 0
After:  [0, 3, 0, 3]

Before: [0, 1, 0, 3]
13 0 0 0
After:  [0, 1, 0, 3]

Before: [2, 2, 3, 2]
11 2 0 3
After:  [2, 2, 3, 2]

Before: [2, 3, 1, 1]
4 2 1 1
After:  [2, 1, 1, 1]

Before: [1, 3, 3, 2]
11 2 3 3
After:  [1, 3, 3, 2]

Before: [1, 3, 0, 0]
4 0 1 0
After:  [1, 3, 0, 0]

Before: [0, 1, 1, 2]
2 2 1 2
After:  [0, 1, 1, 2]

Before: [1, 2, 2, 1]
0 2 0 3
After:  [1, 2, 2, 3]

Before: [2, 0, 3, 1]
12 3 2 0
After:  [3, 0, 3, 1]

Before: [0, 1, 1, 2]
2 2 1 3
After:  [0, 1, 1, 1]

Before: [1, 1, 0, 3]
7 3 3 3
After:  [1, 1, 0, 9]

Before: [1, 3, 1, 1]
6 2 0 0
After:  [1, 3, 1, 1]

Before: [3, 1, 3, 3]
8 3 3 0
After:  [3, 1, 3, 3]

Before: [3, 3, 2, 2]
14 0 2 0
After:  [2, 3, 2, 2]

Before: [0, 2, 0, 2]
3 1 2 2
After:  [0, 2, 4, 2]

Before: [0, 1, 1, 1]
2 2 1 2
After:  [0, 1, 1, 1]

Before: [1, 3, 0, 3]
4 0 1 1
After:  [1, 1, 0, 3]

Before: [0, 3, 2, 1]
0 0 1 2
After:  [0, 3, 3, 1]

Before: [3, 2, 2, 2]
1 3 2 1
After:  [3, 4, 2, 2]

Before: [0, 3, 2, 3]
8 2 2 3
After:  [0, 3, 2, 2]

Before: [2, 0, 3, 2]
3 0 2 3
After:  [2, 0, 3, 4]

Before: [1, 2, 3, 1]
11 2 1 1
After:  [1, 2, 3, 1]

Before: [0, 2, 3, 0]
11 2 1 3
After:  [0, 2, 3, 2]

Before: [1, 0, 1, 2]
6 2 0 0
After:  [1, 0, 1, 2]

Before: [0, 0, 2, 3]
13 0 0 0
After:  [0, 0, 2, 3]

Before: [0, 0, 3, 2]
11 2 3 0
After:  [2, 0, 3, 2]

Before: [0, 3, 1, 2]
4 2 1 1
After:  [0, 1, 1, 2]

Before: [0, 1, 1, 2]
15 2 3 0
After:  [3, 1, 1, 2]

Before: [0, 1, 2, 2]
13 0 0 0
After:  [0, 1, 2, 2]

Before: [2, 1, 0, 1]
2 3 1 1
After:  [2, 1, 0, 1]

Before: [2, 1, 1, 1]
2 3 1 3
After:  [2, 1, 1, 1]

Before: [0, 0, 0, 0]
5 3 0 0
After:  [0, 0, 0, 0]

Before: [1, 2, 2, 1]
10 1 3 3
After:  [1, 2, 2, 6]

Before: [3, 3, 2, 3]
14 1 2 1
After:  [3, 2, 2, 3]

Before: [1, 1, 1, 1]
6 3 0 3
After:  [1, 1, 1, 1]

Before: [2, 3, 3, 0]
11 2 0 1
After:  [2, 2, 3, 0]

Before: [1, 0, 3, 3]
8 3 3 2
After:  [1, 0, 3, 3]

Before: [1, 3, 1, 1]
10 1 2 2
After:  [1, 3, 6, 1]

Before: [3, 0, 0, 2]
5 2 0 2
After:  [3, 0, 0, 2]

Before: [3, 1, 3, 0]
14 2 2 0
After:  [2, 1, 3, 0]

Before: [3, 3, 3, 2]
11 2 3 3
After:  [3, 3, 3, 2]

Before: [3, 3, 3, 3]
8 3 1 3
After:  [3, 3, 3, 3]

Before: [0, 0, 2, 0]
8 2 0 0
After:  [2, 0, 2, 0]

Before: [2, 2, 2, 1]
1 2 2 0
After:  [4, 2, 2, 1]

Before: [2, 2, 3, 0]
11 2 1 1
After:  [2, 2, 3, 0]

Before: [3, 2, 2, 3]
14 0 2 3
After:  [3, 2, 2, 2]

Before: [2, 1, 2, 3]
1 0 2 0
After:  [4, 1, 2, 3]

Before: [3, 1, 1, 0]
9 3 1 0
After:  [1, 1, 1, 0]

Before: [1, 3, 1, 3]
4 2 1 1
After:  [1, 1, 1, 3]

Before: [2, 0, 0, 1]
3 0 2 2
After:  [2, 0, 4, 1]

Before: [2, 0, 3, 2]
14 2 2 2
After:  [2, 0, 2, 2]

Before: [0, 1, 3, 1]
5 0 1 0
After:  [0, 1, 3, 1]

Before: [0, 3, 1, 3]
8 3 0 0
After:  [3, 3, 1, 3]

Before: [1, 2, 3, 1]
15 0 2 2
After:  [1, 2, 3, 1]

Before: [2, 2, 3, 2]
11 2 3 2
After:  [2, 2, 2, 2]

Before: [0, 3, 3, 3]
14 2 2 1
After:  [0, 2, 3, 3]

Before: [1, 0, 3, 0]
14 2 2 0
After:  [2, 0, 3, 0]

Before: [1, 2, 1, 0]
6 2 0 3
After:  [1, 2, 1, 1]

Before: [2, 0, 2, 2]
0 1 3 0
After:  [2, 0, 2, 2]

Before: [0, 1, 2, 1]
8 2 2 0
After:  [2, 1, 2, 1]

Before: [0, 2, 2, 1]
12 3 2 3
After:  [0, 2, 2, 3]

Before: [1, 3, 2, 3]
7 2 3 3
After:  [1, 3, 2, 6]

Before: [3, 1, 0, 0]
0 2 0 3
After:  [3, 1, 0, 3]

Before: [1, 3, 2, 3]
4 0 1 1
After:  [1, 1, 2, 3]

Before: [0, 2, 2, 1]
13 0 0 0
After:  [0, 2, 2, 1]

Before: [3, 1, 2, 3]
8 3 3 2
After:  [3, 1, 3, 3]

Before: [0, 1, 1, 3]
2 2 1 1
After:  [0, 1, 1, 3]

Before: [2, 2, 1, 1]
4 3 1 2
After:  [2, 2, 1, 1]

Before: [2, 1, 0, 0]
9 3 1 1
After:  [2, 1, 0, 0]

Before: [3, 1, 2, 2]
12 3 1 0
After:  [3, 1, 2, 2]

Before: [0, 1, 1, 2]
3 3 2 2
After:  [0, 1, 4, 2]

Before: [0, 2, 3, 0]
11 2 1 0
After:  [2, 2, 3, 0]

Before: [2, 0, 1, 3]
3 0 2 2
After:  [2, 0, 4, 3]

Before: [3, 2, 3, 2]
11 2 1 3
After:  [3, 2, 3, 2]

Before: [1, 1, 1, 0]
6 2 0 0
After:  [1, 1, 1, 0]

Before: [1, 1, 1, 3]
2 2 1 0
After:  [1, 1, 1, 3]

Before: [1, 2, 2, 1]
7 0 2 3
After:  [1, 2, 2, 2]

Before: [3, 2, 0, 2]
3 3 2 2
After:  [3, 2, 4, 2]

Before: [1, 2, 0, 3]
3 1 2 0
After:  [4, 2, 0, 3]

Before: [1, 2, 3, 1]
4 3 1 2
After:  [1, 2, 1, 1]

Before: [3, 2, 2, 1]
14 0 2 2
After:  [3, 2, 2, 1]

Before: [2, 1, 3, 2]
11 2 3 2
After:  [2, 1, 2, 2]

Before: [0, 3, 1, 3]
5 0 3 3
After:  [0, 3, 1, 0]

Before: [3, 3, 2, 0]
1 2 2 1
After:  [3, 4, 2, 0]

Before: [1, 1, 0, 2]
9 2 1 2
After:  [1, 1, 1, 2]

Before: [3, 0, 2, 1]
12 3 2 3
After:  [3, 0, 2, 3]

Before: [3, 3, 0, 1]
10 0 3 1
After:  [3, 9, 0, 1]

Before: [0, 2, 3, 1]
10 1 3 2
After:  [0, 2, 6, 1]

Before: [2, 0, 2, 0]
10 2 3 3
After:  [2, 0, 2, 6]

Before: [0, 3, 2, 1]
5 0 2 0
After:  [0, 3, 2, 1]

Before: [3, 1, 3, 0]
9 3 1 1
After:  [3, 1, 3, 0]

Before: [0, 2, 2, 3]
8 3 0 3
After:  [0, 2, 2, 3]

Before: [0, 3, 0, 1]
13 0 0 2
After:  [0, 3, 0, 1]

Before: [0, 0, 0, 1]
13 0 0 0
After:  [0, 0, 0, 1]

Before: [1, 2, 0, 1]
6 3 0 2
After:  [1, 2, 1, 1]

Before: [2, 3, 2, 0]
15 3 2 1
After:  [2, 2, 2, 0]

Before: [1, 0, 2, 2]
0 2 0 1
After:  [1, 3, 2, 2]

Before: [2, 2, 0, 2]
10 0 3 3
After:  [2, 2, 0, 6]

Before: [2, 2, 3, 3]
8 3 3 1
After:  [2, 3, 3, 3]

Before: [0, 2, 3, 3]
5 0 3 2
After:  [0, 2, 0, 3]

Before: [0, 1, 2, 2]
8 2 2 0
After:  [2, 1, 2, 2]

Before: [2, 2, 2, 2]
8 2 2 3
After:  [2, 2, 2, 2]

Before: [1, 3, 1, 2]
4 0 1 0
After:  [1, 3, 1, 2]

Before: [2, 2, 3, 1]
14 2 2 0
After:  [2, 2, 3, 1]

Before: [3, 1, 1, 0]
9 3 1 1
After:  [3, 1, 1, 0]

Before: [1, 3, 3, 1]
6 3 0 2
After:  [1, 3, 1, 1]

Before: [3, 1, 0, 2]
9 2 1 1
After:  [3, 1, 0, 2]

Before: [2, 0, 3, 0]
11 2 0 3
After:  [2, 0, 3, 2]

Before: [0, 0, 3, 3]
8 3 3 2
After:  [0, 0, 3, 3]

Before: [3, 1, 3, 1]
15 1 2 0
After:  [3, 1, 3, 1]

Before: [3, 3, 2, 1]
12 3 2 3
After:  [3, 3, 2, 3]

Before: [1, 0, 1, 2]
6 2 0 1
After:  [1, 1, 1, 2]

Before: [2, 3, 1, 0]
4 2 1 2
After:  [2, 3, 1, 0]

Before: [2, 1, 2, 0]
9 3 1 1
After:  [2, 1, 2, 0]

Before: [2, 3, 2, 3]
8 3 1 0
After:  [3, 3, 2, 3]

Before: [0, 2, 1, 1]
4 3 1 2
After:  [0, 2, 1, 1]

Before: [0, 0, 0, 1]
13 0 0 3
After:  [0, 0, 0, 0]

Before: [0, 1, 2, 1]
8 2 2 3
After:  [0, 1, 2, 2]

Before: [1, 1, 0, 1]
10 3 2 1
After:  [1, 2, 0, 1]

Before: [1, 1, 1, 3]
6 2 0 0
After:  [1, 1, 1, 3]

Before: [1, 3, 1, 3]
6 2 0 2
After:  [1, 3, 1, 3]

Before: [2, 3, 3, 2]
11 2 3 0
After:  [2, 3, 3, 2]

Before: [1, 2, 0, 3]
8 3 3 2
After:  [1, 2, 3, 3]

Before: [2, 1, 1, 3]
10 3 2 0
After:  [6, 1, 1, 3]

Before: [2, 1, 1, 3]
2 2 1 1
After:  [2, 1, 1, 3]

Before: [1, 0, 2, 3]
1 2 2 2
After:  [1, 0, 4, 3]

Before: [3, 2, 2, 1]
8 2 2 3
After:  [3, 2, 2, 2]

Before: [1, 1, 0, 2]
12 3 1 3
After:  [1, 1, 0, 3]

Before: [0, 2, 3, 3]
5 0 2 1
After:  [0, 0, 3, 3]

Before: [0, 1, 3, 2]
3 3 2 1
After:  [0, 4, 3, 2]

Before: [0, 2, 3, 1]
14 2 2 3
After:  [0, 2, 3, 2]

Before: [3, 3, 3, 2]
7 2 3 3
After:  [3, 3, 3, 6]

Before: [1, 3, 2, 3]
14 3 2 1
After:  [1, 2, 2, 3]

Before: [0, 2, 3, 0]
13 0 0 2
After:  [0, 2, 0, 0]

Before: [0, 1, 0, 3]
13 0 0 2
After:  [0, 1, 0, 3]

Before: [1, 1, 1, 1]
6 2 0 3
After:  [1, 1, 1, 1]

Before: [1, 2, 3, 0]
3 1 2 1
After:  [1, 4, 3, 0]

Before: [0, 0, 3, 3]
15 0 3 1
After:  [0, 3, 3, 3]

Before: [0, 2, 3, 1]
11 2 1 3
After:  [0, 2, 3, 2]

Before: [1, 3, 2, 3]
14 1 2 0
After:  [2, 3, 2, 3]

Before: [0, 1, 0, 1]
2 3 1 0
After:  [1, 1, 0, 1]

Before: [0, 3, 1, 1]
13 0 0 3
After:  [0, 3, 1, 0]

Before: [0, 1, 3, 2]
11 2 3 1
After:  [0, 2, 3, 2]

Before: [3, 1, 1, 2]
12 3 1 2
After:  [3, 1, 3, 2]

Before: [3, 2, 3, 2]
3 1 2 0
After:  [4, 2, 3, 2]

Before: [0, 2, 3, 3]
5 0 3 0
After:  [0, 2, 3, 3]

Before: [3, 3, 0, 1]
5 2 0 1
After:  [3, 0, 0, 1]

Before: [1, 1, 1, 0]
6 2 0 2
After:  [1, 1, 1, 0]

Before: [1, 3, 1, 0]
6 2 0 1
After:  [1, 1, 1, 0]

Before: [0, 3, 1, 2]
0 0 3 1
After:  [0, 2, 1, 2]

Before: [0, 3, 1, 3]
0 2 1 0
After:  [3, 3, 1, 3]

Before: [1, 2, 3, 1]
6 3 0 1
After:  [1, 1, 3, 1]

Before: [0, 3, 1, 1]
4 2 1 3
After:  [0, 3, 1, 1]

Before: [1, 1, 1, 2]
12 3 1 3
After:  [1, 1, 1, 3]

Before: [3, 1, 3, 2]
10 0 3 3
After:  [3, 1, 3, 9]

Before: [0, 3, 0, 0]
5 2 0 2
After:  [0, 3, 0, 0]

Before: [2, 1, 1, 2]
12 3 1 0
After:  [3, 1, 1, 2]

Before: [2, 2, 3, 3]
7 1 3 1
After:  [2, 6, 3, 3]

Before: [1, 2, 2, 3]
7 0 1 0
After:  [2, 2, 2, 3]

Before: [2, 2, 0, 1]
3 0 2 2
After:  [2, 2, 4, 1]

Before: [1, 2, 0, 1]
3 1 2 3
After:  [1, 2, 0, 4]

Before: [0, 2, 0, 1]
4 3 1 1
After:  [0, 1, 0, 1]

Before: [3, 2, 2, 2]
1 1 2 1
After:  [3, 4, 2, 2]

Before: [2, 2, 1, 1]
0 1 2 0
After:  [3, 2, 1, 1]

Before: [1, 3, 3, 3]
4 0 1 3
After:  [1, 3, 3, 1]

Before: [1, 3, 1, 3]
8 3 3 0
After:  [3, 3, 1, 3]

Before: [3, 1, 1, 1]
10 0 3 3
After:  [3, 1, 1, 9]

Before: [2, 2, 0, 3]
3 1 2 3
After:  [2, 2, 0, 4]

Before: [1, 1, 3, 1]
15 0 2 3
After:  [1, 1, 3, 3]

Before: [1, 3, 2, 2]
1 3 2 3
After:  [1, 3, 2, 4]

Before: [3, 0, 2, 1]
8 2 2 0
After:  [2, 0, 2, 1]

Before: [3, 3, 2, 1]
7 0 2 2
After:  [3, 3, 6, 1]

Before: [3, 3, 2, 3]
14 1 2 2
After:  [3, 3, 2, 3]

Before: [3, 2, 0, 2]
3 3 2 0
After:  [4, 2, 0, 2]

Before: [2, 1, 1, 0]
2 2 1 2
After:  [2, 1, 1, 0]

Before: [1, 0, 3, 3]
14 2 2 1
After:  [1, 2, 3, 3]

Before: [1, 3, 2, 2]
14 1 2 2
After:  [1, 3, 2, 2]

Before: [1, 0, 3, 1]
12 3 2 0
After:  [3, 0, 3, 1]

Before: [3, 1, 3, 2]
11 2 3 1
After:  [3, 2, 3, 2]

Before: [2, 2, 2, 1]
1 2 2 1
After:  [2, 4, 2, 1]

Before: [3, 1, 3, 0]
9 3 1 0
After:  [1, 1, 3, 0]

Before: [3, 2, 2, 2]
1 1 2 3
After:  [3, 2, 2, 4]

Before: [1, 3, 2, 1]
6 3 0 1
After:  [1, 1, 2, 1]

Before: [0, 2, 2, 0]
0 0 1 2
After:  [0, 2, 2, 0]

Before: [0, 0, 0, 0]
5 1 0 1
After:  [0, 0, 0, 0]

Before: [0, 1, 2, 0]
1 2 2 0
After:  [4, 1, 2, 0]

Before: [2, 0, 3, 3]
11 2 0 2
After:  [2, 0, 2, 3]

Before: [3, 3, 2, 2]
14 1 2 1
After:  [3, 2, 2, 2]

Before: [1, 1, 0, 1]
9 2 1 0
After:  [1, 1, 0, 1]

Before: [2, 3, 0, 3]
7 0 3 2
After:  [2, 3, 6, 3]

Before: [2, 3, 3, 1]
12 3 2 2
After:  [2, 3, 3, 1]

Before: [0, 2, 3, 3]
11 2 1 3
After:  [0, 2, 3, 2]

Before: [3, 3, 0, 2]
5 2 0 1
After:  [3, 0, 0, 2]

Before: [1, 1, 1, 1]
6 3 0 1
After:  [1, 1, 1, 1]

Before: [2, 3, 0, 3]
10 3 2 1
After:  [2, 6, 0, 3]

Before: [2, 1, 2, 2]
7 1 2 0
After:  [2, 1, 2, 2]

Before: [0, 2, 2, 2]
1 1 2 0
After:  [4, 2, 2, 2]

Before: [0, 3, 1, 2]
10 3 3 2
After:  [0, 3, 6, 2]

Before: [3, 2, 3, 3]
3 1 2 3
After:  [3, 2, 3, 4]

Before: [1, 1, 2, 3]
7 3 3 1
After:  [1, 9, 2, 3]

Before: [2, 3, 3, 3]
3 0 2 2
After:  [2, 3, 4, 3]

Before: [1, 3, 1, 1]
6 2 0 1
After:  [1, 1, 1, 1]

Before: [3, 1, 1, 3]
15 2 3 3
After:  [3, 1, 1, 3]

Before: [1, 0, 2, 3]
8 3 0 3
After:  [1, 0, 2, 3]

Before: [0, 3, 2, 2]
14 1 2 3
After:  [0, 3, 2, 2]

Before: [1, 1, 0, 0]
9 3 1 1
After:  [1, 1, 0, 0]

Before: [2, 2, 3, 3]
3 1 2 2
After:  [2, 2, 4, 3]

Before: [2, 2, 3, 3]
11 2 0 1
After:  [2, 2, 3, 3]

Before: [0, 2, 0, 2]
3 3 2 3
After:  [0, 2, 0, 4]

Before: [2, 3, 2, 0]
10 2 3 1
After:  [2, 6, 2, 0]

Before: [3, 2, 3, 0]
11 2 1 3
After:  [3, 2, 3, 2]

Before: [1, 2, 3, 0]
15 0 2 2
After:  [1, 2, 3, 0]

Before: [0, 3, 1, 1]
4 2 1 0
After:  [1, 3, 1, 1]

Before: [1, 0, 3, 3]
7 2 3 1
After:  [1, 9, 3, 3]

Before: [2, 1, 3, 1]
11 2 0 0
After:  [2, 1, 3, 1]

Before: [0, 1, 2, 0]
15 0 1 0
After:  [1, 1, 2, 0]

Before: [1, 2, 1, 2]
6 2 0 0
After:  [1, 2, 1, 2]

Before: [3, 0, 2, 1]
12 3 2 1
After:  [3, 3, 2, 1]

Before: [0, 3, 2, 1]
12 3 2 3
After:  [0, 3, 2, 3]

Before: [0, 1, 0, 0]
9 2 1 3
After:  [0, 1, 0, 1]

Before: [1, 1, 1, 1]
2 2 1 3
After:  [1, 1, 1, 1]

Before: [3, 2, 3, 2]
11 2 3 1
After:  [3, 2, 3, 2]

Before: [3, 2, 3, 1]
10 2 3 3
After:  [3, 2, 3, 9]

Before: [1, 1, 3, 2]
11 2 3 3
After:  [1, 1, 3, 2]

Before: [0, 2, 1, 0]
3 1 2 2
After:  [0, 2, 4, 0]

Before: [0, 0, 1, 1]
5 0 3 3
After:  [0, 0, 1, 0]

Before: [1, 1, 1, 2]
6 2 0 3
After:  [1, 1, 1, 1]

Before: [0, 3, 1, 3]
4 2 1 2
After:  [0, 3, 1, 3]

Before: [2, 0, 1, 0]
5 1 0 3
After:  [2, 0, 1, 0]

Before: [2, 3, 2, 1]
14 1 2 2
After:  [2, 3, 2, 1]

Before: [0, 0, 1, 3]
15 1 3 3
After:  [0, 0, 1, 3]

Before: [2, 3, 0, 2]
7 1 3 0
After:  [6, 3, 0, 2]

Before: [1, 3, 0, 1]
6 3 0 2
After:  [1, 3, 1, 1]

Before: [3, 1, 3, 1]
12 3 2 2
After:  [3, 1, 3, 1]

Before: [2, 1, 3, 1]
10 3 2 3
After:  [2, 1, 3, 2]

Before: [0, 1, 0, 0]
9 2 1 1
After:  [0, 1, 0, 0]

Before: [2, 1, 2, 1]
8 2 0 0
After:  [2, 1, 2, 1]

Before: [3, 2, 2, 2]
10 0 3 3
After:  [3, 2, 2, 9]

Before: [0, 1, 3, 1]
2 3 1 2
After:  [0, 1, 1, 1]

Before: [1, 3, 3, 3]
15 0 2 0
After:  [3, 3, 3, 3]

Before: [3, 2, 2, 1]
12 3 2 0
After:  [3, 2, 2, 1]

Before: [0, 3, 2, 1]
12 3 2 1
After:  [0, 3, 2, 1]

Before: [0, 0, 2, 0]
8 2 2 1
After:  [0, 2, 2, 0]

Before: [0, 3, 0, 3]
7 3 3 2
After:  [0, 3, 9, 3]

Before: [1, 2, 2, 2]
7 0 1 0
After:  [2, 2, 2, 2]

Before: [0, 1, 1, 3]
5 0 3 0
After:  [0, 1, 1, 3]

Before: [2, 0, 3, 3]
0 1 2 2
After:  [2, 0, 3, 3]

Before: [3, 1, 0, 0]
9 2 1 2
After:  [3, 1, 1, 0]

Before: [0, 0, 0, 3]
8 3 0 1
After:  [0, 3, 0, 3]

Before: [3, 1, 2, 1]
12 3 2 3
After:  [3, 1, 2, 3]

Before: [3, 2, 0, 2]
5 2 0 0
After:  [0, 2, 0, 2]

Before: [0, 2, 1, 3]
7 3 3 3
After:  [0, 2, 1, 9]

Before: [2, 3, 2, 2]
1 2 2 0
After:  [4, 3, 2, 2]

Before: [1, 3, 2, 0]
7 0 2 1
After:  [1, 2, 2, 0]

Before: [0, 3, 3, 1]
12 3 2 2
After:  [0, 3, 3, 1]

Before: [3, 3, 1, 2]
4 2 1 1
After:  [3, 1, 1, 2]

Before: [0, 1, 3, 3]
15 1 2 0
After:  [3, 1, 3, 3]

Before: [0, 3, 1, 3]
8 3 0 2
After:  [0, 3, 3, 3]

Before: [3, 1, 2, 2]
15 1 3 3
After:  [3, 1, 2, 3]

Before: [0, 1, 2, 0]
13 0 0 1
After:  [0, 0, 2, 0]

Before: [1, 0, 1, 3]
7 3 3 2
After:  [1, 0, 9, 3]

Before: [2, 0, 1, 3]
7 0 3 3
After:  [2, 0, 1, 6]

Before: [0, 3, 1, 0]
4 2 1 0
After:  [1, 3, 1, 0]

Before: [0, 0, 0, 3]
13 0 0 3
After:  [0, 0, 0, 0]

Before: [2, 1, 0, 2]
9 2 1 0
After:  [1, 1, 0, 2]

Before: [1, 0, 0, 2]
3 3 2 3
After:  [1, 0, 0, 4]

Before: [0, 1, 0, 0]
9 2 1 2
After:  [0, 1, 1, 0]

Before: [3, 3, 0, 0]
10 1 3 2
After:  [3, 3, 9, 0]

Before: [0, 0, 2, 2]
15 1 2 3
After:  [0, 0, 2, 2]

Before: [1, 3, 1, 0]
4 2 1 2
After:  [1, 3, 1, 0]

Before: [0, 3, 0, 3]
13 0 0 1
After:  [0, 0, 0, 3]

Before: [0, 0, 3, 0]
5 1 0 0
After:  [0, 0, 3, 0]

Before: [0, 1, 1, 3]
2 2 1 3
After:  [0, 1, 1, 1]

Before: [0, 0, 2, 1]
12 3 2 0
After:  [3, 0, 2, 1]

Before: [0, 2, 2, 2]
5 0 1 0
After:  [0, 2, 2, 2]

Before: [0, 3, 1, 2]
13 0 0 1
After:  [0, 0, 1, 2]

Before: [0, 1, 2, 2]
7 1 2 2
After:  [0, 1, 2, 2]

Before: [1, 3, 1, 1]
4 0 1 1
After:  [1, 1, 1, 1]

Before: [0, 1, 0, 1]
9 2 1 0
After:  [1, 1, 0, 1]

Before: [0, 2, 3, 3]
7 3 3 3
After:  [0, 2, 3, 9]

Before: [0, 0, 2, 1]
10 2 3 1
After:  [0, 6, 2, 1]

Before: [3, 2, 3, 2]
11 2 3 3
After:  [3, 2, 3, 2]

Before: [2, 1, 1, 2]
12 3 1 3
After:  [2, 1, 1, 3]

Before: [0, 3, 3, 3]
13 0 0 1
After:  [0, 0, 3, 3]

Before: [0, 0, 2, 0]
13 0 0 3
After:  [0, 0, 2, 0]

Before: [2, 2, 3, 3]
3 1 2 0
After:  [4, 2, 3, 3]

Before: [1, 3, 3, 2]
10 1 3 1
After:  [1, 9, 3, 2]

Before: [0, 1, 2, 1]
2 3 1 3
After:  [0, 1, 2, 1]

Before: [2, 3, 1, 1]
0 2 1 1
After:  [2, 3, 1, 1]

Before: [1, 1, 0, 1]
9 2 1 1
After:  [1, 1, 0, 1]

Before: [3, 2, 1, 2]
10 3 3 1
After:  [3, 6, 1, 2]

Before: [1, 0, 2, 2]
0 1 3 3
After:  [1, 0, 2, 2]

Before: [3, 3, 2, 2]
14 0 2 3
After:  [3, 3, 2, 2]

Before: [2, 3, 0, 2]
10 1 2 2
After:  [2, 3, 6, 2]

Before: [1, 3, 2, 0]
4 0 1 0
After:  [1, 3, 2, 0]

Before: [1, 1, 1, 0]
2 2 1 1
After:  [1, 1, 1, 0]

Before: [1, 1, 2, 1]
2 3 1 0
After:  [1, 1, 2, 1]

Before: [0, 3, 0, 3]
15 0 3 0
After:  [3, 3, 0, 3]

Before: [0, 2, 2, 3]
8 2 0 2
After:  [0, 2, 2, 3]

Before: [0, 3, 3, 0]
13 0 0 3
After:  [0, 3, 3, 0]

Before: [3, 2, 2, 1]
4 3 1 1
After:  [3, 1, 2, 1]

Before: [3, 2, 2, 0]
14 0 2 0
After:  [2, 2, 2, 0]

Before: [0, 0, 1, 3]
7 3 3 3
After:  [0, 0, 1, 9]

Before: [2, 3, 3, 2]
11 2 3 2
After:  [2, 3, 2, 2]

Before: [1, 2, 3, 2]
11 2 1 0
After:  [2, 2, 3, 2]

Before: [1, 1, 3, 1]
12 3 2 3
After:  [1, 1, 3, 3]

Before: [2, 3, 1, 2]
3 0 2 1
After:  [2, 4, 1, 2]

Before: [1, 2, 1, 1]
6 3 0 2
After:  [1, 2, 1, 1]

Before: [0, 1, 2, 0]
9 3 1 3
After:  [0, 1, 2, 1]

Before: [1, 0, 2, 1]
15 0 2 1
After:  [1, 3, 2, 1]

Before: [1, 0, 2, 1]
12 3 2 0
After:  [3, 0, 2, 1]

Before: [3, 1, 2, 3]
8 3 3 0
After:  [3, 1, 2, 3]

Before: [1, 0, 2, 2]
15 1 2 2
After:  [1, 0, 2, 2]

Before: [2, 0, 1, 2]
0 2 0 1
After:  [2, 3, 1, 2]

Before: [1, 3, 1, 2]
4 2 1 3
After:  [1, 3, 1, 1]

Before: [0, 0, 0, 3]
5 2 0 2
After:  [0, 0, 0, 3]

Before: [2, 1, 2, 3]
1 2 2 0
After:  [4, 1, 2, 3]

Before: [0, 1, 1, 0]
2 2 1 1
After:  [0, 1, 1, 0]

Before: [1, 1, 1, 0]
6 2 0 1
After:  [1, 1, 1, 0]

Before: [2, 2, 1, 1]
3 0 2 3
After:  [2, 2, 1, 4]

Before: [0, 2, 3, 1]
4 3 1 2
After:  [0, 2, 1, 1]

Before: [2, 0, 2, 2]
8 2 2 3
After:  [2, 0, 2, 2]

Before: [1, 3, 1, 0]
0 0 1 2
After:  [1, 3, 3, 0]

Before: [1, 2, 1, 1]
6 3 0 1
After:  [1, 1, 1, 1]

Before: [1, 2, 0, 0]
7 0 1 0
After:  [2, 2, 0, 0]

Before: [1, 2, 2, 1]
12 3 2 1
After:  [1, 3, 2, 1]

Before: [0, 1, 1, 0]
2 2 1 2
After:  [0, 1, 1, 0]



12 3 3 2
12 3 2 0
12 2 1 1
0 1 2 1
10 1 1 1
1 1 3 3
8 3 1 1
10 2 0 2
3 2 2 2
12 0 2 3
12 2 2 0
9 3 2 3
10 3 2 3
1 1 3 1
8 1 3 3
10 0 0 1
3 1 1 1
10 2 0 0
3 0 3 0
0 2 0 1
10 1 1 1
1 3 1 3
12 2 0 0
10 1 0 1
3 1 1 1
12 3 1 2
7 1 0 2
10 2 1 2
1 3 2 3
8 3 2 2
10 2 0 1
3 1 2 1
12 0 0 3
12 3 0 0
11 0 1 1
10 1 2 1
10 1 1 1
1 1 2 2
12 0 0 1
12 1 3 3
12 2 1 0
12 3 1 0
10 0 2 0
1 2 0 2
8 2 2 3
10 1 0 1
3 1 1 1
10 3 0 0
3 0 3 0
12 0 2 2
4 2 0 2
10 2 3 2
10 2 1 2
1 3 2 3
12 2 1 2
10 0 0 1
3 1 2 1
6 2 0 0
10 0 3 0
1 3 0 3
8 3 1 1
12 0 1 2
12 2 2 3
12 2 3 0
2 0 3 2
10 2 1 2
1 2 1 1
12 1 1 3
12 0 1 2
13 0 3 0
10 0 2 0
1 0 1 1
8 1 2 2
12 2 0 1
12 2 2 3
12 2 0 0
2 0 3 1
10 1 3 1
1 1 2 2
8 2 0 1
12 1 0 3
10 3 0 0
3 0 1 0
12 2 0 2
8 0 2 0
10 0 2 0
1 0 1 1
8 1 3 0
12 3 2 2
12 3 1 1
12 3 3 3
12 2 3 1
10 1 3 1
1 0 1 0
12 0 2 2
12 0 3 3
12 2 2 1
15 1 3 3
10 3 1 3
1 0 3 0
8 0 0 3
12 2 3 0
12 3 2 2
12 3 0 1
6 0 1 0
10 0 3 0
1 0 3 3
8 3 3 1
12 1 3 2
12 2 1 0
12 2 2 3
2 0 3 0
10 0 3 0
1 1 0 1
12 2 0 0
10 3 0 2
3 2 3 2
15 0 3 2
10 2 1 2
10 2 3 2
1 1 2 1
10 2 0 0
3 0 3 0
12 0 1 2
5 2 3 2
10 2 1 2
1 1 2 1
8 1 2 0
12 3 3 3
12 1 3 2
12 3 1 1
14 1 2 3
10 3 3 3
10 3 1 3
1 0 3 0
8 0 2 2
10 2 0 0
3 0 3 0
12 1 0 1
12 2 1 3
7 1 3 1
10 1 3 1
1 2 1 2
8 2 1 1
12 1 1 0
12 2 0 2
12 3 2 3
8 0 2 0
10 0 2 0
1 1 0 1
8 1 2 3
12 0 1 2
12 0 1 0
10 1 0 1
3 1 1 1
12 2 1 1
10 1 3 1
1 1 3 3
8 3 3 1
12 0 1 3
12 2 0 2
12 1 2 0
8 0 2 3
10 3 1 3
1 3 1 1
8 1 0 2
12 3 3 1
12 3 0 3
12 2 1 0
11 1 0 0
10 0 2 0
10 0 3 0
1 2 0 2
8 2 1 0
12 0 0 3
12 3 2 2
12 1 3 1
5 3 2 1
10 1 3 1
1 1 0 0
8 0 0 3
12 0 1 1
12 1 2 0
10 0 2 2
10 2 1 2
1 2 3 3
10 3 0 0
3 0 2 0
12 3 1 2
10 0 0 1
3 1 2 1
0 1 2 2
10 2 1 2
1 3 2 3
8 3 0 1
12 3 3 2
12 2 0 3
0 0 2 3
10 3 3 3
1 1 3 1
8 1 2 2
12 1 2 0
12 0 3 3
12 3 0 1
3 0 1 3
10 3 3 3
1 3 2 2
8 2 2 1
12 2 1 3
12 0 2 2
12 2 3 0
2 0 3 0
10 0 1 0
1 0 1 1
8 1 0 2
12 0 0 1
12 2 0 0
15 0 3 1
10 1 2 1
1 1 2 2
8 2 3 1
12 3 1 2
2 0 3 2
10 2 2 2
1 2 1 1
12 3 3 0
12 2 0 2
6 2 0 3
10 3 2 3
1 1 3 1
8 1 0 0
12 2 3 3
12 1 1 1
12 1 2 2
7 1 3 3
10 3 2 3
1 0 3 0
8 0 0 3
10 1 0 2
3 2 0 2
12 1 0 0
10 1 2 1
10 1 3 1
10 1 1 1
1 3 1 3
8 3 0 2
12 2 1 3
12 2 2 0
12 1 0 1
2 0 3 0
10 0 2 0
1 0 2 2
12 2 3 0
10 3 0 3
3 3 1 3
12 0 0 1
13 0 3 3
10 3 1 3
10 3 2 3
1 2 3 2
12 1 1 3
10 1 0 1
3 1 1 1
7 1 0 1
10 1 3 1
1 2 1 2
8 2 2 0
12 0 3 3
10 0 0 2
3 2 3 2
12 0 2 1
5 3 2 3
10 3 1 3
1 0 3 0
8 0 2 1
12 1 1 0
12 2 0 3
1 0 0 0
10 0 1 0
1 1 0 1
8 1 1 0
12 0 3 2
12 1 2 1
12 0 3 3
12 3 1 3
10 3 3 3
1 3 0 0
8 0 1 3
12 1 1 0
10 0 2 1
10 1 3 1
1 3 1 3
8 3 1 1
12 3 2 0
10 2 0 2
3 2 3 2
12 0 2 3
5 3 2 2
10 2 2 2
1 2 1 1
8 1 2 3
12 2 0 0
12 3 3 2
12 3 0 1
11 1 0 1
10 1 3 1
10 1 2 1
1 1 3 3
8 3 3 1
12 1 1 0
10 2 0 2
3 2 2 2
12 1 0 3
8 0 2 2
10 2 2 2
1 2 1 1
12 1 3 2
1 3 3 0
10 0 2 0
10 0 1 0
1 0 1 1
12 3 3 2
12 0 1 3
12 1 2 0
10 0 2 2
10 2 1 2
1 1 2 1
8 1 3 3
12 3 3 0
10 0 0 2
3 2 0 2
12 1 3 1
4 2 0 0
10 0 1 0
1 0 3 3
8 3 3 1
12 1 1 3
12 2 2 2
12 3 1 0
1 3 3 2
10 2 2 2
1 2 1 1
10 1 0 3
3 3 0 3
10 2 0 0
3 0 1 0
12 2 3 2
9 3 2 0
10 0 1 0
1 0 1 1
12 2 1 3
12 1 3 2
12 2 1 0
2 0 3 2
10 2 1 2
1 1 2 1
10 0 0 0
3 0 3 0
12 3 2 2
10 0 0 3
3 3 0 3
5 3 2 3
10 3 3 3
1 3 1 1
8 1 0 3
12 0 1 2
12 3 2 1
4 2 0 0
10 0 1 0
1 0 3 3
12 2 3 2
12 1 3 0
12 0 0 1
3 0 1 0
10 0 2 0
10 0 3 0
1 0 3 3
8 3 1 1
10 3 0 3
3 3 2 3
12 1 3 0
12 0 1 2
5 2 3 3
10 3 1 3
10 3 1 3
1 3 1 1
8 1 1 3
12 2 3 1
10 3 0 0
3 0 2 0
10 0 0 2
3 2 3 2
0 0 2 1
10 1 3 1
10 1 2 1
1 3 1 3
12 3 0 0
12 2 2 2
12 2 1 1
0 2 0 0
10 0 2 0
1 3 0 3
8 3 3 0
12 0 2 3
12 3 1 3
10 3 3 3
1 3 0 0
12 3 1 1
10 2 0 3
3 3 0 3
10 2 0 2
3 2 1 2
14 1 2 2
10 2 2 2
10 2 1 2
1 2 0 0
10 2 0 3
3 3 3 3
12 1 3 2
14 1 2 1
10 1 2 1
1 0 1 0
12 3 3 1
12 2 1 2
12 0 2 3
6 2 1 2
10 2 3 2
10 2 1 2
1 0 2 0
8 0 1 3
12 1 3 0
12 3 0 2
12 0 0 1
3 0 1 1
10 1 1 1
1 3 1 3
8 3 3 1
10 2 0 2
3 2 2 2
10 2 0 3
3 3 1 3
12 2 1 0
13 0 3 3
10 3 1 3
1 1 3 1
12 2 1 3
2 0 3 2
10 2 3 2
1 2 1 1
8 1 0 2
12 3 1 1
10 1 0 3
3 3 1 3
3 3 1 1
10 1 2 1
1 2 1 2
8 2 1 0
12 0 2 3
12 0 2 1
12 3 1 2
12 2 3 2
10 2 1 2
1 0 2 0
8 0 1 2
12 3 2 3
12 0 2 0
10 3 0 1
3 1 2 1
11 3 1 1
10 1 2 1
10 1 3 1
1 2 1 2
8 2 0 3
12 0 1 2
10 2 0 0
3 0 1 0
10 1 0 1
3 1 2 1
1 0 0 2
10 2 2 2
1 2 3 3
12 0 2 2
1 0 0 1
10 1 2 1
1 1 3 3
12 3 1 0
10 3 0 2
3 2 2 2
12 1 1 1
6 2 0 1
10 1 1 1
1 1 3 3
8 3 2 1
12 0 1 2
12 1 3 3
12 2 2 0
10 3 2 2
10 2 3 2
1 2 1 1
8 1 0 0
12 2 1 3
12 0 3 1
12 2 3 2
15 2 3 2
10 2 3 2
1 0 2 0
8 0 3 2
10 0 0 0
3 0 1 0
12 1 3 3
3 0 1 1
10 1 1 1
1 2 1 2
8 2 1 1
12 2 0 2
12 2 1 0
13 0 3 0
10 0 2 0
1 1 0 1
8 1 0 0
12 2 0 3
12 3 1 2
12 3 3 1
14 1 2 3
10 3 3 3
10 3 3 3
1 0 3 0
8 0 3 2
12 1 1 0
12 2 3 3
12 1 0 1
7 1 3 1
10 1 3 1
1 2 1 2
8 2 2 3
10 0 0 0
3 0 2 0
12 2 1 2
12 3 0 1
6 2 1 0
10 0 3 0
1 0 3 3
8 3 0 1
10 1 0 3
3 3 2 3
10 3 0 0
3 0 2 0
2 0 3 3
10 3 2 3
1 1 3 1
8 1 2 0
12 1 3 1
12 1 1 3
10 0 0 2
3 2 3 2
10 1 2 3
10 3 1 3
1 0 3 0
8 0 0 1
12 0 0 3
10 0 0 2
3 2 2 2
12 0 1 0
9 3 2 0
10 0 1 0
1 1 0 1
8 1 0 2
12 2 1 0
12 1 0 1
12 1 2 3
13 0 3 3
10 3 3 3
1 2 3 2
8 2 1 0
12 0 0 1
12 0 2 2
12 1 3 3
3 3 1 1
10 1 3 1
1 0 1 0
12 3 1 1
12 2 3 3
5 2 3 3
10 3 2 3
1 0 3 0
8 0 1 2
12 2 0 1
12 2 2 0
10 3 0 3
3 3 2 3
2 0 3 0
10 0 1 0
10 0 3 0
1 2 0 2
8 2 2 0
12 2 2 2
12 3 0 1
6 2 1 1
10 1 2 1
1 0 1 0
8 0 1 3
12 2 1 1
10 3 0 0
3 0 1 0
8 0 2 1
10 1 2 1
1 3 1 3
12 3 0 1
12 0 1 0
6 2 1 1
10 1 1 1
1 1 3 3
12 0 2 1
12 3 3 0
12 3 0 2
12 1 2 1
10 1 1 1
10 1 1 1
1 3 1 3
12 1 0 0
12 3 1 1
12 0 2 2
3 0 1 2
10 2 1 2
1 3 2 3
12 3 3 2
12 2 0 0
12 1 0 1
10 1 2 2
10 2 3 2
1 3 2 3
8 3 0 2
10 0 0 3
3 3 1 3
1 3 3 1
10 1 2 1
1 2 1 2
8 2 1 3
12 0 2 2
12 3 0 0
12 0 1 1
4 2 0 2
10 2 2 2
1 2 3 3
8 3 0 0
10 2 0 1
3 1 2 1
12 0 0 3
12 0 1 2
15 1 3 2
10 2 3 2
10 2 1 2
1 2 0 0
8 0 0 2
12 3 0 1
12 3 3 3
12 1 3 0
3 0 1 1
10 1 1 1
1 1 2 2
8 2 2 0
10 1 0 3
3 3 2 3
12 0 2 2
12 0 1 1
5 2 3 2
10 2 3 2
1 0 2 0
12 0 1 2
5 2 3 1
10 1 2 1
1 1 0 0
8 0 3 1
12 1 3 0
7 0 3 2
10 2 1 2
1 1 2 1
8 1 3 2
10 2 0 1
3 1 0 1
12 1 0 3
3 3 1 0
10 0 1 0
10 0 2 0
1 0 2 2
8 2 2 0
10 1 0 3
3 3 3 3
10 3 0 1
3 1 1 1
12 1 2 2
14 3 2 2
10 2 3 2
1 0 2 0
8 0 1 1
12 2 0 3
12 0 1 2
12 2 1 0
5 2 3 0
10 0 2 0
1 0 1 1
12 3 2 0
12 2 0 2
10 1 0 3
3 3 0 3
6 2 0 2
10 2 2 2
10 2 3 2
1 1 2 1
12 2 2 3
12 2 0 0
12 3 3 2
4 0 2 3
10 3 1 3
1 3 1 1
8 1 3 3
12 3 2 1
0 0 2 0
10 0 2 0
1 0 3 3
8 3 1 0
12 1 3 3
10 3 0 1
3 1 1 1
12 0 2 2
10 1 2 1
10 1 3 1
1 1 0 0
8 0 1 1
12 2 2 3
12 1 0 0
12 3 1 2
7 0 3 0
10 0 3 0
1 1 0 1
8 1 2 2
12 1 0 1
10 2 0 0
3 0 2 0
12 1 0 3
7 3 0 0
10 0 2 0
1 2 0 2
12 2 3 3
12 2 2 0
2 0 3 1
10 1 2 1
1 2 1 2
8 2 3 1
12 0 1 0
12 3 1 2
12 1 0 3
10 3 2 0
10 0 2 0
1 0 1 1
8 1 1 2
12 2 3 0
12 0 3 1
13 0 3 0
10 0 3 0
10 0 2 0
1 2 0 2
12 2 2 0
12 3 3 1
7 3 0 1
10 1 3 1
1 1 2 2
8 2 2 0
12 3 1 2
10 3 0 1
3 1 2 1
0 1 2 3
10 3 2 3
10 3 3 3
1 0 3 0
12 3 2 1
12 0 3 3
5 3 2 1
10 1 3 1
10 1 1 1
1 1 0 0
8 0 0 3
12 0 3 2
12 2 2 0
12 3 0 1
11 1 0 0
10 0 2 0
1 3 0 3
8 3 0 1
12 0 3 3
10 0 0 0
3 0 3 0
10 2 0 2
3 2 2 2
9 3 2 2
10 2 3 2
1 1 2 1
12 2 1 2
15 2 3 2
10 2 2 2
10 2 1 2
1 2 1 1
12 2 0 3
12 0 3 2
4 2 0 2
10 2 3 2
1 2 1 1
8 1 3 3
10 1 0 2
3 2 3 2
12 2 1 1
12 0 2 0
0 1 2 1
10 1 3 1
1 1 3 3
8 3 1 1
10 0 0 2
3 2 0 2
12 3 2 3
10 3 0 0
3 0 1 0
10 0 2 0
10 0 3 0
10 0 2 0
1 0 1 1
8 1 2 2
10 1 0 1
3 1 2 1
10 1 0 0
3 0 2 0
12 1 3 1
10 1 2 1
1 2 1 2
12 1 3 3
10 3 0 1
3 1 3 1
6 0 1 3
10 3 3 3
10 3 2 3
1 3 2 2
12 2 2 3
12 1 3 0
7 0 3 1
10 1 3 1
1 2 1 2
10 1 0 0
3 0 0 0
10 3 0 3
3 3 1 3
12 1 0 1
1 3 3 0
10 0 1 0
1 2 0 2
8 2 3 1
12 2 3 3
12 1 3 0
12 1 1 2
7 0 3 3
10 3 2 3
1 3 1 1
8 1 3 2
12 2 0 0
12 2 3 3
12 3 2 1
2 0 3 1
10 1 3 1
1 2 1 2
8 2 3 1
12 3 3 3
12 3 2 0
12 2 3 2
0 2 0 2
10 2 1 2
10 2 1 2
1 2 1 1
8 1 1 0
""".components(separatedBy: "\n\n\n\n")

extension String {
    var numbers: [Int] {
        split(whereSeparator: { "-0123456789".contains($0) == false })
            .map { Int($0)! }
    }
}

struct Sample: CustomStringConvertible {
    let before: [Int]
    let after: [Int]
    let instruction: [Int]
    let line: String

    init(_ line: String) {
        let com = line.components(separatedBy: .newlines)
        self.line = line
        self.before = com[0].numbers
        self.instruction = com[1].numbers
        self.after = com[2].numbers
    }

    var description: String {
        "\(before) \t \(instruction) \t \(after)"
    }

    func allPossibleInstructions() -> [[Int]] {
        var result: [[Int]] = []

        (0...15).forEach { op in
            var ins = Array(instruction.dropFirst())
            ins.insert(op, at: 0)
            result.append(ins)
        }
        return result
    }
}


let samples = input[0].components(separatedBy: "\n\n").map { Sample.init($0) }
let testProgram = input[1].components(separatedBy: "\n").map { $0.components(separatedBy: " ").map { Int($0)! } }

struct OpCodeComputer {
    var register: [Int]
    var instruction: [Int]

    init(_ ins: [Int], _ reg: [Int]) {
        self.instruction = ins
        self.register = reg
    }

    init() {
        self.register = [0,0,0,0]
        self.instruction = []
    }

    mutating func run(_ ins: [Int]) {
        let code = ins[0]
        let a = ins[1]
        let b = ins[2]
        let c = ins[3]

        performOperation(code, a, b, c)
    }

    mutating func performOperation(_ code: Int, _ a: Int, _ b: Int, _ c: Int) {
        switch code {
        case 0: register[c] = register[a] + register[b]
        case 1: register[c] = register[a] + b
        case 2: register[c] = register[a] * register[b]
        case 3: register[c] = register[a] * b
        case 4: register[c] = register[a] & register[b]
        case 5: register[c] = register[a] & b
        case 6: register[c] = register[a] | register[b]
        case 7: register[c] = register[a] | b
        case 8: register[c] = register[a]
        case 9: register[c] = a
        case 10: register[c] = a > register[b] ? 1 : 0
        case 11: register[c] = register[a] > b ? 1 : 0
        case 12: register[c] = register[a] > register[b] ? 1 : 0
        case 13: register[c] = a == register[b] ? 1 : 0
        case 14: register[c] = register[a] == b ? 1 : 0
        case 15: register[c] = register[a] == register[b] ? 1 : 0
        default:
            fatalError("not regnised opcode")
        }
    }

    mutating func run() {
        let code = instruction[0]
        let a = instruction[1]
        let b = instruction[2]
        let c = instruction[3]

        performOperation(code, a, b, c)
    }
}

func partOne() -> Int {
    var result = 0

    for sample in samples {
        var count = 0
        for ins in sample.allPossibleInstructions() {
            var computer = OpCodeComputer.init(ins, sample.before)
            computer.run()
            if computer.register == sample.after {
                count += 1
            }
        }
        if count >= 3 {
            result += 1
        }
    }

    return result
}

func partTwo() -> Int {
    var mapping: [Int: Set<Int>] = [:]

    for sample in samples {
        for ins in sample.allPossibleInstructions() {
            var computer = OpCodeComputer.init(ins, sample.before)
            computer.run()
            if computer.register == sample.after {
                var prev = mapping[sample.instruction[0], default: []]
                prev.insert(ins[0])
                mapping[sample.instruction[0]] = prev
            }
        }
    }

    var real: [Int: Int] = [:]
    func findMapping() {
        for m in mapping {
            let v = m.value.filter { !real.values.contains($0) }
            if v.count == 1 {
                real[m.key] = v.first!
            }
        }
    }

    while real.keys.count != 16 {
        findMapping()
    }

    var computer = OpCodeComputer.init()

    for test in testProgram {
        let op = test.first!
        var ins = Array(test.dropFirst())
        ins.insert(real[op]!, at: 0)
        computer.run(ins)
    }

    return computer.register[0]
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
