### RINEX Version間の違い

RINEXのバージョン間での違いに関してメモ。
RINEX version3.02以降は内容が安定しているのだが、その前は色々と変更がある。  
特に3.01から3.02では、"PHASE SHIFTS"か"PHASE SHIFT"に変わったり、GLONASS slot numberが導入されたり、Beidouの信号コード名の割り当てが変更になったりしている。BeidouのICDがころころ変わったせいだと思うが、Beidouの信号コードが変更になったことで非常にミスが混入しやすくなって、個人的にはRINEX史上最悪の変更。  

ということで、絶対にRINEX 3.02以降を使った方が良い。  
（R4.3.26時点では、国土地理院のRINEXにもversion3.02が使われている）

#### RINEX Header
無印: 必須、\* : オプション、-: 無し

|Header Label        |4.00  |3.02 <br> 3.03 <br> 3.04 <br> 3.05| 3.01 | 3.00 | 2.12 | 2.11 |2.10  | 備考 |
| ------------------ | ---- | -------------------------------- | ---- | ---- | ---- | ---- | ---- | ---- | 
|RINEX VERSION / TYPE|      |                                  |      |      |      |      |      |      |
|PGM / RUN BY / DATE |      |                                  |      |      |      |      |  -   | RINEX4からは複数行指定できるようになった     |
|COMMENT             |  *   |                              *   |  *   |  *   |  *   |  *   |  *   |      | 
|MARKER NAME         |      |                                  |      |      |      |      |  -   |      |
|MARKER NUMBER       |  *   |                              *   |  *   |  *   |  *   |      |  -   |      |
|MARKER TYPE         |      |                                  |      |      |  -   |  -   |  -   |      |
|OBSERVER / AGENCY   |      |                                  |      |      |      |      |  -   |      |
|REC # / TYPE / VERS |      |                                  |      |      |      |      |  -   |      |
|ANT # / TYPE        |      |                                  |      |      |      |      |  -   |      |
|APPROX POSITION XYZ |      |                                  |      |      |      |      |  -   |      |
|ANTENNA: DELTA H/E/N|      |                                  |      |      |      |      |  -   |      |
|WAVELENGTH FACTL1/2 |  -   |                              -   |  -   |  -   |  *   |  *   |      | RINEX3以降廃止     |
|ANTENNA: DELTA X/Y/Z|  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|ANTENNA: PHASECENTER|  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|ANTENNA: B.SIGHT XYZ|  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|ANTENNA: ZERODIR AZI|  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|ANTENNA: ZERODIR XYZ|  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|CENTER OF MASS: XYZ |  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|DOI                 |  *   |                              -   |  -   |  -   |  -   |  -   |  -   |      |
|LICENSE OF USE      |  *   |                              -   |  -   |  -   |  -   |  -   |  -   |      |
|STATION INFORMATION |  *   |                              -   |  -   |  -   |  -   |  -   |  -   |      |
|# / TYPES OF OBSERV |  -   |                              -   |  -   |  -   |      |      |  -   |      |
|SYS / # / OBS TYPES |      |                                  |      |      |  -   |  -   |  -   | RINEX3から名称変更     |
|SIGNAL STRENGTH UNIT|  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|INTERVAL            |  *   |                              *   |  *   |  *   |  *   |  *   |  *   |      |
|TIME OF FIRST OBS   |      |                                  |      |      |      |      |      |      |
|TIME OF LAST OBS    |  *   |                              *   |  *   |  *   |  *   |  *   |  *   |      |
|RCV CLOCK OFFS APPL |  *   |                              *   |  *   |  *   |  *   |  *   |  *   |      |
|SYS / DCBS APPLIED  |  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|SYS / PCVS APPLIED  |  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|SYS / SCALE FACTOR  |  *   |                              *   |  *   |  *   |  -   |  -   |  -   |      |
|SYS / PHASE SHIFTS  |  -   |                              -   |      |  -   |  -   |  -   |  -   | RINEX3.01のみ"SHIFTS"だった     |
|SYS / PHASE SHIFT   |  *   |                                  |  -   |  -   |      |  -   |  -   |      |
|GLONASS SLOT / FRQ #|      |                                  |  *   |  -   |  -   |  -   |  -   |      |
|GLONASS COD/PHS/BIS |  *   |                                  |  -   |  -   |  -   |  -   |  -   |      |
|LEAP SECONDS        |  *   |                              *   |  *   |  *   |  *   |  *   |  -   |      |
|# OF SATELLITES     |  *   |                              *   |  *   |  *   |  *   |  *   |  -   |      |
|PRN / # OF OBS      |  *   |                              *   |  *   |  *   |  *   |  *   |  -   |      |
|END OF HEADER       |      |                                  |      |      |      |      |      |      |

#### memo
※intervalのフォーマットはversion2の頃はI6だった。version2.10以降はF10.3。しかしIGSのRINEXにはINTERVALがF10.4で出力されたものがたくさんある。変換ソフトにバグがあったのだろうか。
*"Time OF FIRST OBS", "TIME OF LAST OBS"の秒のフォーマットはRINEX2ではF12.6, RINEX2.10からはF13.7。

### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)
