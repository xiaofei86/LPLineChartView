//
//  LPLineChartView.m
//  LPLineChartViewDemo
//
//  Created by XuYafei on 15/10/25.
//  Copyright © 2015年 loopeer. All rights reserved.
//

//CGPathRef path = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapRound, kCGLineJoinRound, layer.miterLimit);

#import "LPLineChartView.h"
#import "math.h"

static CGFloat textInterval = 8;

@implementation LPLineChartView {
    CGRect _chartFrame;
    UIEdgeInsets _axisEdge;
    UIEdgeInsets _chartEdge;
    
    NSInteger _countX;
    NSInteger _countY;
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _data = @[@{@"id": @"1", @"name":@"1", @"grade":@"30"},
                 @{@"id": @"2", @"name":@"2", @"grade":@"40"},
                 @{@"id": @"3", @"name":@"3", @"grade":@"62"},
                 @{@"id": @"4", @"name":@"4", @"grade":@"76"},
                 @{@"id": @"5", @"name":@"5", @"grade":@"79"},
                 @{@"id": @"6", @"name":@"6", @"grade":@"90"},
                 @{@"id": @"7", @"name":@"7", @"grade":@"86"},
                 @{@"id": @"8", @"name":@"8", @"grade":@"71"},
                 @{@"id": @"9", @"name":@"9", @"grade":@"100"},
                 @{@"id": @"10", @"name":@"10", @"grade":@"87"}];
        _yRange = NSMakeRange(0, 100);
        _ySpace = 20;
        _yKey = @"grade";
        _xRankKey = @"id";
        _xKey = @"name";
        
        _countX = _data.count;
        _countY = ceilf(_yRange.length / _ySpace) + 1;
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                       layout:(LPLineChartViewLayout *)layout
                         data:(NSArray *)data
                       yRange:(NSRange)yRange
                       ySpace:(CGFloat)ySpace
                         yKey:(NSString *)yKey
                     xRankKey:(NSString *)xRankKey
                         xKey:(NSString *)xKey {
    self = [super initWithFrame:frame];
    if (self) {
        _data = data;
        _yRange = yRange;
        _ySpace = ySpace;
        _yKey = yKey;
        _xRankKey = xRankKey;
        _xKey = xKey;
        
        _countX = _data.count;
        _countY = ceilf(_yRange.length / _ySpace) + 1;
        
        _layout = layout;
    }
    return self;
}

#pragma mark - Accessor

- (void)setLayout:(LPLineChartViewLayout *)layout {
    
    _layout = layout;
    
    _axisEdge.right = [_layout endSpaceForAxis:LPAxisY];
    _axisEdge.top = [_layout endSpaceForAxis:LPAxisX];
    _chartEdge = [_layout edgeForChart];
    
    _chartFrame.origin.x = _chartEdge.left;
    _chartFrame.origin.y = self.bounds.size.height - _chartEdge.bottom;
    _chartFrame.size.width = self.bounds.size.width - _chartEdge.left - _chartEdge.right;
    _chartFrame.size.height = self.bounds.size.height - _chartEdge.top - _chartEdge.bottom;
    
    [self.layer addSublayer:[self creatBackground]];
    [self.layer addSublayer:[self creatAxis:LPAxisX]];
    [self.layer addSublayer:[self creatAxis:LPAxisY]];
    [self.layer addSublayer:[self creatChart]];
}

- (void)setData:(NSArray *)data {
    _data = data;
    _countX = _data.count;
}

- (void)setYRange:(NSRange)yRange {
    _yRange = yRange;
    if (_yRange.length && _ySpace) {
        _countY = ceilf(_yRange.length / _ySpace) + 1;
    }
}

- (void)setYSpace:(CGFloat)ySpace {
    _ySpace = ySpace;
    if (_yRange.length && _ySpace) {
        _countY = ceilf(_yRange.length / _ySpace) + 1;
    }
}

#pragma mark - creatBackground

- (CALayer *)creatBackground {
    CALayer *layer = [CALayer layer];
    [layer addSublayer:[self creatRefrence:LPAxisX]];
    [layer addSublayer:[self creatRefrence:LPAxisY]];
    [layer addSublayer:[self creatGradient]];
    return layer;
}

- (CALayer *)creatGradient {
    
    float intervalX = _countX == 1? 0: (_chartFrame.size.width - _axisEdge.right) / (_countX - 1);
    float unitY = (_chartFrame.size.height - _axisEdge.top) / _yRange.length;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    for (int i = 0; i < _countX; i++) {
        float x = i * intervalX;
        float y = [[_data[i] objectForKey:_yKey] floatValue] * unitY;
        CGPoint point = CGPointMake(_chartFrame.origin.x + x, _chartFrame.origin.y - y);
        if (i == 0) {
            [path moveToPoint:point];
        } else if (i == _countX - 1) {
            [path addLineToPoint:point];
            [path addLineToPoint:CGPointMake(point.x, _chartFrame.origin.y)];
            [path addLineToPoint:CGPointMake(_chartFrame.origin.x, _chartFrame.origin.y)];
        } else {
            [path addLineToPoint:point];
        }
    }
    [path closePath];
    layer.frame = self.bounds;
    layer.lineWidth = CGFLOAT_MIN;
    layer.strokeColor = [UIColor clearColor].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.path = path.CGPath;
    
    CAGradientLayer *bgLayer = [_layout GradientLayerForBackground];
    bgLayer.bounds = CGRectMake(_chartFrame.origin.x, _chartEdge.top + _axisEdge.top, 0, 0);
    bgLayer.frame = CGRectMake(_chartFrame.origin.x, _chartEdge.top + _axisEdge.top, _chartFrame.size.width - _axisEdge.right, _chartFrame.size.height - _axisEdge.top);
    bgLayer.mask = layer;
    
    return bgLayer;
}

- (CALayer *)creatRefrence:(LPAxis)axis {
    
    CAShapeLayer *rootLayer = [CAShapeLayer layer];
    
    if (axis == LPAxisX) {
        float interval = _countX == 1? 0: (_chartFrame.size.width - _axisEdge.right) / (_countX - 1);
        
        for (int i = 0; i < _countX; i++) {
            CAShapeLayer *layer = [_layout refrenceForBackground:LPAxisX withCount:i];
            layer.bounds = CGPathGetBoundingBox(layer.path);
            layer.strokeStart = (layer.bounds.size.height - _chartFrame.size.height + _axisEdge.top) / layer.bounds.size.height;
            layer.position = CGPointMake(_chartFrame.origin.x + i * interval, _chartFrame.origin.y - layer.bounds.size.height / 2);
            [rootLayer addSublayer:layer];
        }
    } else if (axis == LPAxisY) {
        float interval = _countY == 1? 0: (_chartFrame.size.height - _axisEdge.top) / (_countY - 1);
        
        for (int i = 0; i < _countY; i++) {
            CAShapeLayer *layer = [_layout refrenceForBackground:LPAxisY withCount:i];
            layer.bounds = CGPathGetBoundingBox(layer.path);
            layer.strokeEnd = (_chartFrame.size.width - _axisEdge.right) / layer.bounds.size.width;
            layer.position = CGPointMake(_chartFrame.origin.x + layer.bounds.size.width/ 2, _chartFrame.origin.y - i * interval);
            [rootLayer addSublayer:layer];
        }
    }
    
    return rootLayer;
}

#pragma mark - creatAxis

- (CALayer *)creatAxis:(LPAxis)axis {
    CALayer *layer = [CALayer layer];
    [layer addSublayer:[self creatLines:axis]];
    [layer addSublayer:[self creatArrows:axis]];
    if (_countX >= 1.0 && _countY >= 1.0) {
        [layer addSublayer:[self creatPoints:axis]];
        [layer addSublayer:[self creatTexts:axis]];
    }
    return layer;
}

- (CALayer *)creatLines:(LPAxis)axis {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = [_layout widthForAxis:axis];
    layer.strokeColor = [_layout colorForAxis:axis].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path moveToPoint:CGPointMake(0, 0)];
    
    if (axis == LPAxisX) {
        [path addLineToPoint:CGPointMake(_chartFrame.size.width, 0)];
        layer.position = CGPointMake(_chartFrame.origin.x + _chartFrame.size.width / 2, _chartFrame.origin.y);
    } else if (axis == LPAxisY) {
        [path addLineToPoint:CGPointMake(0, _chartFrame.size.height)];
        layer.position = CGPointMake(_chartFrame.origin.x, _chartFrame.origin.y - _chartFrame.size.height / 2);
    }
    
    layer.path = path.CGPath;
    layer.bounds = CGPathGetPathBoundingBox(layer.path);
    return layer;
}

