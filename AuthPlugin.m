#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <dlfcn.h>

static NSString * const kKeyActiveCode = @"ActiveAuthCode";
static NSString * const kKeyActiveDevice = @"ActiveAuthDevice";
static NSString * const kKeyActivationTime = @"ActiveAuthTime";
static NSString * const kKeyCodeType = @"ActiveCodeType";

static NSArray *getAuthDatabase() {
    static NSArray *database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database = @[
            // ===== 日卡 (100) =====
            @{@"code": @"DAY-XAJI0-Y6DPB", @"type": @"日卡"}, @{@"code": @"DAY-HSAHX-THV3A", @"type": @"日卡"}, @{@"code": @"DAY-3ZMF8-MDD4V", @"type": @"日卡"}, @{@"code": @"DAY-30T9N-T3W5U", @"type": @"日卡"}, @{@"code": @"DAY-ZBIKC-IDKWN", @"type": @"日卡"}, @{@"code": @"DAY-NHJ7X-VG0FN", @"type": @"日卡"}, @{@"code": @"DAY-9XUY4-1IBLJ", @"type": @"日卡"}, @{@"code": @"DAY-H75LX-O6QJI", @"type": @"日卡"}, @{@"code": @"DAY-UJV6O-H9SDB", @"type": @"日卡"}, @{@"code": @"DAY-DW2PC-N9T84", @"type": @"日卡"},
            @{@"code": @"DAY-AZYTJ-XEPQ8", @"type": @"日卡"}, @{@"code": @"DAY-5JSG6-5KXVF", @"type": @"日卡"}, @{@"code": @"DAY-1T2TA-LA753", @"type": @"日卡"}, @{@"code": @"DAY-LC58D-RC11E", @"type": @"日卡"}, @{@"code": @"DAY-RTJ5P-HT0HL", @"type": @"日卡"}, @{@"code": @"DAY-9XPSE-IMVIH", @"type": @"日卡"}, @{@"code": @"DAY-CWI64-CIYHE", @"type": @"日卡"}, @{@"code": @"DAY-7UR23-GDPPQ", @"type": @"日卡"}, @{@"code": @"DAY-0Y9DO-M5IGQ", @"type": @"日卡"}, @{@"code": @"DAY-PKI7P-5TB94", @"type": @"日卡"},
            @{@"code": @"DAY-874FR-HOCN9", @"type": @"日卡"}, @{@"code": @"DAY-J2QP8-9UZFK", @"type": @"日卡"}, @{@"code": @"DAY-8UT0C-VS4F8", @"type": @"日卡"}, @{@"code": @"DAY-CGVYI-E6IVW", @"type": @"日卡"}, @{@"code": @"DAY-PVS7H-ZIOYK", @"type": @"日卡"}, @{@"code": @"DAY-L1CQ9-9CHJ7", @"type": @"日卡"}, @{@"code": @"DAY-55NF4-ZW9XA", @"type": @"日卡"}, @{@"code": @"DAY-3KX7E-EDTJV", @"type": @"日卡"}, @{@"code": @"DAY-ZHWJR-64DPJ", @"type": @"日卡"}, @{@"code": @"DAY-A1WJ0-TPAC5", @"type": @"日卡"},
            @{@"code": @"DAY-6T4UF-EL624", @"type": @"日卡"}, @{@"code": @"DAY-6HID2-5OWF7", @"type": @"日卡"}, @{@"code": @"DAY-5935A-0L725", @"type": @"日卡"}, @{@"code": @"DAY-3J2D5-4I3QK", @"type": @"日卡"}, @{@"code": @"DAY-2IAGL-58KXO", @"type": @"日卡"}, @{@"code": @"DAY-9T7E8-G8JDP", @"type": @"日卡"}, @{@"code": @"DAY-0LVSN-UJZA7", @"type": @"日卡"}, @{@"code": @"DAY-TZ0YN-CXLL4", @"type": @"日卡"}, @{@"code": @"DAY-ZKLOO-KEP7Y", @"type": @"日卡"}, @{@"code": @"DAY-6WKTA-KPUXQ", @"type": @"日卡"},
            @{@"code": @"DAY-PHR62-GDSWM", @"type": @"日卡"}, @{@"code": @"DAY-31YIH-AIR4C", @"type": @"日卡"}, @{@"code": @"DAY-OWGZR-IXA11", @"type": @"日卡"}, @{@"code": @"DAY-DPG8S-BI4Q2", @"type": @"日卡"}, @{@"code": @"DAY-Y9V86-WZS3T", @"type": @"日卡"}, @{@"code": @"DAY-60RJI-W1SWJ", @"type": @"日卡"}, @{@"code": @"DAY-CKJLT-EIYZC", @"type": @"日卡"}, @{@"code": @"DAY-OTOHP-6VZ41", @"type": @"日卡"}, @{@"code": @"DAY-NAM14-8P0TV", @"type": @"日卡"}, @{@"code": @"DAY-HHPBM-YOFQE", @"type": @"日卡"},
            @{@"code": @"DAY-WAOUA-XEQBN", @"type": @"日卡"}, @{@"code": @"DAY-HL1N1-3JCAT", @"type": @"日卡"}, @{@"code": @"DAY-9MX2X-18HAF", @"type": @"日卡"}, @{@"code": @"DAY-EYUHZ-1GV0E", @"type": @"日卡"}, @{@"code": @"DAY-38DAL-Y8OZC", @"type": @"日卡"}, @{@"code": @"DAY-YWD14-VE92M", @"type": @"日卡"}, @{@"code": @"DAY-PNSM4-3D8W3", @"type": @"日卡"}, @{@"code": @"DAY-ZP08J-3TRP0", @"type": @"日卡"}, @{@"code": @"DAY-J43D5-IQVNB", @"type": @"日卡"}, @{@"code": @"DAY-4GH2M-5ZJA8", @"type": @"日卡"},
            @{@"code": @"DAY-DZR1Y-XR2DH", @"type": @"日卡"}, @{@"code": @"DAY-YLURT-P0LZJ", @"type": @"日卡"}, @{@"code": @"DAY-JEGET-1GHR0", @"type": @"日卡"}, @{@"code": @"DAY-9SKDG-IGATJ", @"type": @"日卡"}, @{@"code": @"DAY-9TZE5-R5UQP", @"type": @"日卡"}, @{@"code": @"DAY-GB7R3-OCWBF", @"type": @"日卡"}, @{@"code": @"DAY-UK9E1-V2ISQ", @"type": @"日卡"}, @{@"code": @"DAY-P49KW-V08HH", @"type": @"日卡"}, @{@"code": @"DAY-XFGCA-QVKIZ", @"type": @"日卡"}, @{@"code": @"DAY-ZQY72-WX7PT", @"type": @"日卡"},
            @{@"code": @"DAY-X63CF-L0UKE", @"type": @"日卡"}, @{@"code": @"DAY-YZ7SR-CBPLJ", @"type": @"日卡"}, @{@"code": @"DAY-D84U8-9YJB1", @"type": @"日卡"}, @{@"code": @"DAY-QX6GV-WRDML", @"type": @"日卡"}, @{@"code": @"DAY-Y4LYK-83TQL", @"type": @"日卡"}, @{@"code": @"DAY-L8OS9-XTOGN", @"type": @"日卡"}, @{@"code": @"DAY-1W1HT-7PZE9", @"type": @"日卡"}, @{@"code": @"DAY-VIFTT-D96QE", @"type": @"日卡"}, @{@"code": @"DAY-3RZSJ-49ITN", @"type": @"日卡"}, @{@"code": @"DAY-7S55J-2O7S3", @"type": @"日卡"},
            @{@"code": @"DAY-KKV9R-FTMTT", @"type": @"日卡"}, @{@"code": @"DAY-QLGZU-I1B0Z", @"type": @"日卡"}, @{@"code": @"DAY-3NX39-RBSV5", @"type": @"日卡"}, @{@"code": @"DAY-5PSQ0-OXFQ8", @"type": @"日卡"}, @{@"code": @"DAY-MYX44-4NLZ1", @"type": @"日卡"}, @{@"code": @"DAY-5BCW7-90PDW", @"type": @"日卡"}, @{@"code": @"DAY-5PY6B-2KNFT", @"type": @"日卡"}, @{@"code": @"DAY-U2GC5-WI6FQ", @"type": @"日卡"}, @{@"code": @"DAY-JJA26-YFPMV", @"type": @"日卡"}, @{@"code": @"DAY-XPJ4H-NRIUU", @"type": @"日卡"},
            @{@"code": @"DAY-9K9XJ-UY0BV", @"type": @"日卡"}, @{@"code": @"DAY-R6K2V-MWWYZ", @"type": @"日卡"}, @{@"code": @"DAY-X4W6X-LPU0D", @"type": @"日卡"}, @{@"code": @"DAY-K0GET-8T63J", @"type": @"日卡"}, @{@"code": @"DAY-3R30M-E8F84", @"type": @"日卡"}, @{@"code": @"DAY-0982N-2ATQY", @"type": @"日卡"}, @{@"code": @"DAY-YV37D-IA5U6", @"type": @"日卡"}, @{@"code": @"DAY-HC36K-OF8KR", @"type": @"日卡"}, @{@"code": @"DAY-D5EQY-08P0F", @"type": @"日卡"}, @{@"code": @"DAY-ODRO8-BNP84", @"type": @"日卡"},

            // ===== 月卡 (100) =====
            @{@"code": @"MON-DYT9M-OGE4Q", @"type": @"月卡"}, @{@"code": @"MON-XXVA2-IEUC1", @"type": @"月卡"}, @{@"code": @"MON-HH5LF-6A4FE", @"type": @"月卡"}, @{@"code": @"MON-JGXAA-2ILGB", @"type": @"月卡"}, @{@"code": @"MON-0S0R2-SDS8B", @"type": @"月卡"}, @{@"code": @"MON-25SQ8-CROYR", @"type": @"月卡"}, @{@"code": @"MON-6CCVC-JWTL9", @"type": @"月卡"}, @{@"code": @"MON-TQVDZ-4X1ZH", @"type": @"月卡"}, @{@"code": @"MON-QIMQO-DPXNF", @"type": @"月卡"}, @{@"code": @"MON-7C3DD-03UVU", @"type": @"月卡"},
            @{@"code": @"MON-LEMX1-5Z8VM", @"type": @"月卡"}, @{@"code": @"MON-UHXID-4N1U3", @"type": @"月卡"}, @{@"code": @"MON-493WX-A73JG", @"type": @"月卡"}, @{@"code": @"MON-ZLMA5-UOFWB", @"type": @"月卡"}, @{@"code": @"MON-0HPMN-Z1UDB", @"type": @"月卡"}, @{@"code": @"MON-FWYJX-RPJ1E", @"type": @"月卡"}, @{@"code": @"MON-PKYRY-BOVAK", @"type": @"月卡"}, @{@"code": @"MON-HEJLA-0GNZS", @"type": @"月卡"}, @{@"code": @"MON-43C5B-A75UU", @"type": @"月卡"}, @{@"code": @"MON-ZPEAL-2W37D", @"type": @"月卡"},
            @{@"code": @"MON-4IVSO-LMLGS", @"type": @"月卡"}, @{@"code": @"MON-ES6M0-33IFH", @"type": @"月卡"}, @{@"code": @"MON-V1XG1-R11Q7", @"type": @"月卡"}, @{@"code": @"MON-UWW5W-FCPKJ", @"type": @"月卡"}, @{@"code": @"MON-CSLQC-3C54W", @"type": @"月卡"}, @{@"code": @"MON-SQT26-Q3XLR", @"type": @"月卡"}, @{@"code": @"MON-FCD6M-ZSGIP", @"type": @"月卡"}, @{@"code": @"MON-PSFNK-OMV2X", @"type": @"月卡"}, @{@"code": @"MON-CDYK0-X65MU", @"type": @"月卡"}, @{@"code": @"MON-FM8ZO-V7LN2", @"type": @"月卡"},
            @{@"code": @"MON-3Y30Y-SXPNN", @"type": @"月卡"}, @{@"code": @"MON-GH8RI-EC4D1", @"type": @"月卡"}, @{@"code": @"MON-45BM1-ENF31", @"type": @"月卡"}, @{@"code": @"MON-3FPOY-IPK0Q", @"type": @"月卡"}, @{@"code": @"MON-TL3Q4-N89QK", @"type": @"月卡"}, @{@"code": @"MON-NS832-EJX5T", @"type": @"月卡"}, @{@"code": @"MON-D44K1-J6FP8", @"type": @"月卡"}, @{@"code": @"MON-HQMAB-SI9NB", @"type": @"月卡"}, @{@"code": @"MON-74X2E-K3ZEZ", @"type": @"月卡"}, @{@"code": @"MON-QACJ4-T0SEK", @"type": @"月卡"},
            @{@"code": @"MON-KBP2Q-D6VAS", @"type": @"月卡"}, @{@"code": @"MON-IFPWI-OXD9C", @"type": @"月卡"}, @{@"code": @"MON-SS9TO-QW9JA", @"type": @"月卡"}, @{@"code": @"MON-2M0W1-0LBT3", @"type": @"月卡"}, @{@"code": @"MON-G2QZW-3C1QK", @"type": @"月卡"}, @{@"code": @"MON-BHB7S-9TJ1G", @"type": @"月卡"}, @{@"code": @"MON-M25LE-N606N", @"type": @"月卡"}, @{@"code": @"MON-9RR7S-20CV3", @"type": @"月卡"}, @{@"code": @"MON-TLCXL-VPYMB", @"type": @"月卡"}, @{@"code": @"MON-5M9J9-8CWN2", @"type": @"月卡"},
            @{@"code": @"MON-Y8FV2-BC2NN", @"type": @"月卡"}, @{@"code": @"MON-UVY8N-1UTOX", @"type": @"月卡"}, @{@"code": @"MON-IE0RN-UJJQ9", @"type": @"月卡"}, @{@"code": @"MON-K6RE4-Q6QDY", @"type": @"月卡"}, @{@"code": @"MON-4LMCT-64Z7W", @"type": @"月卡"}, @{@"code": @"MON-2SEHE-2ATN2", @"type": @"月卡"}, @{@"code": @"MON-TWDL9-ZS13C", @"type": @"月卡"}, @{@"code": @"MON-9XQYM-52XG8", @"type": @"月卡"}, @{@"code": @"MON-P6BEF-FLZM7", @"type": @"月卡"}, @{@"code": @"MON-64JWT-EKTSG", @"type": @"月卡"},
            @{@"code": @"MON-7FXZV-4U3BB", @"type": @"月卡"}, @{@"code": @"MON-XUX1O-XRWK8", @"type": @"月卡"}, @{@"code": @"MON-R2YKC-CPRHV", @"type": @"月卡"}, @{@"code": @"MON-LZ049-ENULQ", @"type": @"月卡"}, @{@"code": @"MON-JIDKN-WI5FL", @"type": @"月卡"}, @{@"code": @"MON-UL1RS-RLA8S", @"type": @"月卡"}, @{@"code": @"MON-8HMBR-5XQT4", @"type": @"月卡"}, @{@"code": @"MON-P501N-OUHTC", @"type": @"月卡"}, @{@"code": @"MON-S1K9Y-E9O2M", @"type": @"月卡"}, @{@"code": @"MON-71HSS-BELRQ", @"type": @"月卡"},
            @{@"code": @"MON-VSLWF-90KM3", @"type": @"月卡"}, @{@"code": @"MON-TZK3N-Y9V20", @"type": @"月卡"}, @{@"code": @"MON-YAR82-1UZVG", @"type": @"月卡"}, @{@"code": @"MON-WW4FY-B8DAL", @"type": @"月卡"}, @{@"code": @"MON-FYO17-50CEH", @"type": @"月卡"}, @{@"code": @"MON-LXSLG-6MM1Z", @"type": @"月卡"}, @{@"code": @"MON-XYVGI-UI9KK", @"type": @"月卡"}, @{@"code": @"MON-HZLM7-2JEYN", @"type": @"月卡"}, @{@"code": @"MON-9382K-KZMPJ", @"type": @"月卡"}, @{@"code": @"MON-RHT7Z-EWVIY", @"type": @"月卡"},
            @{@"code": @"MON-TWBOZ-D1AT7", @"type": @"月卡"}, @{@"code": @"MON-O75RH-8LX6D", @"type": @"月卡"}, @{@"code": @"MON-UT076-G5G79", @"type": @"月卡"}, @{@"code": @"MON-OR787-5AUD9", @"type": @"月卡"}, @{@"code": @"MON-K9TR7-4QGEF", @"type": @"月卡"}, @{@"code": @"MON-QJG02-U1G46", @"type": @"月卡"}, @{@"code": @"MON-3SDYG-FLIJI", @"type": @"月卡"}, @{@"code": @"MON-18K0A-XYCEL", @"type": @"月卡"}, @{@"code": @"MON-OS6ZL-E6KWH", @"type": @"月卡"}, @{@"code": @"MON-EF0VO-TQTXH", @"type": @"月卡"},
            @{@"code": @"MON-I15CQ-ZCUCT", @"type": @"月卡"}, @{@"code": @"MON-SUFLS-EHUDS", @"type": @"月卡"}, @{@"code": @"MON-3QSQC-Q30O3", @"type": @"月卡"}, @{@"code": @"MON-0UBMC-97C7B", @"type": @"月卡"}, @{@"code": @"MON-O119X-P9N56", @"type": @"月卡"}, @{@"code": @"MON-NYXTX-MGTT0", @"type": @"月卡"}, @{@"code": @"MON-IAAKY-TT3IM", @"type": @"月卡"}, @{@"code": @"MON-J70E3-P15AH", @"type": @"月卡"}, @{@"code": @"MON-DBVZB-0OIH5", @"type": @"月卡"}, @{@"code": @"MON-CSK30-LVYLK", @"type": @"月卡"},

            // ===== 永久卡 (100) =====
            @{@"code": @"PER-FXHKC-856WP", @"type": @"永久卡"}, @{@"code": @"PER-R97Y2-LOFN1", @"type": @"永久卡"}, @{@"code": @"PER-R4KZ3-6U8UE", @"type": @"永久卡"}, @{@"code": @"PER-IHX74-D0GJY", @"type": @"永久卡"}, @{@"code": @"PER-V5G10-UR5L8", @"type": @"永久卡"}, @{@"code": @"PER-A78E9-RIVH6", @"type": @"永久卡"}, @{@"code": @"PER-T1NTM-JSRD9", @"type": @"永久卡"}, @{@"code": @"PER-Q46NO-UHFJ7", @"type": @"永久卡"}, @{@"code": @"PER-UPFLN-4RXYJ", @"type": @"永久卡"}, @{@"code": @"PER-38XRG-2GZR7", @"type": @"永久卡"},
            @{@"code": @"PER-TXCB4-8Y1O4", @"type": @"永久卡"}, @{@"code": @"PER-IZASN-WYWRR", @"type": @"永久卡"}, @{@"code": @"PER-ATATJ-9A3Y3", @"type": @"永久卡"}, @{@"code": @"PER-6DDFG-S3JON", @"type": @"永久卡"}, @{@"code": @"PER-OU9IY-4X41D", @"type": @"永久卡"}, @{@"code": @"PER-NTCAG-RP2U4", @"type": @"永久卡"}, @{@"code": @"PER-DTBH5-5RBC7", @"type": @"永久卡"}, @{@"code": @"PER-6UB7L-8V1ZO", @"type": @"永久卡"}, @{@"code": @"PER-CFI4O-6L1F9", @"type": @"永久卡"}, @{@"code": @"PER-0S9BP-4M18O", @"type": @"永久卡"},
            @{@"code": @"PER-1BJ9R-M7PYX", @"type": @"永久卡"}, @{@"code": @"PER-DW2ZC-FZW0L", @"type": @"永久卡"}, @{@"code": @"PER-DALMJ-EGQTO", @"type": @"永久卡"}, @{@"code": @"PER-AMDVL-NKND6", @"type": @"永久卡"}, @{@"code": @"PER-69UGN-EKRCP", @"type": @"永久卡"}, @{@"code": @"PER-PRCJI-WVHDK", @"type": @"永久卡"}, @{@"code": @"PER-8LW2L-M349E", @"type": @"永久卡"}, @{@"code": @"PER-L8HL8-8KZRU", @"type": @"永久卡"}, @{@"code": @"PER-IN3OE-UVTYT", @"type": @"永久卡"}, @{@"code": @"PER-8QZPK-Y32OR", @"type": @"永久卡"},
            @{@"code": @"PER-WIXZ2-C9ROS", @"type": @"永久卡"}, @{@"code": @"PER-7YT2M-6TWD1", @"type": @"永久卡"}, @{@"code": @"PER-XMXB9-YO18P", @"type": @"永久卡"}, @{@"code": @"PER-AJSSU-UQO1V", @"type": @"永久卡"}, @{@"code": @"PER-SMADO-8E7FL", @"type": @"永久卡"}, @{@"code": @"PER-QHRRP-ZLK3E", @"type": @"永久卡"}, @{@"code": @"PER-4XYF9-IGFU8", @"type": @"永久卡"}, @{@"code": @"PER-IOGXP-BWHVN", @"type": @"永久卡"}, @{@"code": @"PER-ZH13C-D5GLQ", @"type": @"永久卡"}, @{@"code": @"PER-J5SXV-WVM4W", @"type": @"永久卡"},
            @{@"code": @"PER-3ZKWD-EEKGY", @"type": @"永久卡"}, @{@"code": @"PER-SPENG-WYX9T", @"type": @"永久卡"}, @{@"code": @"PER-RFLQB-MAE38", @"type": @"永久卡"}, @{@"code": @"PER-SRYO4-RCB1K", @"type": @"永久卡"}, @{@"code": @"PER-JTGQ0-1TEE1", @"type": @"永久卡"}, @{@"code": @"PER-3N3BZ-T9D31", @"type": @"永久卡"}, @{@"code": @"PER-K9QM3-P91I3", @"type": @"永久卡"}, @{@"code": @"PER-VMZWF-FHHCM", @"type": @"永久卡"}, @{@"code": @"PER-KTLZK-J49YD", @"type": @"永久卡"}, @{@"code": @"PER-82795-E5IZ3", @"type": @"永久卡"},
            @{@"code": @"PER-1YRUJ-OQW5D", @"type": @"永久卡"}, @{@"code": @"PER-SK7N8-LA100", @"type": @"永久卡"}, @{@"code": @"PER-QXMCT-HPHJ3", @"type": @"永久卡"}, @{@"code": @"PER-MUURM-YBD2Q", @"type": @"永久卡"}, @{@"code": @"PER-E4PA8-HYEXF", @"type": @"永久卡"}, @{@"code": @"PER-7JXJN-6FOKZ", @"type": @"永久卡"}, @{@"code": @"PER-IXZAR-EIYAZ", @"type": @"永久卡"}, @{@"code": @"PER-39PEC-N0DL5", @"type": @"永久卡"}, @{@"code": @"PER-E11E9-FTAXP", @"type": @"永久卡"}, @{@"code": @"PER-0WFOY-4DD1V", @"type": @"永久卡"},
            @{@"code": @"PER-N8LFJ-DTVV2", @"type": @"永久卡"}, @{@"code": @"PER-Y4XKS-S0KB6", @"type": @"永久卡"}, @{@"code": @"PER-8RERV-T997E", @"type": @"永久卡"}, @{@"code": @"PER-4UNY1-81ACJ", @"type": @"永久卡"}, @{@"code": @"PER-BC2SW-SOZCT", @"type": @"永久卡"}, @{@"code": @"PER-WJLSH-3TOW4", @"type": @"永久卡"}, @{@"code": @"PER-YCZ04-CDPQV", @"type": @"永久卡"}, @{@"code": @"PER-L00EZ-ZF8S2", @"type": @"永久卡"}, @{@"code": @"PER-ZGE2J-51B3J", @"type": @"永久卡"}, @{@"code": @"PER-CZUCQ-MRUNJ", @"type": @"永久卡"},
            @{@"code": @"PER-DU0IS-B5IQN", @"type": @"永久卡"}, @{@"code": @"PER-F74T6-0PLOZ", @"type": @"永久卡"}, @{@"code": @"PER-JCNS6-G298C", @"type": @"永久卡"}, @{@"code": @"PER-QK4LT-AHUKW", @"type": @"永久卡"}, @{@"code": @"PER-QVR1H-61IAO", @"type": @"永久卡"}, @{@"code": @"PER-IM458-AX40D", @"type": @"永久卡"}, @{@"code": @"PER-TIRC9-ZD76S", @"type": @"永久卡"}, @{@"code": @"PER-ZN9DD-E3CUP", @"type": @"永久卡"}, @{@"code": @"PER-8IJL2-Z0LJC", @"type": @"永久卡"}, @{@"code": @"PER-H2VFF-QOT8H", @"type": @"永久卡"},
            @{@"code": @"PER-LJEFY-3ZB4L", @"type": @"永久卡"}, @{@"code": @"PER-DIMSY-J9BOQ", @"type": @"永久卡"}, @{@"code": @"PER-0IQ2F-A39E3", @"type": @"永久卡"}, @{@"code": @"PER-NWXUJ-3AC6P", @"type": @"永久卡"}, @{@"code": @"PER-E63LB-QGU3O", @"type": @"永久卡"}, @{@"code": @"PER-BYGHG-K5BWI", @"type": @"永久卡"}, @{@"code": @"PER-KOTCK-EH5SW", @"type": @"永久卡"}, @{@"code": @"PER-2292M-TR6SN", @"type": @"永久卡"}, @{@"code": @"PER-GLH62-C9T19", @"type": @"永久卡"}, @{@"code": @"PER-9DXJ3-7C9H4", @"type": @"永久卡"},
            @{@"code": @"PER-2M44G-V3Z6B", @"type": @"永久卡"}, @{@"code": @"PER-Z8UUG-95RLR", @"type": @"永久卡"}, @{@"code": @"PER-DIHSA-7HEZ7", @"type": @"永久卡"}, @{@"code": @"PER-4LAV7-1448N", @"type": @"永久卡"}, @{@"code": @"PER-7ODKE-F828X", @"type": @"永久卡"}, @{@"code": @"PER-G8Y72-IVGLY", @"type": @"永久卡"}, @{@"code": @"PER-E088O-98BV7", @"type": @"永久卡"}, @{@"code": @"PER-8HU7F-0I9G5", @"type": @"永久卡"}, @{@"code": @"PER-DZX5Q-JICJD", @"type": @"永久卡"}, @{@"code": @"PER-AN085-RNTDR", @"type": @"永久卡"}
        ];
    });
    return database;
}

