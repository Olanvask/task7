//
//  TabBarController.m
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/21/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "TabBarController.h"
#import "AllVideoViewController.h"
#import "FavoriteVideosViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AllVideoViewController *allVideoViewController = [AllVideoViewController new];
    allVideoViewController.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:allVideoViewController];
    UITabBarItem *allVideoTabItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:0];
    navigationController.tabBarItem = allVideoTabItem;
    
    FavoriteVideosViewController *favoriteVideosViewController = [FavoriteVideosViewController new];
    favoriteVideosViewController.view.backgroundColor = [UIColor whiteColor];
    UITabBarItem *favoriteVideoTabItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
    favoriteVideosViewController.tabBarItem = favoriteVideoTabItem;
    
    self.viewControllers = @[navigationController, favoriteVideosViewController];
}
@end