- (CALayer *)creatArrows:(LPAxis)axis {
    
    CAShapeLayer *layer = [_layout arrowForAxis:axis];
    layer.bounds = CGPathGetPathBoundingBox(layer.path);
    
    if (axis == LPAxisX) {
        layer.position = CGPointMake(_chartFrame.origin.x + _chartFrame.size.width - layer.bounds.size.width / 2, _chartFrame.origin.y);
    } else if (axis == LPAxisY) {
        layer.position = CGPointMake(_chartFrame.origin.x, _chartFrame.origin.y - _chartFrame.size.height + layer.bounds.size.height / 2);
    }
    
    return layer;
}

- (CALayer *)creatPoints:(LPAxis)axis {
    
    CAShapeLayer *rootLayer = [CAShapeLayer layer];
    
    if (axis == LPAxisX) {
        float interval = _countX == 1? 0: (_chartFrame.size.width - _axisEdge.right) / (_countX - 1);
        
        for (int i = 0; i < _countX; i++) {
            CAShapeLayer *layer = [_layout pointForAxis:LPAxisX withCount:i];
            layer.bounds = CGPathGetBoundingBox(layer.path);
            layer.position = CGPointMake(_chartFrame.origin.x + i * interval, _chartFrame.origin.y);
            [rootLayer addSublayer:layer];
        }
    } else if (axis == LPAxisY) {
        float interval = _countY == 1? 0: (_chartFrame.size.height - _axisEdge.top) / (_countY - 1);
        
        for (int i = 0; i < _countY; i++) {
            CAShapeLayer *layer = [_layout pointForAxis:LPAxisY withCount:i];
            layer.bounds = CGPathGetBoundingBox(layer.path);
            layer.position = CGPointMake(_chartFrame.origin.x, _chartFrame.origin.y - i * interval);
            [rootLayer addSublayer:layer];
        }
    }
    
    return rootLayer;
}

