//
//  ViewController.m
//  LPLineChartViewDemo
//
//  Created by XuYafei on 15/10/25.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "ViewController.h"
#import "LPLineChartView.h"
#import "LPLineChartViewCustomLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    LPLineChartView *lineChartView = [[LPLineChartView alloc] initWithFrame:CGRectMake(20, 20, size.width - 40, 180)];
    lineChartView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lineChartView.layout = [[LPLineChartViewCustomLayout alloc] init];
    [self.view addSubview:lineChartView];
}

@end
