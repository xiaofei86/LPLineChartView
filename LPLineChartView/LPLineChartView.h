//
//  LPLineChartView.h
//  LPLineChartViewDemo
//
//  Created by XuYafei on 15/10/25.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPLineChartViewLayout.h"

@interface LPLineChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       layout:(LPLineChartViewLayout *)layout
                         data:(NSArray *)data
                       yRange:(NSRange)yRange
                       ySpace:(CGFloat)ySpace
                         yKey:(NSString *)yKey
                         xKey:(NSString *)xKey;

- (void)reloadViews;

@property (nonatomic, strong) LPLineChartViewLayout *layout;

#pragma mark - DataSource

@property (nonatomic, strong) NSArray<NSDictionary *> *data;
@property (nonatomic, copy) NSString *xKey;
@property (nonatomic, copy) NSString *yKey;

@property (nonatomic, assign) NSRange yRange;
@property (nonatomic, assign) CGFloat ySpace;

@property (nonatomic, copy) NSString *xRankKey;
@property (nonatomic, strong) NSArray<NSString *> *xData;

@property (nonatomic, assign) NSInteger xMaxCount;

@end
