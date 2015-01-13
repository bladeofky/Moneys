//
//  AW_MainViewController.m
//  Moneys
//
//  Created by Alan Wang on 1/6/15.
//  Copyright (c) 2015 Alan Wang. All rights reserved.
//

#import "AW_LoginViewController.h"

@interface AW_LoginViewController ()

@end

@implementation AW_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)didPressCreateUserButton:(UIButton *)sender {
    PFUser *user = [PFUser user];
    user.username = self.userNameTextField.text;
    user.password = self.passwordTextField.text;
    user.email = self.emailTextField.text;
    user[@"isEditing"] = @NO;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            self.statusLabel.text = [NSString stringWithFormat:@"Successfully signed up %@", user.username];
            NSLog(@"Successfully signed up %@", user.username);
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            self.statusLabel.text = errorString;
            NSLog(@"%@", errorString);
        }
    }];
}

- (IBAction)didPressLoginButton:(UIButton *)sender {
    [PFUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            //Login succeeded
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            self.statusLabel.text = @"Login successful";
            NSLog(@"Login successful for user: %@", user.username);
        }
        else {
            // Login failed
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            self.statusLabel.text = errorString;
            NSLog(@"%@", errorString);
        }
    }];
}
@end
