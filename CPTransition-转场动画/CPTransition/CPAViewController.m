//
//  CPAViewController.m
//  CPTransition
//
//  Created by lk03 on 17/4/28.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import "CPAViewController.h"
#import "CPBViewController.h"
#import "CPTransitionManager.h"
#import "UIViewController+CPTransition.h"

@interface CPAViewController ()

@end

@implementation CPAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    button.center = CGPointMake(CGRectGetMidX(self.view.frame) + 100, CGRectGetMaxY(self.view.frame) - 60);
    button.layer.cornerRadius = 25.0f;
    button.backgroundColor = [UIColor colorWithRed:189/255.0 green:79/255.0 blue:70/255.0 alpha:1];
    [button addTarget:self action:@selector(pushMethod) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"Menu_icn"] forState:UIControlStateNormal];
    [self.view addSubview:button];
  
    self.cp_pushTransition = [CPTransitionManager transitionWithAnchorRect:button.frame];
    self.cp_popTransition = [CPTransitionManager transitionWithAnchorRect:button.frame];
}

-(void)pushMethod{
    CPBViewController *vcB = [[CPBViewController alloc] init];
    [self.navigationController pushViewController:vcB animated:YES];
//    [self presentViewController:vcB animated:true completion:nil];
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
