//
//  AW_MainViewController.h
//  Moneys
//
//  Created by Alan Wang on 1/6/15.
//  Copyright (c) 2015 Alan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AW_MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
- (IBAction)didPressTransactionButton:(id)sender;
- (IBAction)didPressAddFriendButton:(id)sender;
- (IBAction)didPressLogoutButton:(id)sender;


@end
