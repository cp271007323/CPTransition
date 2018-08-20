//
//  UIViewController+CPTransition.h
//  CPTransition
//
//  Created by lk03 on 17/4/28.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTransitionManager.h"

@interface UIViewController (CPTransition)<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic , retain) CPTransitionManager *cp_pushTransition;
@property (nonatomic , retain) CPTransitionManager *cp_popTransition;
@property (nonatomic , retain) CPTransitionManager *cp_PresentTransition;
@property (nonatomic , retain) CPTransitionManager *cp_DismissTransition;

@end