- (CALayer *)creatTexts:(LPAxis)axis {
    CAShapeLayer *rootLayer = [CAShapeLayer layer];
    
    if (axis == LPAxisX) {
        float interval = _countX == 1? 0: (_chartFrame.size.width - _axisEdge.right) / (_countX - 1);
        
        for (int i = 0; i < _countX; i++) {
            CATextLayer *layer = [_layout textForAxis:LPAxisX];
            layer.string = [_data[i] objectForKey:_xKey];
            CGFloat textWidth = [LPLineChartViewLayout textWidthWithString:layer.string font:layer.font];
            layer.bounds = CGRectMake(0, 0, textWidth, layer.fontSize + 2);
            layer.position = CGPointMake(_chartFrame.origin.x + i * interval,
                                         _chartFrame.origin.y
                                         + layer.fontSize / 2
                                         + textInterval);
            [rootLayer addSublayer:layer];
        }

    } else if (axis == LPAxisY) {
        float interval = _countY == 1? 0: (_chartFrame.size.height - _axisEdge.top) / (_countY - 1);
        
        for (int i = 0; i < _countY; i++) {
            CATextLayer *layer = [_layout textForAxis:LPAxisY];
            layer.string = [NSString stringWithFormat:@"%.0f", i * _ySpace];
            CGFloat textWidth = [LPLineChartViewLayout textWidthWithString:layer.string font:layer.font];
            layer.bounds = CGRectMake(0, 0, textWidth, layer.fontSize + 2);
            layer.position = CGPointMake(_chartFrame.origin.x
                                         - textWidth / 2
                                         - textInterval,
                                         _chartFrame.origin.y - i * interval);
            [rootLayer addSublayer:layer];
        }
    }
    
    return rootLayer;
}

#pragma mark - creatChart

- (CALayer *)creatChart {
    CALayer *layer = [CALayer layer];
    [layer addSublayer:[self creatLines]];
    [layer addSublayer:[self creatPoints]];
    return layer;
}

- (CALayer *)creatLines {
    float intervalX = _countX == 1? 0: (_chartFrame.size.width - _axisEdge.right) / (_countX - 1);
    float unitY = (_chartFrame.size.height - _axisEdge.top) / _yRange.length;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    for (int i = 0; i < _countX; i++) {
        float x = i * intervalX;
        float y = [[_data[i] objectForKey:_yKey] floatValue] * unitY;
        CGPoint point = CGPointMake(_chartFrame.origin.x + x, _chartFrame.origin.y - y);
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
    }
    layer.lineWidth = [_layout widthForChart:0];
    layer.strokeColor = [_layout colorForChart:0].CGColor;
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.path = path.CGPath;
    
    return layer;
}

- (CALayer *)creatPoints {
    CAShapeLayer *rootLayer = [[CAShapeLayer alloc] init];
    float intervalX = _countX == 1? 0: (_chartFrame.size.width - _axisEdge.right) / (_countX - 1);
    float unitY = (_chartFrame.size.height - _axisEdge.top) / _yRange.length;
    
    for (int i = 0; i < _countX; i++) {
        float x = i * intervalX;
        float y = [[_data[i] objectForKey:_yKey] floatValue] * unitY;
        
        CAShapeLayer *layer = [_layout pointForChart:i];
        layer.bounds = CGPathGetBoundingBox(layer.path);
        layer.position = CGPointMake(_chartFrame.origin.x + x, _chartFrame.origin.y - y);
        [rootLayer addSublayer:layer];
    }
    
    return rootLayer;
}

@end
