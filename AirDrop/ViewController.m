//
//  ViewController.m
//  AirDrop
//
//  Created by laiyp on 2017/11/17.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong)  UIDocumentInteractionController *document;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    开启airDrop功能
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 80)];
    [button setBackgroundColor:[UIColor grayColor]];
    [button addTarget:self action:@selector(AirDropClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    

    
}

-(void)AirDropClick:(UIButton *)sender{

//    拿到数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"animal.txt" ofType:@""];
//    把zip达成成功之后具体放入那个文件
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingString:@"YPAnimal"];
    NSString *outTempP = [tempPath stringByAppendingString:@".zip"];
//    打包成zip
    [SSZipArchive createZipFileAtPath:outTempP withFilesAtPaths:@[path]];
    
//    分享数据
    UIDocumentInteractionController *document = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:outTempP]];
//    document.delegate = self;
    self.document = document;
    [document presentOptionsMenuFromRect:sender.frame inView:self.view animated:YES];
}

//-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
//    
//    return self;
//}

@end
