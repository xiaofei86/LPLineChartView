//
//  LPLineChartViewCustomLayout.h
//  LPLineChartViewDemo
//
//  Created by XuYafei on 15/10/25.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "LPLineChartViewLayout.h"

@interface LPLineChartViewCustomLayout : LPLineChartViewLayout

//背景
@property (nonatomic, strong) UIColor *topBackgroundColor;
@property (nonatomic, strong) UIColor *bottomBackgroundColor;
@property (nonatomic, strong) UIColor *xRefrenceLineColor;
@property (nonatomic, assign) CGFloat xRefrenceLineWidth;
@property (nonatomic, strong) NSArray<NSNumber *> *xRefrenceLineDashPattern;
@property (nonatomic, strong) UIColor *yRefrenceLineColor;
@property (nonatomic, assign) CGFloat yRefrenceLineWidth;
@property (nonatomic, strong) NSArray<NSNumber *> *yRefrenceLineDashPattern;

//图表
@property (nonatomic, assign) UIEdgeInsets chartEdge;
@property (nonatomic, strong) UIColor *chartLineColor;
@property (nonatomic, assign) CGFloat chartLineWidth;
@property (nonatomic, strong) UIColor *chartPointColor;
@property (nonatomic, assign) CGFloat chartPointRadius;

//文字
@property (nonatomic, strong) UIColor *xTextColor;
@property (nonatomic, strong) UIColor *yTextColor;
@property (nonatomic, strong) UIFont *xTextFont;
@property (nonatomic, strong) UIFont *yTextFont;
@property (nonatomic, assign) CATransform3D xTextTransform;

//箭头
@property (nonatomic, assign) CGFloat indicatorRadius;
@property (nonatomic, assign) CGFloat indicatorWidth;
@property (nonatomic, strong) UIColor *indicatorColor;

//轴线
@property (nonatomic, assign) CGFloat axisEndSpace;
@property (nonatomic, assign) CGFloat axisWidth;
@property (nonatomic, strong) UIColor *axisColor;
@property (nonatomic, assign) CGFloat axisPointRadius;
@property (nonatomic, strong) UIColor *axisPointColor;

@end
