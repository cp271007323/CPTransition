//
//  CPBViewController.m
//  CPTransition
//
//  Created by lk03 on 17/4/28.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import "CPBViewController.h"
#import "UIViewController+CPTransition.h"
#import "CPTransitionManager.h"

@interface CPBViewController ()

@end

@implementation CPBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    button.center = CGPointMake(CGRectGetMidX(self.view.frame) + 100, CGRectGetMaxY(self.view.frame) - 60);
    [button setImage:[UIImage imageNamed:@"Close_icn"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor greenColor]];
    button.layer.cornerRadius = button.bounds.size.width/2.0f;
    [button addTarget:self action:@selector(popMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.cp_PresentTransition = [CPTransitionManager transitionWithAnchorRect:button.frame];
    self.cp_DismissTransition = [CPTransitionManager transitionWithAnchorRect:button.frame];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
}


-(void)popMethod{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