@interface AuthManager : NSObject
+ (instancetype)sharedInstance;
- (void)checkAndLoad;
@end

@implementation AuthManager
+ (instancetype)sharedInstance {
    static AuthManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ instance = [[AuthManager alloc] init]; });
    return instance;
}
- (void)checkAndLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *activeCode = [defaults objectForKey:kKeyActiveCode];
    NSString *activeDevice = [defaults objectForKey:kKeyActiveDevice];
    NSTimeInterval activationTime = [defaults doubleForKey:kKeyActivationTime];
    NSString *codeType = [defaults objectForKey:kKeyCodeType];
    
    NSString *currentDevice = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    BOOL isValid = NO;
    
    if (activeCode && [activeDevice isEqualToString:currentDevice]) {
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval elapsed = now - activationTime;
        if ([codeType isEqualToString:@"永久卡"]) isValid = YES;
        else if ([codeType isEqualToString:@"日卡"]) isValid = (elapsed < 24 * 3600);
        else if ([codeType isEqualToString:@"月卡"]) isValid = (elapsed < 30 * 24 * 3600);
    }
    
    if (isValid) {
        [self loadTargetDylib];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{ [self showAuthUI]; });
    }
}

- (void)loadTargetDylib {
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *dylibPath = [bundlePath stringByAppendingPathComponent:@"Frameworks/libgenesysadam.dylib"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) { 
        NSLog(@"[Auth] 找不到目标: %@", dylibPath);
        return; 
    }
    dlopen([dylibPath UTF8String], RTLD_NOW);
}

