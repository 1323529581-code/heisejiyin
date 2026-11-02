#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import <dlfcn.h>

static BOOL hasShownMyAlert = NO;
static BOOL isAuthorizedFlag = NO;
static BOOL hasLoadedCheat = NO;

// --- 50个带有效期的授权码 ---
NSDictionary *getValidCodesWithTime() {
    static NSDictionary *codes = nil;
    if (!codes) {
        // 时间单位：秒
        // 8小时 = 28800, 24小时 = 86400, 7天 = 604800, 30天 = 2592000, 90天 = 7776000
        codes = @{
            // 试用卡 8小时 (10个)
            @"TRY-5HTDK-SQOF3": @28800, @"TRY-95L84-E9NSD": @28800, @"TRY-ELGE6-RUB3D": @28800,
            @"TRY-G0VOO-I5YNA": @28800, @"TRY-JUV2D-YB62X": @28800, @"TRY-OBH8S-AN1O5": @28800,
            @"TRY-OF9J7-YKTPD": @28800, @"TRY-OUPL1-D87DA": @28800, @"TRY-TNQ4N-Y0BSD": @28800,
            @"TRY-UGI4I-ZZJ4V": @28800,
            
            // 天卡 24小时 (10个)
            @"DAY-06U0C-41GQU": @86400, @"DAY-0J9G0-8Z4D8": @86400, @"DAY-9A5PM-BAZFS": @86400,
            @"DAY-HMRCP-U3K6Z": @86400, @"DAY-M7GIA-FTWRU": @86400, @"DAY-UF7UZ-I5ELZ": @86400,
            @"DAY-VE6VW-66VW4": @86400, @"DAY-XWB6F-WS5LO": @86400, @"DAY-XZ17B-0OLJG": @86400,
            @"DAY-YKOHD-0KD12": @86400,
            
            // 周卡 7天 (10个)
            @"WEK-2VI77-V1B5U": @604800, @"WEK-7IVX9-2098S": @604800, @"WEK-BGPP4-C0LOX": @604800,
            @"WEK-FUBLD-JX573": @604800, @"WEK-G60B8-PV3JI": @604800, @"WEK-I2GJ5-Y1URN": @604800,
            @"WEK-K1UOH-QOZWB": @604800, @"WEK-QRYO7-4FVZ1": @604800, @"WEK-SNSVM-4YW82": @604800,
            @"WEK-UP8UE-OYS6A": @604800,
            
            // 月卡 30天 (10个)
            @"MON-50FPE-T8XTN": @2592000, @"MON-7G0HW-DUAJW": @2592000, @"MON-BQDZZ-4YZOF": @2592000,
            @"MON-ESILT-HQYVA": @2592000, @"MON-NF346-7OAUX": @2592000, @"MON-RFUQY-ZHHQV": @2592000,
            @"MON-SN6DM-XU3D5": @2592000, @"MON-T0QP1-PPCI2": @2592000, @"MON-U6F3D-BEB2J": @2592000,
            @"MON-UXOU6-045TY": @2592000,
            
            // 季卡 90天 (10个)
            @"QTR-3728L-TNOX2": @7776000, @"QTR-3I2T2-YL6VS": @7776000, @"QTR-ETQYR-7D2QL": @7776000,
            @"QTR-EY4WB-BNF9H": @7776000, @"QTR-IJ64G-9T7BG": @7776000, @"QTR-LQBQ4-NO0E9": @7776000,
            @"QTR-M1Y5Y-5Q85P": @7776000, @"QTR-S7N2O-O5UDT": @7776000, @"QTR-TSXVQ-FV3A7": @7776000,
            @"QTR-XKAWH-Z7DUB": @7776000
        };
    }
    return codes;
}

// 检查是否处于有效期内
BOOL isAuthorized() {
    if (isAuthorizedFlag) return YES;
    
    NSTimeInterval expireTime = [[NSUserDefaults standardUserDefaults] doubleForKey:@"GameAuth_ExpireTime"];
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    
    if (expireTime > 0 && currentTime < expireTime) {
        return YES;
    }
    return NO;
}

void loadRealCheatDylib() {
    if (hasLoadedCheat) return;

    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    // 【注意】这里已经替换为你要求的新名字
    NSString *dylibPath = [bundlePath stringByAppendingPathComponent:@"libgenesysadam.dylib"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) {
        NSLog(@"[AuthPlugin] 核心文件不存在: %@", dylibPath);
        return;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        void *handle = dlopen([dylibPath UTF8String], RTLD_LAZY);
        
        if (handle) {
            hasLoadedCheat = YES;
            NSLog(@"[AuthPlugin] 外挂加载成功，正在唤醒 UI...");
            
            // 伪造游戏启动和活跃通知，强制唤醒外挂内部的 UI 初始化代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidFinishLaunchingNotification object:[UIApplication sharedApplication]];
                [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication]];
                [[NSNotificationCenter defaultCenter] postNotificationName:UIWindowDidBecomeVisibleNotification object:nil];
            });
        } else {
            NSLog(@"[AuthPlugin] 外挂加载失败: %s", dlerror());
        }
    });
}

UIViewController *getTopViewController() {
    UIViewController *rootVC = nil;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.rootViewController) {
            rootVC = window.rootViewController;
            break;
        }
    }
    if (!rootVC) return nil;
    while (rootVC.presentedViewController) {
        rootVC = rootVC.presentedViewController;
    }
    return rootVC;
}

void showMyAuthAlert() {
    UIViewController *rootVC = getTopViewController();
    if (!rootVC) return;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"授权验证"
                                                                   message:@"请输入激活码以使用辅助功能："
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"输入激活码";
        textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    }];
    
    UIAlertAction *activateAction = [UIAlertAction actionWithTitle:@"激活" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *inputCode = alert.textFields.firstObject.text;
        inputCode = [inputCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSDictionary *validCodes = getValidCodesWithTime();
        NSNumber *durationNumber = validCodes[inputCode];
        
        if (durationNumber) {
            // 验证成功，计算过期时间戳
            NSTimeInterval duration = [durationNumber doubleValue];
            NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
            NSTimeInterval expireTime = currentTime + duration;
            
            // 保存过期时间到本地
            [[NSUserDefaults standardUserDefaults] setDouble:expireTime forKey:@"GameAuth_ExpireTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            isAuthorizedFlag = YES;
            
            // 关闭验证框并静默加载
            [alert dismissViewControllerAnimated:YES completion:^{
                loadRealCheatDylib();
            }];
            
        } else {
            UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"激活码错误" message:@"激活码不正确或不存在。" preferredStyle:UIAlertControllerStyleAlert];
            [errorAlert addAction:[UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 350000000), dispatch_get_main_queue(), ^{
                    showMyAuthAlert();
                });
            }]];
            [errorAlert addAction:[UIAlertAction actionWithTitle:@"不使用辅助" style:UIAlertActionStyleCancel handler:nil]];
            [rootVC presentViewController:errorAlert animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不使用辅助" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:activateAction];
    [alert addAction:cancelAction];
    [rootVC presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor))
static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1000000000), dispatch_get_main_queue(), ^{
        if (isAuthorized()) {
            // 有效期内，直接静默加载
            loadRealCheatDylib();
        } else if (!hasShownMyAlert) {
            // 过期或未激活，弹出验证框
            hasShownMyAlert = YES;
            showMyAuthAlert();
        }
    });
}
