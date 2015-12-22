//
//  LPLineChartViewLayout.m
//  LPLineChartViewDemo
//
//  Created by XuYafei on 15/10/25.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "LPLineChartViewLayout.h"

@implementation LPLineChartViewLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareLayout];
    }
    return self;
}

- (void)prepareLayout {
    
}

- (UIColor *)colorForAxis:(LPAxis)axis {
    return [UIColor clearColor];
}

- (CGFloat)widthForAxis:(LPAxis)axis {
    return 0;
}

- (CAShapeLayer *)arrowForAxis:(LPAxis)axis {
    return [CAShapeLayer layer];
}

- (CAShapeLayer *)pointForAxis:(LPAxis)axis withCount:(NSInteger)count {
    return [CAShapeLayer layer];
}

- (CATextLayer *)textForAxis:(LPAxis)axis {
    return [CATextLayer layer];
}

- (CGFloat)endSpaceForAxis:(LPAxis)axis {
    return 0;
}

- (UIEdgeInsets)edgeForChart {
    return UIEdgeInsetsZero;
}

- (UIColor *)colorForChart:(NSInteger)count {
    return [UIColor clearColor];
}

- (CGFloat)widthForChart:(NSInteger)count {
    return 0;
}

- (CAShapeLayer *)pointForChart:(NSInteger)count {
    return [CAShapeLayer layer];
}

- (CAGradientLayer *)GradientLayerForBackground {
    return [CAGradientLayer layer];
}

- (CAShapeLayer *)refrenceForBackground:(LPAxis)axis withCount:(NSInteger)count {
    return [CAShapeLayer layer];
}

#pragma mark - Private

+ (CGFloat)textWidthWithString:(NSString *)string font:(UIFont *)font {
    CGSize maxsize = CGSizeMake(80, font.pointSize);
    CGSize size = [string.description boundingRectWithSize:maxsize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width;
}

@end
