//
//  ViewController.m
//  ClickTextViewDemo
//
//  Created by 崔冰 on 2017/9/25.
//  Copyright © 2017年 崔冰. All rights reserved.
//

#import "ViewController.h"
#import "CClickTextView.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()
@property (strong, nonatomic) CClickTextView *clickView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createView];
}

- (void)createView
{
    self.clickView = [[CClickTextView alloc] initWithFrame:CGRectMake(20, 70, SCREEN_WIDTH-40, 100)];
    self.clickView.editable = NO;
    [self.view addSubview:self.clickView];
    
    NSString *strText = @"我已阅读并接受锂电池危险品须知，东上航运输总条件和东上航统一运营的温馨提示以及关于乌拉拉的公告";
    NSString *clickText1 = @"锂电池危险品须知";
    NSString *clickText2 = @"东上航运输总条件";
    NSString *clickText3 = @"东上航统一运营的温馨提示";
    NSString *clickText4 = @"关于乌拉拉的公告";
    self.clickView.text = strText;
    self.clickView.wholeTextFont = [UIFont systemFontOfSize:14];
    
    [self.clickView setClickText:clickText1 ClickTextColor:[UIColor redColor] ClickBlock:^(NSString *strClickText) {
        NSLog(@"clickText1");
    }];
    [self.clickView setClickText:clickText2 ClickTextColor:[UIColor redColor] ClickBlock:^(NSString *strClickText) {
        NSLog(@"clickText2");
    }];
    [self.clickView setClickText:clickText3 ClickTextColor:[UIColor redColor] ClickBlock:^(NSString *strClickText) {
        NSLog(@"clickText3");
    }];
    [self.clickView setClickText:clickText4 ClickTextColor:[UIColor redColor] ClickBlock:^(NSString *strClickText) {
        NSLog(@"clickText4");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
