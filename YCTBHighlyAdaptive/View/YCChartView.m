//
//  YCChartView.m
//  cell自适应高度
//
//  Created by yishanmen on 16/10/8.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import "YCChartView.h"

@implementation YCChartModel

- (instancetype)initWithColor:(UIColor *)color value:(CGFloat)value text:(NSString *)text {
    self = [super init];
    if (self) {
        self.color = color;
        self.value = value;
        self.text = text;
    }
    return self;
}

@end



@interface YCChartView()

@property (nonatomic, strong) NSArray<YCChartModel *> *valueArray;


@property (nonatomic, strong) CAShapeLayer *animationLayer;//用来显示动画的layer
@property (nonatomic, assign) CGFloat pieRadius;
@property (nonatomic, assign) CGPoint layerCenter;


@property (nonatomic, strong) NSArray *percentArray;//每个value所占总体的比例
@property (nonatomic, strong) NSArray *startAngleArray;//每个value对应的startAngle
@property (nonatomic, strong) NSArray *endAngleArray;//每个value对应的endAngle
@property (nonatomic, strong) NSArray *subLayerArray;


@end

@implementation YCChartView


- (instancetype)initWithFrame:(CGRect)frame values:(NSArray *)valueArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.valueArray = valueArray;
        
        [self commonInit];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark - publicMethod

- (void)startAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 1;
    [self.animationLayer addAnimation:animation forKey:@"kClockAnimation"];
}

- (void)reloadData {
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeAllAnimations];
    }
    self.subLayerArray = nil;
    
    [self commonInit];
}

#pragma mark - privateMethod

- (void)commonInit {
    [self setupDefault];
    [self createLayers];
    [self createDescriptionLabels];
    [self createAnimationLayer];
    [self startAnimation];
}

- (void)setupDefault {
    self.pieRadius = CGRectGetWidth(self.bounds) / 2;
    self.layerCenter = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
    
    CGFloat total = [[self.valueArray valueForKeyPath:@"@sum.value"] floatValue];
    NSMutableArray *startAngleArray = [NSMutableArray array];
    NSMutableArray *endAngleArray = [NSMutableArray array];
    NSMutableArray *percentArray = [NSMutableArray array];
    CGFloat currentSum = 0;
    for (YCChartModel *model in self.valueArray) {
        CGFloat value = model.value;
        NSNumber *tempStartAngle = @(currentSum / total * 2 * M_PI - 0.5 *M_PI);
        [startAngleArray addObject:tempStartAngle];
        currentSum = currentSum + value;
        NSNumber *tempEndAngle = @(currentSum / total * 2 * M_PI - 0.5 *M_PI);
        [endAngleArray addObject:tempEndAngle];
        NSNumber *percent = @(value / total);
        [percentArray addObject:percent];
    }
    self.startAngleArray = startAngleArray;
    self.endAngleArray = endAngleArray;
    self.percentArray = percentArray;
    
}


- (void)createLayers {
    NSMutableArray *subLayerArray = [NSMutableArray array];
    for (int i = 0; i < self.valueArray.count; i++) {
        CAShapeLayer *subLayer = [self subPieLayerWithIndex:i];
        [self.layer addSublayer:subLayer];
        [subLayerArray addObject:subLayer];
    }
    self.subLayerArray = subLayerArray;
}


- (CAShapeLayer *)subPieLayerWithIndex:(NSInteger)index {
    
    CGFloat startAngle = [self.startAngleArray[index] floatValue];
    CGFloat endAngle = [self.endAngleArray[index] floatValue];
    YCChartModel *model = self.valueArray[index];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.lineWidth = 0;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = model.color.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.layerCenter];
    [path addArcWithCenter:self.layerCenter radius:self.pieRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [path addLineToPoint:self.layerCenter];
    shapeLayer.path = path.CGPath;
    return shapeLayer;
    
}

- (void)createDescriptionLabels {
    NSMutableArray *descriptionLabelArray = [NSMutableArray array];
    for (int i = 0; i < self.valueArray.count; i++) {
        UILabel *label = [self descriptionLabelWithIndex:i];
        [self addSubview:label];
        [descriptionLabelArray addObject:label];
    }
}

- (UILabel *)descriptionLabelWithIndex:(NSInteger)index {
    CGFloat centerAngle = ([self.startAngleArray[index] floatValue]+ [self.endAngleArray[index] floatValue]) / 2;//某个扇形的中心的角度
    NSLog(@"angle is %@", @(centerAngle / 2 / M_PI *360));
    CGFloat centerX = self.pieRadius + cos(centerAngle) * self.pieRadius / 2;
    CGFloat centerY = self.pieRadius + sin(centerAngle) * self.pieRadius / 2;
    NSLog(@"center is (%@, %@)", @(centerX), @(centerY));
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    label.text = [NSString stringWithFormat:@"%.1f%%", [self.percentArray[index] floatValue] * 100];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    label.center = CGPointMake(centerX, centerY);
    return label;
}

- (void)createAnimationLayer {
    CAShapeLayer *animationLayer = [CAShapeLayer layer];
    animationLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.layerCenter radius:self.pieRadius / 2 startAngle:-0.5 *M_PI endAngle:1.5 * M_PI clockwise:YES];
    animationLayer.path = path.CGPath;
    animationLayer.lineWidth = self.pieRadius;
    animationLayer.strokeColor = [UIColor greenColor].CGColor;
    animationLayer.fillColor = [UIColor clearColor].CGColor;
    animationLayer.strokeEnd = 0;
    self.layer.mask = animationLayer;
    //[self.layer addSublayer:animationLayer];
    self.animationLayer = animationLayer;
    
}

- (CABasicAnimation *)offsetAnimationForSelectionAtIndex:(NSInteger)index {
    if (index < 0 || index > self.subLayerArray.count - 1) {
        return nil;
    }
    CGFloat centerAngle = ([self.startAngleArray[index] floatValue]+ [self.endAngleArray[index] floatValue]) / 2;//某个扇形的中心的角度
    CGFloat offsetX = 10 * cos(centerAngle);//10是圆心偏移的距离
    CGFloat offsetY = 10 * sin(centerAngle);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(offsetX, offsetY, 0)];
    animation.duration = 0.4;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

#pragma mark - buttonAction

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:sender.view];
    NSLog(@"location is %@", NSStringFromCGPoint(location));
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    NSInteger index = -1;
    
    for (int i = 0; i < self.subLayerArray.count; i ++) {
        CAShapeLayer *shapeLayer = self.subLayerArray[i];
        if (CGPathContainsPoint(shapeLayer.path, &transform, location, 0)) {
            index = i;
            break;
        }
    }
    if ([self.delegate respondsToSelector:@selector(ycChartView:didSelectSectionAtIndex:)]
        && index >= 0) {
        
        for (CALayer *subLayer in self.subLayerArray) {
            [subLayer removeAnimationForKey:@"kOffsetAnimation"];
        }
        
        CAShapeLayer *selectedLayer = self.subLayerArray[index];
        [selectedLayer addAnimation:[self offsetAnimationForSelectionAtIndex:index] forKey:@"kOffsetAnimation"];
        
        [self.delegate ycChartView:self didSelectSectionAtIndex:index];
    }
}



@end
