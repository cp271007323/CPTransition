//
//  CPTransitionManager.m
//  CPTransition
//
//  Created by lk03 on 17/4/28.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import "CPTransitionManager.h"

@interface CPTransitionManager ()<CAAnimationDelegate>
{
    CGRect _anchorRect;
    NSObject<UIViewControllerContextTransitioning> *_transitionContext;
    CAShapeLayer *_maskLayer;
}
@end

@implementation CPTransitionManager

#pragma mark -
#pragma mark 初始化
+ (instancetype)transitionWithAnchorRect:(CGRect)anchorRect{
    CPTransitionManager *transitionManager = [[CPTransitionManager alloc] initWithAnchorRect:anchorRect];
    return transitionManager;
}

- (instancetype)initWithAnchorRect:(CGRect)anchorRect
{
    self = [super init];
    if (self) {
        _anchorRect = anchorRect;
    }
    return self;
}

#pragma mark -
#pragma mark UIViewControllerAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.transitionType == CPTransitionManagerShow) {
        [self showBubbleMaskAnimationTo:transitionContext];
        [self showScaleAnimationTo:transitionContext];
    }else if (self.transitionType == CPTransitionManagerHidden){
        [self hiddenBubbleMaskAnimationTo:transitionContext];
        [self hiddenScaleAnimationTo:transitionContext];
    }
}

-(void)showBubbleMaskAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    _transitionContext = transitionContext;
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:fromView];
    [containView addSubview:toView];
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:_anchorRect];
    CGFloat radiu = [self radiusOfBubbleInView:toView startPoint:CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect))];
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(_anchorRect, -radiu, -radiu)];
    
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.bounds = toView.bounds;
    _maskLayer.position = toView.layer.position;
    _maskLayer.fillColor = toView.backgroundColor.CGColor;
    _maskLayer.path = finalPath.CGPath;
    [fromView.layer addSublayer:_maskLayer];
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    [_maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

-(void)showScaleAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.layer.position = CGPointMake(CGRectGetMidX(toView.frame), CGRectGetMidY(toView.frame));
    toView.transform = CGAffineTransformMakeScale(1, 1);
    
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = [self transitionDuration:transitionContext];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect))];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(toView.frame), CGRectGetMidY(toView.frame))];
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [toView.layer addAnimation:positionAnimation forKey:@"position"];
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = [self transitionDuration:transitionContext];
    scaleAnimation.fromValue = @0;
    scaleAnimation.toValue = @1;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [toView.layer addAnimation:scaleAnimation forKey:@"scale"];
    
}

-(void)hiddenBubbleMaskAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    _transitionContext = transitionContext;
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:toView];
    [containView addSubview:fromView];
    
    
    CGFloat radius = [self radiusOfBubbleInView:toView startPoint:CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect))];
    UIBezierPath *startPath =  [UIBezierPath bezierPathWithOvalInRect:CGRectInset(_anchorRect, - radius, - radius)];
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:_anchorRect];
    
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.bounds = toView.bounds;
    _maskLayer.position = toView.layer.position;
    _maskLayer.fillColor = fromView.backgroundColor.CGColor;
    _maskLayer.path = finalPath.CGPath;
    [toView.layer addSublayer:_maskLayer];
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    [_maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

-(void)hiddenScaleAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{

    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    fromView.layer.position = CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect));
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = [self transitionDuration:transitionContext];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect))];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(fromView.frame), CGRectGetMidY(fromView.frame))];
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [fromView.layer addAnimation:positionAnimation forKey:@"position"];
    
    fromView.transform = CGAffineTransformMakeScale(0, 0);
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = [self transitionDuration:transitionContext];
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @0;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [fromView.layer addAnimation:scaleAnimation forKey:@"scale"];

}

//遍历view的四个角 获取最长的半径
-(CGFloat)radiusOfBubbleInView:(UIView*)view startPoint:(CGPoint)startPoint{
    
    //获取四个角所在的点
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(view.bounds.size.width, 0);
    CGPoint point3 = CGPointMake(0 ,view.bounds.size.height);
    CGPoint point4 = CGPointMake(view.bounds.size.width,view.bounds.size.height);
    NSArray *pointArrar = @[[NSValue valueWithCGPoint:point1],[NSValue valueWithCGPoint:point2],[NSValue valueWithCGPoint:point3],[NSValue valueWithCGPoint:point4]];
    //做一个冒泡排序获得最长的半径
    CGFloat radius = 0;
    for (NSValue *value in pointArrar) {
        CGPoint point = [value CGPointValue];
        CGFloat apartX = point.x - startPoint.x;
        CGFloat apartY = point.y - startPoint.y;
        CGFloat realRadius = sqrt(apartX*apartX + apartY*apartY);
        if (radius <= realRadius) {
            radius = realRadius;
        }
    }
    return radius;
}

#pragma mark -
#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
    [_maskLayer removeFromSuperlayer];
    _maskLayer = nil;
}


@end
