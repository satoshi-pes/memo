### RINEX v4.00のnavigation messageの違い

いまさらながらRINEX version4.00を読む。

RINEXでは、version3まではLNAVのみをサポートしていたが、version4からはCNAVにも対応し、仕様としてはかなり複雑なものになった。  
- とはいえ、軌道パラメータは詳細になり、日々のERPも入るようになった。  
- ちなみにGLONASSのephはRINEX3.05から少し拡張されているので注意が必要。  
- version4から、navigationの値の指数表現にはD,dが許容されるものの、非推奨になった。  
D,dはFortranの倍精度実数の指数表現の名残だけれど、Go言語では非標準で、読み込むには標準ライブラリstrconv.ParseFloatのソースをいじったりする必要があったのでこれは良い変更。  
（Fortran使いの方は辛いかもしれないけれど）  

    atof.goのreadFloatで、  
    expChar := byte('e') <- ここを'd'にするとか。


CNAVのEOPの精度比較はこの論文にまとめられている。  
[Steigenberger, P., Montenbruck, O., Bradke, M. et al. Evaluation of earth rotation parameters from modernized GNSS navigation messages. GPS Solut 26, 50 (2022). https://doi.org/10.1007/s10291-022-01232-4](https://link.springer.com/article/10.1007/s10291-022-01232-4)

しかし、Week番号、t_tm (transmission time of message)、Healthフラグの場所は統一して欲しかった。  
次のversionで保存箇所を揃える等の改訂があったらもう滅茶苦茶になりそうだし、このままなのかな。  
ドラフト段階で意見出ししておくべきだったんじゃないか。やっちゃったな、これは・・・。

### まとめ表
(共通)

|              | GPS(LNAV)                                |
| ------------ | ---------------------------------------- |
| TYPE/SV/MSSG | - New Record identifier: >               |
|              | - Navigation Data Record Type – EPH      |
|              | - Satellite system (G), sat number (PRN) |
|              | - Navigation Message Type - LNAV         |


(Navigation message)

|                 | GPS(LNAV)               | GPS(CNAV)    | GPS(CNAV2)   | GAL(INAV/FNAV) | QZSS(LNAV)    | QZSS(CNAV)   | QZSS(CNAV2)  | BDS(D1/D2)  | BDS(CNAV-1)  | BDS(CNAV-2)   | BDS(CNAV-3)  | NavIC(LNAV) |
| -------------- | ---------------------- | ----------- | ----------- | ------------- | ------------ | ----------- | ----------- | ---------- | ----------- | ------------ | ----------- | ---------- |
| SV/EPOCH/SV CLK | SatSys, PRN, Toc        | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | SV clk bias (af0)       | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | SV clk drift (af1)      | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | SV clk drift rate (af2) | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
| BRD1            | IODE                    | A DOT        | A DOT        | IODnav         | IODE          | A DOT        | A DOT        | AODE        | A DOT        | A DOT         | A DOT        | IODE        |
|                 | C_rs                    | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | Delta n                 | Delta n0     | Delta n0     | Delta n0       | Delta n0      | Delta n0     | Delta n0     | Delta n0    | Delta n0     | Delta n0      | Delta n0     | Delta n     |
|                 | M0                      | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
| BRD2            | C_uc                    | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | Eccentricity            | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | C_us                    | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | sqrt(A)                 | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
| BRD3            | T_oe                    | t_op         | t_op         | Toe            | Toe           | t_op         | t_op         | Toe         | t_op         | t_op          | t_op         | Toe         |
|                 | C_ic                    | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | OMEGA0                  | =            | =            | =              | OMEGA         | =            | =            | OMEGA       | =            | =             | =            | OMEGA0      |
|                 | C_is                    | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
| BRD4            | i0                      | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | C_rc                    | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | omega                   | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | OMEGA DOT               | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
| BRD5            | IDOT                    | =            | =            | =              | =             | =            | =            | =           | =            | =             | =            | =           |
|                 | Codes on L2             | Delta n0 dot | Delta n0 dot | Data sources   | Codes on L2   | Delta n0 dot | Delta n0 dot | spare       | Delta n0 dot | Delta n0 dot  | Delta n0 dot | Spare       |
|                 | GPS Week                | URAI_NED0    | URAI_NED0    | GAL Week       | GPS Week      | URAI_NED0    | URAI_NED0    | BDT Week    | SatType      | SatType       | SatType      | IRN Week    |
|                 | L2P data flag           | URAI_NED1    | URAI_NED1    |                | L2P data flag | URAI_NED1    | URAI_NED1    | spare       | t_op         | t_op          | t_op         | spare       |
| BRD6            | SV accuracy             | URAI_ED      | URAI_ED      | SISA           | SV accuracy   | URAI_ED      | URAI_ED      | SV accuracy | SISAI_oe     | SISAI_oe      | SISAI_oe     | URA         |
|                 | SV health               | Sv health    | SV health    | SV health      | Sv health     | SV health    | Sv health    | SatH1       | SISAI_ocb    | SISAI_ocb     | SISAI_ocb    | Health      |
|                 | TGD                     | TGD          | TGD          | BGD E5a/E1     | TGD           | TGD          | TGD          | TGD1 B1/B3  | SISAI_oc1    | SISAI_oc1     | SISAI_oc1    | TGD         |
|                 | IODC                    | URAI_NED2    | URAI_NED2    | BGD E5b/E1     | IODC          | URAI_NED2    | URAI_NED2    | TGD2 B2/B3  | SISAI_oc2    | SISAI_oc2     | SISAI_oc2    | Spare       |
| BRD7            | t_tm                    | ISC_L1CA     | ISC_L1CA     | t_tm           | t_tm          | ISC_L1CA     | ISC_L1CA     | t_tm        | ISC_B1Cd     | spare         | SISMAI       | t_tm        |
|                 | Fit interval            | ISC_L2C      | ISC_L2C      |                | Fit interval  | ISC_L2C      | ISC_L2C      | AODC        | spare        | ISC_B2ad      | Health       |             |
|                 |                         | ISC_L5I5     | ISC_L5I5     |                |               | ISC_L5I5     | ISC_L5I5     |             | TGD_B1Cp     | TGD_B1Cp      | B2b flags    |             |
|                 |                         | ISC_L5Q5     | ISC_L5Q5     |                |               | ISC_L5Q5     | ISC_L5Q5     |             | TGD_B2ap     | TGD_B2ap      | TGD_B2bI     |             |
| BRD8            |                         | t_tm         | ISC_L1Cd     |                |               | t_tm         | ISC_L1Cd     |             | SISMAI       | SISMAI        | t_tm         |             |
|                 |                         | GPS Week     | ISC_L1Cp     |                |               | GPS Week     | ISC_L1Cp     |             | Health       | Health        |              |             |
|                 |                         |              |              |                |               |              |              |             | B1C flags    | B2a+B1C flags |              |             |
|                 |                         |              |              |                |               |              |              |             | IODC         | IODC          |              |             |
| BRD9            |                         |              | t_tm         |                |               |              | t_tm         |             | t_tm         | t_tm          |              |             |
|                 |                         |              | GPS Week     |                |               |              | GPS Week     |             | spare        | spare         |              |             |
|                 |                         |              |              |                |               |              |              |             | spare        | spare         |              |             |
|                 |                         |              |              |                |               |              |              |             | IODE         | IODE          |              |             |


### 共通で使いそうなもの
- 上からIDOTまではLNAV, CNAVでほぼ共通
- Delta n0 dot: CNAVで共通
- SV Health: LNAV, CNAV両方で使う。ただし、bitの定義はそれぞれ異なる。
- Week number: かならず入っているわけではないけど、概ね共通
- t_tm (transmission time)
- TGD (time of group delay between L1 and L2): しかし複数のTGDがある場合があるので、どうするか？
- ISC: CNAVではよく使いそう
- URAI_ED, URAI_NED: これもCNAVではよく使いそう

Beidouのメッセージは他の衛星と構成が異なる。どうする？？


### 意味分からなかった言葉メモ

(GPS, QZS)
- URAI_ED  
   Elevation-Dependent (ED) Use Range Accuracy Index  
- URAI_NED0  
 Non-Elevation-Dependent (NED) Accuracy Index  
- URAI_NED1  
 NED Accuracy Change Index  
- URAI_NED2  
 NED Accuracy Change Rate Index  
- ISC_L1C/A  
 Inter-Signal Correction (L1C/A)  
- ISC_L2C  
 Inter-Signal Correction (L2C)  
- ISC_L5I5  
 Inter-Signal Correction (L5I5)  
- ISC_L5Q5  
 Inter-Signal Correction (L5Q5)  

(Beidou)  
- SISAI  
 Signal In Space Accuracy Index  
- SISAI_oe  
 satellite orbit along-track and cross-track accuracy (SISA_oe) index  
- SISAI_ocb  
 satellite orbit radius and fixed satellite clock bias accuracy (SISA_ocb) index  
- SISAI_oc1  
 satellite clock bias accuracy (SISA_oc1) index  
- SISAI_oc2  
 satellite clock drift accuracy (SISA_oc2) index  
- t_op  
  time of week for data prediction  
- SISMAI (Signal In Space Monitoring Accuracy Index)
  The estimated error of the signal in space accuracy is described by the zero-mean Gaussian distribution model. The signal in space monitoring accuracy (SISMA) is the variance of the Gaussian distribution, which is indicated by the signal in space monitoring accuracy index (SISMAI).
  The specific definitions of the signal in space monitoring accuracy index parameters will be published in a future update of this ICD.  ([ICD-BDS-B1C](http://www.beidou.gov.cn/xt/gfxz/201712/P020171226741342013031.pdf))

(from IS-GPS-705H)
- URA_ED

    The nominal URA ED value (X) is suitable for use as a conservative prediction of the RMS ED range errors for accuracy-related purposes in the pseudorange domain (e.g., measurement de-weighting, RAIM, FOM computations). Integrity properties of the IAURA ED are specified with respect to the scaled (multiplied by either 4.42 or 5.73 as appropriate) upper bound values of the broadcast URA ED index (see 20.3.3.1.1).
   
    For the nominal URA ED value and the IAURA ED value, users may compute an adjusted URA ED value as a function of SV elevation angle (E), for E >= 0, as follows:

    Adjusted Nominal URA ED = Nominal URA ED (sin(E+90 degrees))
    
    Adjusted IAURA ED = IAURA ED (sin(E+90 degrees))

    URA ED and IAURA ED account for SIS contributions to user range error which include, but are not limited to, the following: LSB representation/truncation error, alongtrack ephemeris errors, and crosstrack ephemeris errors. URA ED and IAURA ED do not account for user range error contributions due to the inaccuracy of the broadcast ionospheric data parameters used in the single-frequency ionospheric model or for other atmospheric effects.

- URA_NED

    The user shall calculate the NED-related URA with the equation (in meters);

    IAURA_NED = URA_NED0 + URA_NED1 (t - t_op + 604,800*(WN - WN_op )) for t - t_op + 604,800*(WN - WN_op ) ≤ 93,600 seconds

    IAURA_NED = URA_NED0 + URA_NED1 *(t - t_op + 604,800*(WN - WN_op )) + URA NED2 *(t - t_op + 604,800*(WN - WN_op ) - 93,600) 2 for t - t_op + 604,800*(WN - WN_op ) > 93,600 seconds

    where t is the GPS system time

    IAURA: Integrity Assured URA


- T_op

    T_op: the CEI data sequence propagation time of week (t_op). The t_op term provides the epoch time of week of the state data utilized for propagating the SV clock correction coefficients forward in time. Users are cautioned to avoid using this parameter to compute age of data for any SV.

    CEI: Clock, Ephemeris, Integrity

### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)
