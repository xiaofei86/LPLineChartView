# LPLineChartView
参照UICollectionview的架构实现的折线图LPLineChartView。将布局交给Layout实现，通过Layer进行绘制。提供“虚基类”LPLineChartViewLayout，定义需要的空方法。在LPLineChartView里用强指针指针指向LPLineChartViewLayout的实例。

在这种设计模式下，UICollectionview基本所有与UI相关的部件全都通过Layout去获取对应的Layer。这样的好处类似于UICollectionview，基本可是实现任何想要的布局。比如：轴线、箭头、数据点、连接线、参考线、轴线文字、背景等都是通过Layout去获取对应的Layer。这样用户就可以充分开发脑洞去绘制任何想要的效果。（任何形状，贝塞尔曲线，渐变，字体，甚至图片，遮罩都是可以的）当然，这种模式下，必然导致使用的难度极度增加。所以就必须实现一个默认实现LPLineChartViewCustomLayout。（类似UICollectionview的UICollectionviewFlowLayout）

LPLineChartViewCustomLayout继承自LPLineChartViewLayout，实现了所有需要定制的内容。然后在头文件中提供参数去设置布局过程中的一些主要样式。通过这些参数基本可以实现大部分对折线图的个性化定制。在使用的时候通过子类化LPLineChartViewCustomLayout，在prepareLayout方法中重新设置这些参数的部分，被设置的部分就会覆盖LPLineChartViewCustomLayout的默认值。
如果个别地方实在不能满足需求，也可以通过在子类中重新实现部分相关的方法去通过Layer自由定制。

这样就提供了既简单又可高度定制的折线图。下边我自己实现了几种效果，这些效果均在10行代码以内实现。如下。(右上角样式为LPLineChartViewCustomLayout)

![](https://github.com/xiaofei86/LPLineChartView/raw/master/Images/chart4.png)

#LPLineChartViewLayout

LPLineChartViewLayout可供设置的方法，如下。

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


#LPLineChartViewCustomLayout

LPLineChartViewCustomLayout可供设置的属性，如下。

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
	
#DataSource

数据源采用数组赋值的方式传入。

data：数据源

yRange：Y轴坐标范围

ySpace：Y参考线/点/文字间隔

yKey：通过yKey在数组中拿到每个点的Y坐标值

xRankKey：通过xRankKey对X轴的数据进行排序

xKey：通过yKey在数组中拿到每个点需要显示的文字

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