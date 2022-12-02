import Cocoa

let input = """
koq inc 675 if xrh >= -6
it inc -402 if s < -1
g inc 283 if oj != -3
it inc 355 if y <= 5
do dec 553 if g != 288
ix dec 162 if hwz != 4
gsz dec -738 if koq <= 682
s dec 941 if mh == 8
ix dec -783 if yor < 10
rzc inc -583 if bp < 9
ix dec -186 if koq <= 680
ix dec 0 if ehw > 2
mh inc -830 if xrh >= -9
sql inc 242 if oj <= 1
bp dec 243 if a < 5
hwz dec -856 if ykc != 0
zx inc 832 if rzc > -588
oj dec -213 if sql != 242
gsz dec -910 if xrh != 3
mh dec -129 if a <= 5
yor inc -772 if a == 0
y dec 248 if cj > -9
zx inc -569 if np >= 0
koq dec 411 if a != 9
mh inc -525 if yor <= -763
it dec 24 if ubu < 7
ix inc -390 if do <= -554
y inc 949 if e >= -9
a inc 963 if mh != -1228
rzc dec -906 if e != -2
i dec 545 if ubu <= 6
e dec 815 if ix != 815
rzc inc -401 if koq != 274
a dec -171 if e < -819
gsz inc 364 if s != 3
oj inc -975 if mh > -1227
hwz inc 135 if y != 694
hwz inc -282 if ehw < 7
hwz dec -404 if g >= 282
gsz inc -353 if y != 696
ehw inc -34 if ubu != -3
xrh inc 932 if e >= -812
g dec 531 if g > 287
ykc dec 475 if ix < 810
sql dec -957 if y >= 696
rzc inc 233 if cj != 0
hwz inc -877 if ehw == -34
s inc -65 if do < -552
cj inc 569 if s != -65
rzc dec -63 if do != -545
ykc inc 497 if oj >= -982
np dec -921 if it <= 325
hwz inc 927 if rzc == -15
cj inc -357 if a <= 965
koq inc 98 if ix >= 799
koq dec -343 if s != -68
np inc 689 if ehw == -34
g dec 515 if ix >= 804
do dec -763 if ubu >= -9
rzc inc -737 if ix > 805
xrh dec 606 if np < 693
xrh dec -469 if g > -237
g inc -755 if zx < 261
y dec 857 if s <= -63
a inc -808 if gsz < 1661
it dec 167 if e != -815
np dec 934 if hwz < 303
xrh inc -407 if rzc >= -757
e dec 308 if it >= 330
gsz inc 988 if oj == -975
e inc -784 if cj > -366
ix inc 794 if koq < 712
s dec -285 if i != -539
bp inc -386 if sql < 1206
mh inc -381 if yor < -773
xrh dec -172 if gsz >= 2643
cj inc -377 if ix != 1594
rzc dec -572 if oj <= -969
koq inc 869 if a < 152
ubu inc 326 if ix >= 1600
sql dec 66 if do >= 204
sql inc 798 if koq < 709
do inc 164 if do == 210
a dec 632 if mh < -1228
hwz dec 634 if bp > -639
np inc -453 if yor <= -764
do dec -212 if ix != 1592
mh inc -61 if s < 213
bp inc 670 if gsz == 2647
s dec -452 if y == -160
it dec -175 if hwz == -327
xrh dec 980 if a != 155
xrh inc 359 if i <= -544
bp inc 548 if ehw <= -31
rzc inc 335 if g < -228
oj inc 795 if cj <= -735
koq inc -909 if cj > -737
rzc dec -591 if a < 158
koq inc 289 if e >= -1900
ykc dec 870 if sql < 1940
sql inc 163 if a <= 151
e inc -18 if y > -163
e inc 832 if a >= 154
cj dec -478 if ix <= 1608
gsz inc 447 if y < -153
sql dec 253 if e >= -1094
y inc -60 if gsz < 3098
sql dec 828 if np == 236
ykc inc 715 if oj > -980
zx dec 352 if ehw > -25
mh dec -743 if ix >= 1599
koq inc 795 if ehw == -34
ubu inc -339 if e != -1085
bp dec 982 if it > 509
hwz inc -296 if oj < -971
ubu inc 895 if i == -545
do inc -567 if gsz < 3091
ix inc -195 if ix != 1608
zx dec 512 if a >= 155
it inc -918 if bp >= 588
cj dec -779 if bp == 589
ehw inc -609 if mh > -492
do inc -579 if zx < -242
np inc -462 if a >= 148
a dec 424 if mh > -483
rzc dec -234 if np < -222
a dec -217 if xrh <= -9
ubu dec -736 if i > -537
it inc -170 if g >= -241
i inc -190 if a <= 369
rzc inc -327 if ykc > -141
xrh inc -293 if ykc <= -129
g dec 281 if yor < -778
e dec -620 if ykc != -134
ix inc -539 if yor > -778
koq inc 526 if mh < -482
y inc -460 if s >= 227
xrh dec -708 if ehw < -639
it inc 694 if do <= 16
y dec 986 if s < 221
s inc -134 if koq == 1118
oj dec -544 if a > 371
cj inc 345 if bp > 582
it dec -188 if yor >= -774
ykc inc 498 if a == 372
rzc dec -543 if do != -2
np dec -179 if gsz >= 3085
ix inc -434 if sql <= 856
zx dec -112 if ubu > 876
koq inc 350 if g == -232
g inc -676 if ehw >= -637
oj dec -697 if koq > 1471
gsz inc -630 if rzc != 1200
oj dec -816 if g == -232
do dec 605 if yor <= -763
ix dec 653 if cj == 863
it inc 297 if zx <= -134
zx inc 314 if e < -482
s inc 634 if sql > 848
hwz inc 729 if bp > 588
koq inc 749 if s != 859
a inc 1 if bp < 590
np inc 605 if yor > -781
do dec 844 if ix == 433
bp dec -817 if it < 607
e dec -201 if hwz <= 111
a inc -83 if ubu > 879
s inc -854 if koq != 2217
y dec 844 if a != 294
ehw inc -155 if oj <= 386
gsz dec 844 if g <= -230
np dec -393 if bp < 1410
bp dec -319 if yor > -775
rzc dec -738 if mh <= -483
ix inc 541 if bp != 1727
s inc -717 if zx != -129
xrh dec -78 if rzc <= 1936
do inc -859 if bp > 1716
bp inc 852 if sql >= 845
y dec -268 if it == 597
ehw inc -669 if do < -2296
g inc -855 if ix == 974
bp inc 356 if a > 296
mh dec 79 if np != 942
ehw dec 160 if g > -1094
sql inc -902 if i < -544
np dec -117 if yor == -772
zx dec -657 if ykc >= 369
hwz inc 211 if koq < 2219
xrh dec -67 if hwz <= 315
ehw inc -474 if koq != 2208
ubu dec 717 if np != 1059
mh inc 231 if yor != -771
bp dec 515 if cj != 868
do inc -634 if s != -717
xrh inc 880 if ubu <= 158
hwz inc -882 if hwz != 326
ubu inc 689 if s != -713
ix inc 639 if cj < 867
mh inc 369 if mh < -335
koq dec 71 if ix > 969
xrh inc 69 if koq < 2150
oj dec -908 if koq < 2149
xrh inc -662 if oj != 1296
bp dec -511 if ubu != 846
a inc -662 if yor < -771
xrh dec 643 if gsz >= 1611
koq dec -479 if s > -721
hwz dec 86 if koq < 2632
ubu inc 629 if y > -1787
cj inc 61 if bp <= 3084
do dec 594 if it < 590
cj dec -717 if ykc > 355
a inc 698 if ykc <= 366
gsz inc -265 if ubu > 1491
ubu inc -958 if ykc < 366
i inc 714 if gsz <= 1623
mh inc -976 if y < -1772
g dec 963 if bp < 3085
rzc inc 171 if it < 607
it dec -986 if ykc != 367
e inc 100 if do < -2299
rzc dec -185 if koq > 2619
zx inc -363 if ykc > 355
sql dec 163 if hwz >= -651
koq inc -324 if np >= 1061
i inc 139 if hwz > -660
ehw inc 892 if g < -1079
oj inc -788 if np != 1070
zx dec 563 if hwz >= -653
it dec 731 if y != -1787
do inc 251 if a <= 334
bp dec -933 if gsz < 1622
s inc -218 if do < -2043
koq inc -183 if rzc == 2281
cj dec 23 if ix < 975
e inc 704 if ehw >= -1216
ix inc 573 if oj == 505
rzc dec 582 if y <= -1771
it dec -985 if koq <= 2301
ehw inc 398 if y >= -1778
mh inc -453 if yor < -768
bp dec -763 if gsz != 1624
gsz inc 386 if bp > 4792
oj dec -721 if bp < 4785
it inc 799 if it >= 1843
ix dec -881 if a == 326
hwz inc -57 if gsz >= 1613
do dec -818 if rzc > 1702
s dec -302 if ykc == 370
ehw dec 502 if ix > 2435
it dec 648 if g != -1088
ehw dec -449 if mh > -1769
s inc -802 if do != -1226
np inc -928 if mh <= -1754
bp inc 778 if yor < -777
sql inc -178 if bp == 4784
bp dec 895 if cj <= 1571
oj inc -90 if cj <= 1563
mh dec -23 if mh < -1757
np inc -544 if ehw >= -367
zx dec -871 if rzc > 1702
mh inc 119 if ykc > 355
yor inc 924 if i <= 313
bp inc 3 if hwz <= -700
ykc dec 332 if ehw <= -361
rzc inc 402 if np == -404
y dec -605 if bp >= 3887
gsz dec -408 if gsz >= 1611
s dec -247 if yor == 152
do dec 426 if a >= 322
zx dec -708 if e <= 537
i inc -522 if do == -1658
yor inc -492 if ykc != 27
gsz dec 1 if do == -1658
s inc 113 if xrh == -756
np dec -264 if gsz >= 2018
s inc -211 if g < -1084
rzc dec 549 if np > -136
sql inc -188 if do >= -1658
e inc -55 if sql < -577
sql inc -642 if hwz >= -710
cj inc 375 if i != -214
zx inc 308 if ehw != -357
koq dec -823 if it <= 1196
ix inc 602 if mh == -1618
yor inc -221 if koq > 3120
xrh inc -171 if do > -1664
gsz dec -454 if zx == 824
e dec 998 if do >= -1660
oj inc -781 if oj >= 1131
it dec -63 if hwz >= -709
gsz dec -707 if oj > 348
zx inc -287 if e < -515
do dec -489 if np > -145
oj dec -203 if gsz < 3190
i inc -433 if do != -1176
s inc -433 if a != 320
gsz dec 569 if i <= -639
koq inc 978 if rzc == 2110
koq inc -673 if bp == 3892
zx inc -522 if gsz == 2619
hwz inc -199 if rzc >= 2103
g dec 459 if cj <= 1563
y inc 90 if np == -140
sql dec -764 if gsz == 2619
bp dec 287 if ix <= 3026
cj dec 269 if oj < 566
bp dec -334 if do < -1159
ehw inc -245 if ubu >= 524
bp dec -137 if g > -1547
ix inc -517 if sql >= -464
yor inc 814 if do >= -1172
oj dec -676 if gsz >= 2617
np inc 892 if ykc != 23
np dec -53 if i <= -656
it dec 686 if gsz >= 2613
bp dec -98 if i != -647
hwz dec -753 if mh > -1618
koq inc 292 if sql <= -457
ykc inc -426 if s > -2020
ix inc 698 if it != 556
oj inc 734 if do < -1166
mh inc 721 if e == -521
e inc -910 if cj != 1298
bp inc -803 if rzc != 2112
gsz inc 262 if mh >= -899
ehw inc 906 if it > 558
zx inc 821 if xrh > -935
g inc -501 if xrh <= -920
i inc -442 if i != -655
do dec -408 if hwz < -897
hwz dec -326 if e == -1431
it inc 975 if ubu > 517
ix inc -477 if ykc <= 41
a dec 329 if it < 1550
zx inc -419 if mh != -892
a inc 238 if ubu == 533
sql dec 226 if zx < 420
e dec -673 if rzc < 2116
zx dec 284 if y > -1084
y dec 53 if ehw != 299
gsz dec 980 if mh != -895
do dec -207 if s != -2021
yor dec -758 if rzc == 2110
ehw inc 682 if xrh >= -934
y inc 752 if koq > 3710
gsz dec 20 if do == -761
cj dec -579 if ix >= 2742
cj inc 346 if yor < 1019
rzc dec -836 if y <= -333
xrh inc 806 if do > -768
it inc 736 if ykc > 29
e inc 377 if yor != 1013
ix dec 46 if ykc > 29
s inc 774 if s > -2025
ykc dec 203 if yor > 1003
a dec 855 if ehw >= 974
a dec 568 if ykc > -161
mh inc 556 if i == -1089
ykc dec 689 if ubu > 515
ehw dec -852 if a <= -856
gsz dec 440 if zx >= 131
yor dec 470 if a == -858
g dec -935 if do != -761
oj dec 146 if i < -1079
bp inc -152 if rzc != 2117
ix dec 164 if xrh <= -115
do dec -27 if hwz == -581
yor inc 606 if i < -1088
ehw dec -585 if a > -861
e dec -326 if it >= 2273
mh dec 471 if s < -1246
yor inc 535 if cj < 1632
y inc -665 if np >= 747
s inc -117 if cj == 1639
y inc -815 if np > 750
s inc 809 if ubu != 530
bp dec -780 if bp >= 3404
s inc 560 if i >= -1080
xrh inc -289 if e != -58
e dec -165 if sql != -683
cj inc 655 if i != -1091
e inc -503 if mh != -814
y dec 304 if e <= -392
xrh inc 287 if a == -854
i inc 719 if hwz == -581
do dec 914 if ykc <= -851
koq inc -989 if e <= -386
bp dec 847 if cj < 2286
s inc 463 if mh == -812
zx dec 683 if oj > 1820
sql dec 252 if ykc >= -866
e dec -373 if ykc >= -863
cj inc -991 if s < -88
ix dec 420 if g >= -2049
i inc -116 if y != -2115
oj dec 55 if hwz != -571
ubu inc -981 if s <= -84
koq dec -411 if g > -2056
mh inc 65 if cj <= 1295
hwz inc -16 if y != -2117
s inc -459 if e >= -20
ykc inc 388 if ix != 2104
yor inc -346 if hwz > -599
ubu inc -316 if ubu == -466
it dec 456 if oj > 1773
np inc -973 if mh < -810
yor dec -194 if oj < 1771
oj inc -943 if it > 2270
ehw inc -74 if y != -2118
xrh dec 550 if mh < -804
hwz dec -620 if rzc > 2101
mh dec -486 if ix <= 2108
yor dec 229 if it <= 2281
ehw dec -426 if yor != 772
do dec -328 if g >= -2052
ix inc 195 if cj == 1303
it dec 315 if zx <= -543
hwz inc -131 if bp <= 4179
koq dec 923 if ykc <= -856
yor dec -846 if bp > 4182
gsz dec 554 if zx == -550
g dec 150 if ehw != 2765
yor dec -756 if ubu > -457
it dec -857 if sql > -943
s inc 228 if i >= -378
g dec -894 if yor == 2376
yor inc -883 if gsz <= 895
i dec 968 if s < -316
a dec -638 if koq > 2224
mh inc -680 if a != -858
ykc inc 233 if it >= 2812
yor inc -666 if np < -221
gsz inc -199 if gsz == 890
y inc 795 if np > -231
gsz inc -250 if cj <= 1298
np inc -470 if rzc != 2110
i dec -913 if ykc != -618
g inc -894 if zx == -542
i inc -736 if sql <= -932
hwz inc 700 if yor <= 1487
yor inc 335 if ehw < 2778
ehw inc 365 if g == -2197
do inc 863 if s >= -321
ubu dec -372 if s != -325
mh inc -598 if ykc <= -617
mh inc -328 if ykc <= -625
hwz inc -398 if oj <= 829
it inc -15 if hwz == 325
sql dec 812 if sql <= -933
ykc dec 138 if a > -863
cj inc 726 if rzc == 2118
rzc inc 983 if oj > 820
g dec -534 if ehw >= 3131
gsz inc -503 if yor < 1811
ehw inc 396 if hwz != 331
it dec 450 if a > -862
xrh dec -253 if np != -226
i inc 949 if g == -1663
a dec 231 if it == 2354
e dec -206 if s == -323
zx dec -251 if ix > 2290
cj inc -777 if rzc != 3098
bp dec 304 if sql >= -1758
ehw inc -106 if g >= -1667
cj inc -601 if rzc > 3090
gsz dec 108 if s == -323
koq dec -506 if do != -1330
y inc -438 if koq > 2734
yor dec -834 if ehw >= 3416
koq dec -373 if s == -323
zx dec -813 if sql >= -1755
g dec -78 if bp <= 3885
rzc inc 163 if oj == 824
gsz dec -792 if oj >= 821
cj dec 345 if xrh <= -705
gsz dec 270 if zx > 507
rzc inc 438 if sql != -1754
oj dec -746 if np >= -221
do dec -833 if rzc < 3704
yor dec -409 if sql <= -1744
i dec 917 if hwz != 332
ykc inc 169 if s != -321
do inc 380 if ykc > -604
a dec -860 if mh != -1260
ix dec -874 if xrh >= -710
bp dec -702 if sql <= -1742
sql inc 352 if yor < 3068
oj dec -879 if ehw <= 3433
s inc 165 if do > -114
it dec -319 if i == -1129
ix dec 664 if g != -1579
ubu inc -982 if koq >= 3090
i dec -98 if bp <= 4587
mh inc 998 if xrh <= -698
yor inc -787 if np >= -217
ehw inc 515 if i != -1029
mh inc -446 if hwz == 325
a inc -676 if sql != -1388
e inc 305 if np != -213
oj dec 810 if e < 494
a inc -206 if g != -1585
yor dec -462 if g < -1581
bp inc 11 if gsz != 1298
ubu inc -133 if cj > -426
s dec -385 if ykc >= -603
do dec 832 if y < -1318
ubu inc 69 if a >= -909
it inc -785 if yor <= 3526
a inc 195 if yor >= 3516
yor dec 546 if i > -1035
e inc 303 if hwz >= 322
sql dec -910 if yor != 2970
sql dec -253 if do != -939
i dec 14 if gsz <= 1295
i dec -944 if ix == 2507
rzc dec -699 if oj == 1638
ubu dec 116 if ehw != 3937
e inc 731 if zx != 520
e inc -701 if ubu != -1247
ix inc -219 if s != 232
zx dec 590 if it != 1888
bp dec 761 if i < -1034
yor dec -244 if hwz == 325
e inc -308 if i >= -1032
np dec -857 if hwz >= 324
rzc inc 126 if y > -1321
zx inc 550 if bp >= 4605
yor dec 536 if g < -1581
g inc -135 if np >= 629
it inc -50 if gsz == 1301
y inc -562 if a == -710
oj dec -999 if xrh != -708
cj dec 814 if y > -1887
ubu dec -649 if i >= -1027
sql inc -506 if rzc == 3820
hwz dec 460 if ubu < -1250
yor inc 911 if ykc < -586
a inc -385 if ehw < 3932
ix inc -113 if xrh == -707
do dec 2 if ubu <= -1243
oj inc 917 if sql <= -993
mh dec 829 if a != -709
ykc dec 767 if a >= -714
ykc dec 470 if it != 1832
it dec -663 if s >= 223
y inc 616 if ix == 2177
ix dec 432 if do >= -950
i dec 633 if oj != 3563
hwz inc 878 if ykc != -1838
yor inc 897 if np <= 644
bp dec -887 if zx < 508
yor inc 434 if g >= -1726
y dec -693 if koq >= 3107
gsz dec 250 if rzc > 3816
it inc 457 if do != -937
cj dec 619 if bp > 4604
yor dec -951 if e > 510
a inc 501 if ehw < 3943
ix dec 192 if rzc == 3822
mh inc 137 if xrh != -704
oj dec 16 if ykc <= -1829
g inc 793 if g != -1717
y inc 86 if ix != 1748
koq inc -204 if do >= -932
ehw dec -688 if hwz >= 1194
i inc -224 if ubu == -1246
i dec -711 if hwz < 1207
zx dec -928 if yor >= 5875
i dec 993 if i >= -1186
i inc 286 if it <= 2962
ix inc -256 if bp != 4595
y inc -238 if mh <= -1384
a dec 479 if g > -927
do dec -518 if mh < -1386
e dec 490 if yor != 5876
np inc -663 if ix > 1491
a dec -430 if np > 632
rzc inc -56 if ykc != -1832
do inc -88 if xrh > -713
ehw inc -982 if i > -1894
ehw dec -344 if hwz != 1203
hwz inc -934 if rzc <= 3815
np inc 117 if mh > -1396
hwz dec -179 if xrh == -707
bp dec 677 if ix < 1490
yor inc -310 if cj < -1229
hwz dec 298 if do >= -513
ykc inc 251 if yor != 5567
a dec -979 if yor >= 5570
hwz inc 729 if g != -927
e inc -318 if g >= -927
ykc inc -293 if ehw < 3647
oj inc -872 if e <= -283
oj inc 462 if ix != 1480
g dec -167 if do < -505
it inc -895 if mh < -1385
ykc dec -535 if xrh >= -707
rzc inc 235 if ehw > 3642
yor dec 837 if xrh == -707
it inc -12 if xrh >= -705
sql dec -649 if hwz == 1084
bp inc 522 if cj != -1236
ykc inc -796 if ykc < -1330
rzc inc 73 if np > 750
it dec 322 if hwz == 1084
np dec 583 if ehw == 3646
ix inc -812 if ehw > 3637
gsz dec 247 if gsz == 1057
rzc inc -58 if it != 1736
it inc -14 if gsz < 1054
rzc inc -509 if np == 170
cj dec 656 if cj < -1227
s dec 135 if a > 1198
e dec 651 if rzc < 3563
y inc 294 if xrh >= -712
e inc 830 if rzc == 3560
do dec -814 if ubu < -1253
mh dec 870 if i < -1877
ehw dec -541 if hwz >= 1082
ehw dec -902 if a != 1201
xrh dec -353 if cj >= -1895
s inc -103 if e >= -951
bp dec 907 if hwz >= 1086
yor inc -97 if gsz >= 1051
i dec 699 if i < -1875
a inc 378 if oj >= 3123
bp dec 982 if cj == -1890
a inc -989 if zx <= 1434
oj inc 240 if np == 163
it dec -758 if hwz == 1084
s inc -437 if a == 1578
ix inc 422 if ykc > -2136
do inc 274 if hwz <= 1086
s inc -122 if ubu > -1239
it inc -971 if yor > 4631
oj dec 194 if ehw >= 5083
ubu inc 955 if y != -1123
zx dec -8 if e >= -951
gsz inc 653 if it < 1523
s dec -28 if g != -760
g dec 303 if cj < -1884
bp inc -638 if koq == 3098
gsz inc 493 if ehw != 5099
zx inc -914 if e == -943
mh inc -184 if a == 1578
i dec 18 if np != 171
ehw inc 937 if it < 1522
sql dec -371 if e > -949
sql inc 8 if gsz <= 2206
ubu inc -606 if bp <= 2814
ubu inc -35 if zx <= 537
rzc dec 250 if i < -2591
e dec 648 if gsz >= 2197
g dec -18 if ehw != 6021
i inc -808 if hwz != 1093
ix dec -451 if s >= -448
cj inc -39 if rzc < 3318
bp inc -193 if e >= -1591
e dec -82 if s >= -455
bp dec 246 if ykc <= -2129
e dec -62 if s >= -453
do inc -404 if sql >= 43
hwz inc -534 if e == -1447
bp inc -993 if yor >= 4630
yor dec 682 if sql <= 44
g dec -612 if ehw < 6033
e dec -114 if it >= 1507
y inc 525 if do <= -232
i dec 129 if ykc <= -2126
y dec 490 if y >= -599
ehw inc -921 if cj != -1926
cj dec 951 if np <= 171
bp inc -996 if y != -1099
ubu inc 127 if zx <= 534
s inc 261 if cj >= -2879
a inc -318 if ykc != -2128
zx inc 665 if oj > 2940
koq dec 854 if g >= -442
it inc -697 if yor != 3949
it dec 711 if cj <= -2872
oj inc 731 if ykc < -2133
koq inc 360 if ubu <= -324
ykc inc 754 if sql >= 34
a inc -417 if koq <= 2609
np dec 112 if ykc > -1385
gsz dec 30 if i <= -3535
koq dec -483 if hwz >= 547
gsz inc 801 if ix < 1554
yor inc 795 if do > -242
mh inc 878 if ykc != -1388
mh dec -117 if np < 50
do dec -71 if it < 116
e inc 272 if y != -1081
rzc dec -616 if cj > -2884
yor inc 428 if yor >= 4740
gsz dec -870 if zx >= 529
ix inc -42 if i != -3546
sql inc 932 if rzc >= 3919
s inc 612 if ubu > -333
y inc -677 if y == -1089
mh dec -508 if s > 155
i inc -543 if ubu > -335
zx dec -356 if y >= -1760
cj dec 334 if oj <= 3664
zx inc 586 if i > -4091
oj inc 859 if xrh == -354
ix dec -229 if ix != 1518
zx dec -631 if ubu < -321
ehw dec -268 if ubu != -335
mh dec -197 if sql != 960
ix inc 915 if y < -1766
oj dec -802 if hwz == 550
xrh inc -725 if sql > 971
zx inc -386 if rzc <= 3935
do inc -132 if cj > -2885
sql dec 839 if it != 106
hwz dec 462 if cj <= -2887
ehw inc 250 if hwz < 560
it dec -493 if cj == -2880
g inc 354 if xrh != -354
mh inc 417 if cj < -2874
y dec -689 if yor >= 5187
oj inc 415 if koq == 3087
i inc 873 if rzc > 3926
ubu dec 793 if np == 58
s dec -247 if a < 851
oj dec 765 if oj <= 5746
i dec 804 if rzc > 3926
do inc 801 if e == -1061
xrh dec -377 if i <= -4009
a dec 490 if i > -4012
xrh dec 334 if a >= 843
do dec -155 if do < 503
zx dec -367 if mh <= -455
i dec 458 if zx <= 1369
oj inc -423 if mh <= -439
mh dec 827 if oj == 4547
bp dec -493 if i == -4470
koq inc -752 if mh == -442
bp dec 343 if ix < 1741
bp inc -509 if i >= -4469
y inc 36 if yor >= 5176
ubu dec 719 if i == -4470
hwz inc -787 if yor == 5177
it inc -223 if ix <= 1746
s dec -700 if ix == 1737
gsz inc -156 if yor <= 5184
rzc inc 425 if rzc != 3921
rzc inc 436 if it > 373
g inc -993 if cj != -2880
i dec 547 if cj > -2878
np inc -121 if y > -1731
np inc -568 if xrh != -316
mh inc 241 if g <= -436
ix dec -471 if a == 845
a inc -986 if hwz <= -245
ykc dec 458 if e < -1055
ix dec -385 if ehw <= 5616
ehw inc -533 if np >= -637
s dec 114 if e >= -1069
oj inc 772 if mh <= -455
a inc 671 if ubu < -1836
mh inc -949 if e != -1056
mh dec 788 if gsz < 3686
g inc 740 if sql > 973
cj dec -46 if rzc != 4781
a dec -96 if y > -1736
s dec -385 if do == 503
hwz inc 521 if ykc <= -1836
ubu inc -794 if xrh < -306
ubu dec 908 if rzc < 4784
a dec -676 if koq >= 3083
cj inc -881 if np > -637
ubu inc -421 if rzc == 4788
bp dec 678 if ykc < -1843
zx dec 56 if ykc <= -1833
mh inc -661 if cj < -3713
yor dec 766 if sql > 962
y inc 434 if it > 366
ykc dec 571 if ubu <= -3045
ehw inc -122 if it <= 384
g inc 607 if ykc >= -2414
sql dec 486 if gsz < 3678
e inc -339 if bp <= 543
i inc -69 if cj <= -3709
yor inc -629 if ykc < -2401
ykc inc 186 if i > -4546
ubu inc -518 if do <= 511
do inc -638 if ykc >= -2223
oj dec -12 if ix >= 1737
e inc 233 if e != -1057
do inc 643 if ykc <= -2218
zx dec 69 if koq >= 3087
np inc -128 if e >= -828
s dec 676 if ix != 1734
np inc -334 if do >= 1143
np dec 329 if do == 1146
mh dec 334 if xrh <= -311
s dec -530 if mh <= -3177
hwz dec 989 if s > 1232
a inc -939 if xrh <= -307
ix dec 572 if i != -4530
bp inc 429 if gsz != 3687
ix dec -420 if do != 1155
oj dec -147 if g >= 172
hwz inc -661 if gsz != 3691
gsz dec -793 if g <= 179
y inc 460 if hwz == -1366
np dec 523 if g > 167
rzc dec 509 if g <= 164
mh dec -971 if oj != 4711
i inc 330 if yor != 3788
rzc dec -779 if zx < 1246
s dec -439 if zx == 1242
ykc dec -36 if ubu >= -3580
ix dec 625 if ykc <= -2192
ubu inc 116 if s <= 1676
it dec -366 if i >= -4206
i dec 336 if e == -828
ykc inc -365 if mh >= -2213
np dec -341 if it < 382
xrh dec -326 if y <= -827
mh inc -254 if ix >= 1577
s inc 751 if gsz <= 4470
gsz inc -284 if e >= -837
do inc -829 if zx > 1240
e dec -350 if cj > -3724
sql dec -93 if mh >= -2463
gsz inc -995 if s == 1675
zx dec -906 if i != -4536
ykc inc -283 if gsz > 3192
ubu dec 59 if zx == 2142
zx dec -986 if rzc != 5571
mh dec -528 if mh != -2466
bp dec 228 if a > 1345
e inc -351 if i != -4536
koq dec 73 if ix > 1592
it inc 608 if ix == 1585
hwz dec 690 if it == 984
g dec 984 if it >= 981
ix dec 744 if ehw >= 4963
ix dec -747 if a == 1347
y inc -894 if g != -800
ix inc -138 if a <= 1353
y dec -631 if s == 1680
ubu inc -765 if ykc != -2834
g dec 132 if ubu <= -4217
cj dec 844 if yor == 3782
bp inc 618 if sql == 1060
rzc inc -347 if np > -1605
cj dec 708 if gsz <= 3200
i inc -568 if gsz < 3188
g inc -382 if s < 1677
zx inc -510 if ehw < 4976
cj inc -338 if y > -1725
cj inc 730 if y < -1723
s inc 675 if koq == 3087
xrh inc -189 if bp > 1360
yor dec 131 if sql > 1055
bp dec -431 if hwz == -2056
g inc -934 if s <= 2358
it inc -168 if g > -2266
ykc inc -759 if xrh > -178
rzc dec -47 if hwz > -2054
s dec -414 if ix > 1441
ehw dec -615 if gsz == 3196
s inc 985 if ix > 1450
mh dec -792 if mh <= -1924
it inc -233 if xrh <= -169
rzc dec -367 if gsz != 3206
rzc inc -110 if ykc <= -3593
mh dec -109 if i != -4552
gsz inc -442 if gsz >= 3188
ehw dec 725 if s >= 2766
koq inc 445 if do <= 326
a dec -117 if np <= -1599
i inc -718 if a == 1464
sql dec -682 if gsz > 2745
mh dec 423 if a > 1454
do dec -513 if ehw >= 5582
a inc 131 if gsz >= 2763
y dec 691 if sql <= 1743
bp inc 4 if s == 2764
yor dec 101 if xrh <= -169
g inc -58 if yor != 3560
ykc dec -432 if ix > 1447
ykc inc 355 if bp > 1807
g inc 492 if xrh <= -174
ubu dec 404 if i >= -5265
a dec -120 if e == -838
zx inc -366 if koq > 3523
ehw inc -438 if ubu == -4624
i inc 535 if mh >= -1445
gsz dec -128 if ubu < -4623
g inc -748 if ykc != -3166
sql inc -540 if gsz >= 2880
koq dec 837 if y >= -2419
mh dec -172 if y <= -2425
xrh dec 330 if mh >= -1456
s inc -326 if koq < 3540
bp dec 631 if bp <= 1799
s dec 542 if ix == 1450
ix inc -194 if gsz < 2886
do dec 695 if do != 821
cj inc 983 if koq >= 3529
cj inc 816 if gsz != 2880
ykc inc 773 if np >= -1595
ubu dec 898 if ykc < -3155
yor dec 719 if do != 135
ix inc -651 if cj > -2739
bp dec 433 if np < -1600
ubu inc -681 if it > 574
bp inc 419 if np <= -1601
g inc 896 if ykc < -3172
np dec -299 if np == -1604
koq inc -250 if sql > 1199
hwz dec -157 if yor <= 3559
mh inc -240 if zx > 2248
xrh inc 759 if do > 129
sql inc -477 if bp >= 1149
yor dec 454 if e == -829
g dec 841 if oj < 4722
ykc inc 965 if bp != 1154
ehw dec 639 if bp == 1153
i dec -598 if a > 1457
gsz inc 932 if bp >= 1152
mh inc -434 if gsz >= 3815
koq dec 538 if gsz <= 3818
xrh dec 796 if bp != 1146
ubu inc -228 if i == -4665
ykc inc -386 if xrh >= -542
sql dec 57 if rzc >= 5483
ubu inc 49 if zx < 2262
a inc -259 if rzc <= 5475
e inc 510 if hwz <= -1895
oj dec -450 if cj <= -2738
i inc -194 if hwz == -1899
hwz inc 398 if bp >= 1148
xrh inc 640 if e > -322
ubu dec 582 if mh > -1691
xrh inc 148 if g < -3409
oj dec 495 if oj != 5163
ehw dec -897 if ix <= 600
ubu inc 552 if koq <= 2746
hwz dec 840 if koq < 2748
bp dec -942 if bp > 1158
do dec -806 if hwz <= -2332
ehw inc 962 if hwz > -2342
oj dec -16 if sql <= 720
it inc -641 if ix >= 614
ix inc 447 if y <= -2421
cj dec 277 if xrh <= 250
bp dec 910 if xrh <= 251
i dec 946 if gsz < 3816
cj dec 769 if do <= 947
ykc dec 925 if e >= -317
hwz dec 676 if koq > 2746
it inc -881 if mh > -1700
g inc -980 if y >= -2424
sql inc -607 if it < -301
do dec -854 if yor != 3094
y inc -190 if gsz >= 3814
cj inc 556 if y < -2619
ix dec -350 if oj != 5158
oj inc -811 if koq < 2736
a dec 895 if zx > 2253
mh inc -718 if ehw != 5469
y dec -170 if yor == 3096
ykc dec -233 if e > -323
yor dec -955 if g <= -4389
oj inc -602 if mh != -2413
oj dec -382 if hwz >= -2339
ix dec -469 if cj < -3782
yor inc -714 if cj <= -3778
zx dec -273 if a >= 564
ykc inc 258 if y < -2432
y inc 76 if koq <= 2748
bp inc 909 if hwz < -2331
ix inc 304 if ehw > 5460
hwz dec -436 if e > -321
gsz inc 777 if ykc <= -2086
y inc 719 if e < -315
bp inc 236 if oj != 5160
g inc -384 if do < 1799
e inc 697 if ehw > 5460
mh inc -756 if do < 1797
zx dec 913 if cj != -3784
sql inc -221 if y < -1645
i dec -892 if mh != -3174
a dec -716 if s <= 1898
gsz dec -321 if ubu <= -5826
oj inc 783 if g == -4777
s dec -203 if y > -1653
cj dec -224 if mh > -3170
hwz dec 66 if gsz > 4904
ykc inc 435 if y < -1641
xrh dec -733 if g >= -4781
it inc 956 if cj <= -3556
""".components(separatedBy: .newlines)
print(input)

