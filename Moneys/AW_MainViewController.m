//
//  AW_MainViewController.m
//  Moneys
//
//  Created by Alan Wang on 1/6/15.
//  Copyright (c) 2015 Alan Wang. All rights reserved.
//

#import "AW_MainViewController.h"
#import "AW_LoginViewController.h"
#import "AW_FriendsListTableViewController.h"
#import "AW_AddFriendViewController.h"

@interface AW_MainViewController ()

@end

@implementation AW_MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewDidAppear:(BOOL)animated
{
    // Check if there is a current user
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        // Yay!
        self.userLabel.text = currentUser.username;
    }
    else {
        // Present login screen
        AW_LoginViewController *loginVC = [[AW_LoginViewController alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];
        self.userLabel.text = [PFUser currentUser].username;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didPressTransactionButton:(id)sender {
    
    AW_FriendsListTableViewController *friendListVC = [[AW_FriendsListTableViewController alloc]init];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:friendListVC];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

- (IBAction)didPressAddFriendButton:(id)sender {
    AW_AddFriendViewController *addFriendVC = [[AW_AddFriendViewController alloc]init];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:addFriendVC];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

- (IBAction)didPressLogoutButton:(id)sender {
    [PFUser logOut];
    
    if (![PFUser currentUser]) {
        NSLog(@"Logout successful");
    }
    
    // Present login screen
    AW_LoginViewController *loginVC = [[AW_LoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
    self.userLabel.text = [PFUser currentUser].username;
}

@end
