//
//  LPLineChartViewCustomLayout.m
//  LPLineChartViewDemo
//
//  Created by XuYafei on 15/10/25.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "LPLineChartViewCustomLayout.h"

@implementation LPLineChartViewCustomLayout

- (void)prepareLayout {
    _topBackgroundColor = [UIColor orangeColor];
    _bottomBackgroundColor = [UIColor yellowColor];
    _xRefrenceLineColor = [UIColor lightGrayColor];
    _xRefrenceLineWidth = 0.5;
    _xRefrenceLineDashPattern = @[@1];
    _yRefrenceLineColor = [UIColor lightGrayColor];
    _yRefrenceLineWidth = 0.5;
    _yRefrenceLineDashPattern = @[@1];
    
    _chartEdge = UIEdgeInsetsMake(10, 40, 30, 10);
    _chartLineColor = [UIColor greenColor];
    _chartLineWidth = 1;
    _chartPointColor = [UIColor redColor];
    _chartPointRadius = 1;
    
    _xTextColor = [UIColor grayColor];
    _yTextColor = [UIColor grayColor];
    _xTextFont = [UIFont systemFontOfSize:12];
    _yTextFont = [UIFont systemFontOfSize:12];
    _xTextTransform = CATransform3DMakeRotation(0, 0, 0, 1);
    
    _indicatorRadius = 3;
    _indicatorWidth = 1;
    _indicatorColor = [UIColor greenColor];
    
    _axisEndSpace = 20;
    _axisWidth = 1;
    _axisColor = [UIColor greenColor];
    _axisPointRadius = 1;
    _axisPointColor = [UIColor cyanColor];
}

- (UIColor *)colorForAxis:(LPAxis)axis {
    return _axisColor;
}

- (CGFloat)widthForAxis:(LPAxis)axis {
    return _axisWidth;
}

- (CAShapeLayer *)arrowForAxis:(LPAxis)axis {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    if (axis == LPAxisX) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(_indicatorRadius, _indicatorRadius)];
        [path addLineToPoint:CGPointMake(0, _indicatorRadius * 2)];
    } else if (axis == LPAxisY) {
        [path moveToPoint:CGPointMake(0, _indicatorRadius)];
        [path addLineToPoint:CGPointMake(_indicatorRadius, 0)];
        [path addLineToPoint:CGPointMake(_indicatorRadius * 2, _indicatorRadius)];
    }
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = _indicatorWidth;
    layer.strokeColor = _indicatorColor.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    return layer;
}

- (CAShapeLayer *)pointForAxis:(LPAxis)axis withCount:(NSInteger)count {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointZero radius:_axisPointRadius startAngle:0 endAngle:2 * M_PI clockwise:NO];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = _axisPointColor.CGColor;
    layer.path = path.CGPath;
    
    return layer;
}

- (CATextLayer *)textForAxis:(LPAxis)axis {
    
    CATextLayer *layer = [CATextLayer layer];
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    if (axis == LPAxisX) {
        layer.fontSize = _xTextFont.pointSize;
        layer.foregroundColor = _xTextColor.CGColor;
        layer.transform = _xTextTransform;
        layer.alignmentMode = kCAAlignmentCenter;
    } else if (axis == LPAxisY) {
        layer.fontSize = _yTextFont.pointSize;
        layer.foregroundColor = _yTextColor.CGColor;
        layer.alignmentMode = kCAAlignmentRight;
    }
    
    return layer;
}

- (CGFloat)endSpaceForAxis:(LPAxis)axis {
    return _axisEndSpace;
}

- (UIEdgeInsets)edgeForChart {
    return _chartEdge;
}

- (UIColor *)colorForChart:(NSInteger)count {
    return _chartLineColor;
}

- (CGFloat)widthForChart:(NSInteger)count {
    return _chartLineWidth;
}

- (CAShapeLayer *)pointForChart:(NSInteger)count {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointZero radius:_chartPointRadius startAngle:0 endAngle:2 * M_PI clockwise:NO];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = _chartPointColor.CGColor;
    layer.path = path.CGPath;

    return layer;
}

- (CAGradientLayer *)GradientLayerForBackground {
    
    CAGradientLayer *layer =  [CAGradientLayer layer];
    [layer setColors:@[(__bridge id)_topBackgroundColor.CGColor, (__bridge id)_bottomBackgroundColor.CGColor]];
    [layer setStartPoint:CGPointMake(0.5, 0)];
    [layer setEndPoint:CGPointMake(0.5, 1)];
    
    return layer;
}

- (CAShapeLayer *)refrenceForBackground:(LPAxis)axis withCount:(NSInteger)count {
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapButt;
    path.lineJoinStyle = kCGLineJoinMiter;
    [path moveToPoint:CGPointMake(0, 0)];
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
    if (axis == LPAxisX) {
        layer.lineWidth = _xRefrenceLineWidth;
        layer.strokeColor = _xRefrenceLineColor.CGColor;
        layer.lineDashPattern = _xRefrenceLineDashPattern;
        [path addLineToPoint:CGPointMake(0, size.height)];
    } else if (axis == LPAxisY) {
        layer.lineWidth = _yRefrenceLineWidth;
        layer.strokeColor = _yRefrenceLineColor.CGColor;
        layer.lineDashPattern = _yRefrenceLineDashPattern;
        [path addLineToPoint:CGPointMake(size.width, 0)];
    }
    
    layer.path = path.CGPath;
    return layer;
}

@end
