//
//  AppDelegate.m
//  AirDrop
//
//  Created by laiyp on 2017/11/17.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "AppDelegate.h"
#import "SSZipArchive.h"
#import "WebVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{

//    当收到airDrop的消息时
    [self openAirDropData:url];
    return YES;
    
}

-(void)openAirDropData:(NSURL *)url{

    NSLog(@"url===%@",url);
    NSString *urlStr = [url absoluteString];
//    接收到airDrop文件时，会自动存到document下。并且创建indox文件夹，接收到的文件都放到这里。
    
//    所以，我们要做的就是，把文件拿出来，然后展示。
    if ([urlStr hasPrefix:@"file://"]) {
        
            urlStr = [urlStr stringByReplacingOccurrencesOfString:@"file://" withString:@""];
//        NSArray *strArray = [urlStr componentsSeparatedByString:@"/"];
//        
//        NSString *fileName = strArray.lastObject;
//        
        
        WebVC *weC = [[WebVC alloc]init];
        weC.filePath = urlStr;
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:weC];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES
                                                                                   completion:nil];
        
        }
    
    
}
@end
