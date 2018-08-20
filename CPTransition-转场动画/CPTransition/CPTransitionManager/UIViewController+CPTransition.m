//
//  UIViewController+CPTransition.m
//  CPTransition
//
//  Created by lk03 on 17/4/28.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import "UIViewController+CPTransition.h"
#import <objc/runtime.h>

const NSString *CPPushTransitionKey     = @"CPPushTransitionKey";
const NSString *CPPopTransitionKey      = @"CPPopTransitionKey";
const NSString *CPPresentTransitionKey  = @"CPPresentTransitionKey";
const NSString *CPDismissTransitionKey  = @"CPDismissTransitionKey";

@implementation UIViewController (CPTransition)

#pragma mark -
#pragma mark setter getter
-(void)setCp_pushTransition:(CPTransitionManager *)cp_pushTransition{
    if (cp_pushTransition) {
        cp_pushTransition.transitionType = CPTransitionManagerShow;
        self.navigationController.delegate = self;
        objc_setAssociatedObject(self, &CPPushTransitionKey, cp_pushTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(CPTransitionManager *)cp_pushTransition{
    return objc_getAssociatedObject(self, &CPPushTransitionKey);
}

-(void)setCp_popTransition:(CPTransitionManager *)cp_popTransition{
    if (cp_popTransition) {
        cp_popTransition.transitionType = CPTransitionManagerHidden;
        self.navigationController.delegate = self;
        objc_setAssociatedObject(self, &CPPopTransitionKey, cp_popTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(CPTransitionManager *)cp_popTransition{
    return objc_getAssociatedObject(self, &CPPopTransitionKey);
}

-(void)setCp_PresentTransition:(CPTransitionManager *)cp_PresentTransition{
    if (cp_PresentTransition) {
        cp_PresentTransition.transitionType = CPTransitionManagerShow;
        self.transitioningDelegate = self;
        objc_setAssociatedObject(self, &CPPresentTransitionKey, cp_PresentTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(CPTransitionManager *)cp_PresentTransition{
    return objc_getAssociatedObject(self, &CPPresentTransitionKey);
}

-(void)setCp_DismissTransition:(CPTransitionManager *)cp_DismissTransition{
    if (cp_DismissTransition) {
        cp_DismissTransition.transitionType = CPTransitionManagerHidden;
        self.transitioningDelegate = self;
        objc_setAssociatedObject(self, &CPDismissTransitionKey, cp_DismissTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(CPTransitionManager *)cp_DismissTransition{
    return objc_getAssociatedObject(self, &CPDismissTransitionKey);
}

#pragma mark - 
#pragma mark push和pop跳转
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush && [fromVC isEqual:self]) {
        return self.cp_pushTransition;
    }else if (operation == UINavigationControllerOperationPop && [toVC isEqual:self]){
        return self.cp_popTransition;
    }else{
        return nil;
    }
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.cp_PresentTransition;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.cp_DismissTransition;
}

@end
