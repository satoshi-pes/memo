### RINEX v4.00のnavigation messageの違い

いまさらながらRINEX version4.00を読む。

RINEXでは、version3まではLNAVのみをサポートしていたが、version4からはCNAVにも対応し、仕様としてはかなり複雑なものになった。  
とはいえ、軌道精度は上がるはず。  

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
| :-------------- | :---------------------- | :----------- | :----------- | :------------- | :------------ | :----------- | :----------- | :---------- | :----------- | :------------ | :----------- | :---------- |
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


### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)