- (void)showAuthUI {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (!rootVC) return;
    
    // 弹窗不再允许随便取消，只能输入或退出
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"授权验证" message:@"请输入您的激活码以启动游戏" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) { textField.placeholder = @"粘贴或输入激活码"; }];
    
    UIAlertAction *activateAction = [UIAlertAction actionWithTitle:@"激活" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { 
        [self verifyCode:alert.textFields.firstObject.text]; 
    }];
    
    UIAlertAction *exitAction = [UIAlertAction actionWithTitle:@"退出游戏" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { 
        exit(0); // 直接杀进程
    }];
    
    [alert addAction:activateAction];
    [alert addAction:exitAction];
    [rootVC presentViewController:alert animated:YES completion:nil];
}

- (void)verifyCode:(NSString *)code {
    NSArray *codesArray = getAuthDatabase();
    BOOL codeFound = NO;
    NSString *cardType = nil;
    NSString *cleanCode = [[code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    for (NSDictionary *dict in codesArray) {
        if ([dict[@"code"] isEqualToString:cleanCode]) { codeFound = YES; cardType = dict[@"type"]; break; }
    }
    // 如果输入错误，不光是弹窗提示，而是提示后直接杀进程
    if (!codeFound) { 
        [self showErrorAndKill:@"激活码无效，请检查输入"]; 
        return; 
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *savedDevice = [defaults objectForKey:[NSString stringWithFormat:@"Device_%@", cleanCode]];
    NSString *currentDevice = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if (savedDevice && ![savedDevice isEqualToString:currentDevice]) { 
        [self showErrorAndKill:@"该激活码已在其他设备绑定，无法跨设备使用"]; 
        return; 
    }
    
    [defaults setObject:cleanCode forKey:kKeyActiveCode];
    [defaults setObject:currentDevice forKey:kKeyActiveDevice];
    [defaults setObject:@([[NSDate date] timeIntervalSince1970]) forKey:kKeyActivationTime];
    [defaults setObject:cardType forKey:kKeyCodeType];
    [defaults setObject:currentDevice forKey:[NSString stringWithFormat:@"Device_%@", cleanCode]];
    [defaults synchronize];
    
    [self loadTargetDylib];
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC dismissViewControllerAnimated:YES completion:^{ 
        UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:@"成功" message:@"授权成功，祝您游戏愉快！" preferredStyle:UIAlertControllerStyleAlert];
        [successAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [rootVC presentViewController:successAlert animated:YES completion:nil];
    }];
}

// 错误专用：弹窗提示后直接杀进程
- (void)showErrorAndKill:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootVC dismissViewControllerAnimated:YES completion:nil]; // 先关掉输入框
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { 
            exit(0); // 点击退出直接杀进程
        }]];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

@end

__attribute__((constructor)) static void initPlugin() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[AuthManager sharedInstance] checkAndLoad];
    });
}
