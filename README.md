# LPLineChartView

[![LICENSE](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/xiaofei86/LPLineChartView/master/LICENSE)&nbsp;
[![PLATFORM](https://img.shields.io/cocoapods/p/LPNetworking.svg?style=flat)](https://developer.apple.com/library/ios/navigation/)&nbsp;
[![SUPPORT](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://en.wikipedia.org/wiki/IOS_7)&nbsp;

类似UICollectionview使用方式的折线图LPLineChartView。将布局交给Layout实现，通过Layer进行绘制。提供“虚基类”LPLineChartViewLayout定义需要的空方法。在LPLineChartView里用指针指向LPLineChartViewLayout的实例。

基本所有与UI相关的部件（轴线、箭头、数据点、连接线、参考线、轴线文字、背景）全都通过Layout去获取对应的Layer，基本可是实现任何想要的布局。这样你就可以去绘制任何想要的效果（形状，贝塞尔曲线，渐变，字体，图片，遮罩）。框架提供一个默认实现LPLineChartViewCustomLayout作为默认实现。LPLineChartViewCustomLayout继承自LPLineChartViewLayout，实现了所有需要定制的内容。然后在头文件中提供参数去调整布局过程中的主要样式。通过这些参数基本可以实现大部分对折线图的个性化定制。

在使用的时候通过子类化LPLineChartViewCustomLayout，在prepareLayout方法中重新设置这些参数或者部分，被设置的部分就会覆盖LPLineChartViewCustomLayout的默认值。
如果个别地方实在不能满足需求，也可以通过在子类中重新实现部分相关的方法去通过Layer自由定制。

通过两种方案的结合就提供了使用既简单又可高度定制的折线图。下边实现了几种展示效果，这些效果均在10行代码以内实现。如下。(右上角样式为LPLineChartViewCustomLayout)

![](https://github.com/xiaofei86/LPLineChartView/raw/master/Images/chart4.png)

<img src = "https://github.com/xiaofei86/LPLineChartView/raw/master/Images/1.png" width = 373>

# Usage

#### LPLineChartViewLayout

LPLineChartViewLayout可供设置的方法。

```objective-c
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

- (CAGradientLayer *)GradientLayerForBackground;
- (CAShapeLayer *)refrenceForBackground:(LPAxis)axis withCount:(NSInteger)count;

+ (CGFloat)textWidthWithString:(NSString *)string font:(UIFont *)font;
```

#### LPLineChartViewCustomLayout

LPLineChartViewCustomLayout可供设置的属性。

```objective-c
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
```
	
#### DataSource

数据源采用数组注入的方式。

data：数据源

yRange：Y轴坐标范围

ySpace：Y参考线/点/文字间隔

yKey：通过yKey在数组中拿到每个点的Y坐标值

xRankKey：通过xRankKey对X轴的数据进行排序

xKey：通过yKey在数组中拿到每个点需要显示的文字

xData：x轴自定义数据

xMinCount：x轴显示个数下限

xMaxCount：x轴显示个数上限

```objective-c
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
```
	
# More

* 如果数据源中某个点的值为null，那么图表将会跳过该点直接于下一个点相连。如果为null的点在数据源头或尾，那么头或尾将会空去一部分。

* 如果某个数据点对应的x轴文字为null，那么对应的x轴将不会显示，但是数据点可以正常显示。

* 图片可以设置数据点个数的上限和下限。设置下限后，如果数据点个数不足，图表的后边将会用数据点补足。设置上限后，超过上限后将会智能隐藏一部分x轴文字同时保证x轴每个点间距相等。具体的算法于number相似，有兴趣可以通过demo探求。

* 如果x轴数据是固定的，不需要和数据点对应，可以通过xData数组来设置固定值。

![](https://github.com/xiaofei86/LPLineChartView/raw/master/Images/chart4_test.png)
