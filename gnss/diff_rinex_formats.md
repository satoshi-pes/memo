### RINEX Version間の違い

RINEXのバージョン間での違いに関してメモ。

#### RINEX Header

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



### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)
