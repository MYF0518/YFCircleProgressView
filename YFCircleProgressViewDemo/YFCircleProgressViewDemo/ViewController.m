//
//  ViewController.m
//  YFCircleProgressViewDemo
//
//  Created by meorient on 2018/12/4.
//  Copyright © 2018 MYF. All rights reserved.
//

#import "ViewController.h"
#import "YFCircleProgressView.h"
#define  UIColorFromRGB(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ViewController ()
{
    YFCircleProgressView *_progressView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressView = [[YFCircleProgressView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    _progressView.shadowColors = [NSMutableArray arrayWithObjects:(id)UIColorFromRGB(0x00E8B4).CGColor,(id)UIColorFromRGB(0x3B95FF).CGColor, nil];
    _progressView.progressWidth = 15;
    _progressView.font = [UIFont boldSystemFontOfSize:36];
    _progressView.residueColor = UIColorFromRGB(0xEBF2F5);
    [self.view addSubview:_progressView];
    _progressView.progress = 82;
}


@end
