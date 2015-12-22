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

@implementation ViewController {
    LPLineChartView *_lineChartView;
    NSMutableArray *_data;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _data = [@[@{@"id": @"1", @"name":@"1", @"grade":@""},
                   @{@"id": @"2", @"name":@"2", @"grade":@"40"},
                   @{@"id": @"3", @"name":@"3", @"grade":NSNull.null},
                   @{@"id": @"4", @"name":@"4", @"grade":@"76"},
                   @{@"id": @"5", @"name":@"", @"grade":@"79"},
                   @{@"id": @"6", @"name":@"6", @"grade":@"90"},
                   @{@"id": @"7", @"name":@"7", @"grade":@"86"},
                   @{@"id": @"8", @"name":@"8", @"grade":@"71"},
                   @{@"id": @"9", @"name":@"9", @"grade":@""},
                   @{@"id": @"10", @"name":@"10", @"grade":@""}] mutableCopy];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"➕" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"➖" style:UIBarButtonItemStyleDone target:self action:@selector(minus)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    _lineChartView = [[LPLineChartView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height / 3)];
    _lineChartView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _lineChartView.data = _data;
    _lineChartView.yRange = NSMakeRange(0, 100);
    _lineChartView.ySpace = 20;
    _lineChartView.xRankKey = @"id";
    _lineChartView.yKey = @"grade";
    _lineChartView.xKey = @"name";
    //_lineChartView.xData = @[@"123", @"456", @"789", @"10"];
    
    _lineChartView.layout = [[LPLineChartViewCustomLayout alloc] init];
    [self.view addSubview:_lineChartView];
}

#pragma mark - Action

- (void)add {
    NSDictionary *dictionary;
    NSInteger arc = arc4random() % 102;
    if (arc == 101) {
        dictionary = @{@"id": @(_data.count + 1), @"name":@(_data.count + 1), @"grade":@""};
    } else {
        dictionary = @{@"id": @(_data.count + 1), @"name":@(_data.count + 1), @"grade":@(arc)};
    }
    [_data addObject:dictionary];
    _lineChartView.data = _data;
    [_lineChartView reloadViews];
}

- (void)minus {
    [_data removeLastObject];
    _lineChartView.data = _data;
    [_lineChartView reloadViews];
}

@end
