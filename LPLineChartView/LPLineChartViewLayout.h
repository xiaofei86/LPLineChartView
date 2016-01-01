//
//  LPLineChartViewLayout.h
//  LPLineChartViewDemo
//
//  Created by XuYafei on 15/10/25.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LPAxis){
    LPAxisX = 0,
    LPAxisY = 1
};

@interface LPLineChartViewLayout : NSObject

- (void)prepareLayout;

- (UIColor *)colorForAxis:(LPAxis)axis;
- (CGFloat)widthForAxis:(LPAxis)axis;
- (CAShapeLayer *)arrowForAxis:(LPAxis)axis;
- (CAShapeLayer *)pointForAxis:(LPAxis)axis withCount:(NSInteger)count;
- (CGFloat)endSpaceForAxis:(LPAxis)axis;
- (CATextLayer *)textForAxis:(LPAxis)axis;

- (UIEdgeInsets)edgeForChart;
- (UIColor *)colorForChart:(NSInteger)count;
- (CGFloat)widthForChart:(NSInteger)count;
- (CAShapeLayer *)pointForChart:(NSInteger)count;

- (CAGradientLayer *)gradientLayerForBackground;
- (CAShapeLayer *)refrenceForBackground:(LPAxis)axis withCount:(NSInteger)count;

+ (CGFloat)textWidthWithString:(NSString *)string font:(UIFont *)font;

@end