struct Instruction {
    let register: String
    let action: String
    let amount: Int
    let condition: String
    
    init(_ line: String) {
        let com = line.components(separatedBy: " ")
        self.register = com[0]
        self.action = com[1]
        self.amount = Int(com[2])!
        self.condition = line.components(separatedBy: " if ")[1]
    }
}

var instructions: [Instruction] = []

for line in input {
    let instruction = Instruction(line)
    instructions.append(instruction)
}

print(instructions)

var registers: [String: Int] = [:]
var max: Int = 0

for ins in instructions {
    let con = ins.condition
    let com = con.description.components(separatedBy: " ")
    let nam = com[0]
    let condition = com[1]
    let num = Int(com[2])!

    switch condition {
    case ">":
        if registers[nam, default: 0] > num {
            if ins.action == "inc" {
                registers[ins.register] = registers[ins.register, default:0] + ins.amount
            }
            else {
                registers[ins.register] = registers[ins.register, default:0] - ins.amount
            }
        }
    case "<":
        if registers[nam, default: 0] < num {
            if ins.action == "inc" {
                registers[ins.register, default:0] += ins.amount
            }
            else {
                registers[ins.register, default:0] -= ins.amount

            }
        }
        
    case ">=":
        if registers[nam, default: 0] >= num {
            if ins.action == "inc" {
                registers[ins.register, default:0] += ins.amount
            }
            else {
                registers[ins.register, default:0] -= ins.amount
            }
        }
        
    case "==":
        if registers[nam, default: 0] == num {
            if ins.action == "inc" {
                registers[ins.register, default:0] += ins.amount
            }
            else {
                registers[ins.register, default:0] -= ins.amount
            }
        }
        
    case "<=":
        if registers[nam, default: 0] <= num {
            if ins.action == "inc" {
                registers[ins.register, default:0] += ins.amount
            }
            else {
                registers[ins.register, default:0] -= ins.amount
            }
        }
    case "!=":
        if registers[nam, default: 0] != num {
            if ins.action == "inc" {
                registers[ins.register, default:0] += ins.amount
            }
            else {
                registers[ins.register, default:0] -= ins.amount
            }
        }
    default:
        fatalError("unknown")
    }
    
    if registers.values.max()! > max {
        max = registers.values.max()!
    }
}

func partOne() -> Int {
    registers.values.max()!
}

func partTwo() -> Int {
    max
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
