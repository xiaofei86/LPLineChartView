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
    LPLineChartView *lineChartView = [[LPLineChartView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height / 3)];
    lineChartView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    lineChartView.data = @[@{@"id": @"1", @"name":@"1", @"grade":@""},
                           @{@"id": @"2", @"name":@"2", @"grade":@"40"},
                           @{@"id": @"3", @"name":@"", @"grade":[NSNull null]},
                           @{@"id": @"4", @"name":@"4", @"grade":@"76"},
                           @{@"id": @"5", @"name":@"5", @"grade":@"79"},
                           @{@"id": @"6", @"name":@"6", @"grade":@"90"},
                           @{@"id": @"7", @"name":@"7", @"grade":@"86"},
                           @{@"id": @"8", @"name":@"8", @"grade":@"71"},
                           @{@"id": @"9", @"name":@"9", @"grade":@""},
                           @{@"id": @"10", @"name":@"10", @"grade":@""}];
    lineChartView.yRange = NSMakeRange(0, 100);
    lineChartView.ySpace = 20;
    lineChartView.xRankKey = @"id";
    lineChartView.yKey = @"grade";
    lineChartView.xKey = @"name";
    lineChartView.xData = @[@"123", @"456", @"789", @"10"];
    
    lineChartView.layout = [[LPLineChartViewCustomLayout alloc] init];
    [self.view addSubview:lineChartView];
}

@end
