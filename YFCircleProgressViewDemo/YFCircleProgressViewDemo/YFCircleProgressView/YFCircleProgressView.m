//
//  YFCircleProgressView.m
//  Circle
//
//  Created by meorient on 2018/12/3.
//  Copyright © 2018 MYF. All rights reserved.
//

#import "YFCircleProgressView.h"
#import "UIViewAdditions.h"

@interface YFCircleProgressView ()
{
    /** 原点 */
    CGPoint _origin;
    /** 半径 */
    CGFloat _radius;
    /** 起始 */
    CGFloat _startAngle;
    /** 结束 */
    CGFloat _endAngle;
    
}

/** 进度显示 */
@property (nonatomic, strong) UILabel *progressLabel;
/** 进度显示 */
@property (nonatomic, strong) CALayer *colorsLayer;
/** 底层显示层 */
@property (nonatomic, strong) CAShapeLayer *coverLayer;

//放在coverLayer面，与背景色相同，防止coverLayer遮盖后的毛边距；
@property (nonatomic, strong) CAShapeLayer *coverBgLayer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/** 圆环遮罩 */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end
@implementation YFCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllView];
    }
    return self;
}
- (void)addAllView
{
    //底层渐变色layer
    [self.layer addSublayer:self.colorsLayer];
    //添加渐变色
    [self.colorsLayer addSublayer:self.gradientLayer];

    //直接加剩余进度颜色遮盖的话，会发现，底层的渐变色有毛边漏出来
    [self.layer addSublayer:self.coverBgLayer];
    //剩余进度颜色层
    [self.layer addSublayer:self.coverLayer];

    [self addSubview:self.progressLabel];
    
//    self.progressWidth = 5;
}
#pragma mark - 懒加载
- (CALayer *)colorsLayer
{
    if (!_colorsLayer) {
        _colorsLayer = [CALayer layer];
        _colorsLayer.frame = self.bounds;
    }
    return _colorsLayer;
}
- (CAShapeLayer *)coverLayer {
    if (!_coverLayer) {
        _coverLayer = [CAShapeLayer layer];
        _coverLayer.fillColor = [UIColor clearColor].CGColor;
        _coverLayer.frame = self.bounds;
    }
    return _coverLayer;
}
- (CAShapeLayer *)coverBgLayer {
    if (!_coverBgLayer) {
        _coverBgLayer = [CAShapeLayer layer];
        _coverBgLayer.fillColor = [UIColor clearColor].CGColor;
        _coverBgLayer.strokeColor = [UIColor whiteColor].CGColor;
        _coverBgLayer.frame = self.bounds;
    }
    return _coverBgLayer;
}
- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.startPoint = CGPointMake(0, 1);
        _gradientLayer.endPoint = CGPointMake(1, 1);
    }
    return _gradientLayer;
}
- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        //圆环遮罩
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.lineWidth = 15;
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 1;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.lineDashPhase = 0.8;
        [self.colorsLayer setMask:_shapeLayer];
    }
    return _shapeLayer;
}
- (UILabel *)progressLabel
{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _progressLabel;
}
#pragma mark - set
-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.coverBgLayer.strokeColor = backgroundColor.CGColor;
}
- (void)setFont:(UIFont *)font
{
    _font = font;
    _progressLabel.font = font;
}
- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _progressLabel.textColor = textColor;
}
- (void)setShadowColors:(NSMutableArray *)shadowColors
{
    _shadowColors = shadowColors;
    [self.gradientLayer setColors:[NSArray arrayWithArray:shadowColors]];
}
- (void)setResidueColor:(UIColor *)residueColor
{
    _residueColor = residueColor;
    _coverLayer.strokeColor = residueColor.CGColor;
    ;

}
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    NSString *fl = [NSString stringWithFormat:@"%f",progress];
    if ([fl integerValue] == progress) {
        _progressLabel.text = [NSString stringWithFormat:@"%d",[fl intValue]];
    }else{
        _progressLabel.text = [NSString stringWithFormat:@"%.1f",progress];
    }
    if (progress < 0) {
        _progress = 0;
    }else{
        _progress = progress*0.01;
    }
    _endAngle = M_PI_2;
    _startAngle =  _endAngle + _progress * M_PI * 2;
    
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:_origin radius:_radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    _coverBgLayer.path = bgPath.CGPath;
    
    UIBezierPath *coverPath = [UIBezierPath bezierPathWithArcCenter:_origin radius:_radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    _coverLayer.path = coverPath.CGPath;
}


- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    
    _origin = CGPointMake(self.width / 2.0, self.height / 2.0);
    _radius = (self.width - progressWidth) / 2.0  ;
    _coverLayer.lineWidth = progressWidth;
    _coverBgLayer.lineWidth = self.width / 2.0;
    //创建圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.0, self.height / 2.0) radius:(self.width  - progressWidth) / 2.0  startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    self.shapeLayer.path = bezierPath.CGPath;
    self.gradientLayer.shadowPath = bezierPath.CGPath;
}
@end
