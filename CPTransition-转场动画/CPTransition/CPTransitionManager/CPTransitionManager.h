//
//  CPTransitionManager.h
//  CPTransition
//
//  Created by lk03 on 17/4/28.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CPTransitionManagerShow,
    CPTransitionManagerHidden
} CPTransitionManagerType;

@interface CPTransitionManager : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic , assign) CPTransitionManagerType transitionType;

+ (instancetype)transitionWithAnchorRect:(CGRect)anchorRect;
- (instancetype)initWithAnchorRect:(CGRect)anchorRect;

@end
