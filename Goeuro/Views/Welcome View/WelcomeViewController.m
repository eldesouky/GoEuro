//
//  WelcomeViewController.m
//  
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//
#import "WelcomeViewController.h"
#import "HomeViewController.h"
#import "GoEuroEnumerators.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];

}

#pragma- mark  Setup View
-(void) setupView{
    self.defautViewButton.layer.cornerRadius = 7;
    self.defautViewButton.clipsToBounds = YES;
    self.customViewButton.layer.cornerRadius = 7;
    self.customViewButton.clipsToBounds = YES;
}

#pragma- mark  IBActions
- (IBAction)defaultViewButtonIsClicked:(id)sender{
    
    UIViewController* HomeController = [[HomeViewController alloc] initWithType: DefaultView];
    [self presentViewController: HomeController  animated:true completion:nil];
    
}

- (IBAction)customViewButtonIsClicked:(id)sender{
    
    UIViewController* HomeController = [[HomeViewController alloc] initWithType: CustomView];
     UINavigationController* root = [[UINavigationController alloc]initWithRootViewController:HomeController];
    [self presentViewController: root  animated:true completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
