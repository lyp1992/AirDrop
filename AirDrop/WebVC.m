//
//  WebVC.m
//  AirDrop
//
//  Created by laiyp on 2017/11/17.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "WebVC.h"
#import "SSZipArchive.h"
#import <QuickLook/QuickLook.h>
@interface WebVC ()<SSZipArchiveDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>
@property (nonatomic, copy) NSString *cashMP;

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    取沙盒中的数据
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    这种方式拿不到文件，因为路径少一个/private
//    NSString *indoxPath = [path stringByAppendingPathComponent:@"Indox"];
//    NSString *filep = [indoxPath stringByAppendingPathComponent:self.filePath];
    
//    创建一个临时文件夹
    NSFileManager *maneger = [NSFileManager defaultManager];
    NSString *cashM = [path stringByAppendingPathComponent:@"cash"];
    if (![maneger fileExistsAtPath:cashM]) {
        [maneger createDirectoryAtPath:cashM withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([self.filePath hasSuffix:@".zip"]) {
        
        if ([SSZipArchive unzipFileAtPath:self.filePath toDestination:cashM delegate:self]) {
            NSLog(@"解压成功");
        }else{
            NSLog(@"解压失败");
        }
        NSArray *txtArr = [[NSFileManager defaultManager]subpathsOfDirectoryAtPath:cashM error:nil];
        NSString *cashMP= [cashM stringByAppendingPathComponent:txtArr[0]];
        self.cashMP = cashMP;
    }else{
    
        self.cashMP = self.filePath;
    }
 
    
    
//    UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    
//    NSData *data = [NSData dataWithContentsOfFile:cashMP];
//    
//    [webV loadData:data MIMEType:@"text/plain" textEncodingName:@"UTF-8" baseURL:nil];
//    webV.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:webV];
    
//    第二种方法
    
    QLPreviewController *previewer = [[QLPreviewController alloc]init];
    [previewer setDataSource:self];
    previewer.delegate = self;
    previewer.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    [self addChildViewController:previewer];
    [self.view addSubview:previewer.view];
//    [self.navigationController pushViewController:previewer animated:YES];
}

#pragma  mark --datasource

-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    return [NSURL fileURLWithPath:self.cashMP];
}
-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item{

    NSLog(@"进来了");
    return YES;
}

- (void)previewControllerWillDismiss:(QLPreviewController *)controller{

    NSLog(@"%s",__func__);
}

/*!
 * @abstract Invoked after the preview controller is closed.
 */
- (void)previewControllerDidDismiss:(QLPreviewController *)controller{
    NSLog(@"%s",__func__);
}

- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo {
    NSLog(@"将要解压。");
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPat uniqueId:(NSString *)uniqueId {
    NSLog(@"解压完成！");
}

@end
