//
//  XFTabBarViewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/17.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFTabBarViewController.h"
#import "XFConcernViewController.h"
#import "XFEssenceViewController.h"
#import "XFLatestViewController.h"
#import "XFMeViewController.h"
#import "XFTabBar.h"
#import "XFNavigationController.h"

@interface XFTabBarViewController ()

@end

@implementation XFTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialControllers];
    
    //替换系统tabbar
    [self setValue:[[XFTabBar alloc] init] forKeyPath:@"tabBar"];
    
}

//初始化子控制器
-(void)initialControllers {
    
    [self setupController:[[XFEssenceViewController alloc]init] image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];
    [self setupController:[[XFLatestViewController alloc]init] image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"最新"];
    [self setupController:[[XFConcernViewController alloc]init] image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];
    [self setupController:[[XFMeViewController alloc]init] image:@"tabBar_me_icon"  selectedImage:@"tabBar_me_click_icon" title:@"我"];
   
    
}

//设置控制器
-(void)setupController:(UIViewController *)childVc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    UIViewController *viewVc = childVc;
    viewVc.tabBarItem.image = [UIImage imageNamed:image];
    viewVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    viewVc.tabBarItem.title = title;
    XFNavigationController *navi = [[XFNavigationController alloc]initWithRootViewController:viewVc];
    [self addChildViewController:navi];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
