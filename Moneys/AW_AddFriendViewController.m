//
//  AW_AddFriendViewController.m
//  Moneys
//
//  Created by Alan Wang on 1/12/15.
//  Copyright (c) 2015 Alan Wang. All rights reserved.
//

#import "AW_AddFriendViewController.h"

@interface AW_AddFriendViewController ()

@property (nonatomic, strong) NSArray *queryResults;

@end

@implementation AW_AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set up navigation bar
    self.navigationItem.title = @"Add Friend";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didPressCancel)];
    
    // Table view setup
    [self.lookupTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - Navigation
- (void)didPressCancel
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.queryResults count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.lookupTableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    PFObject *object = self.queryResults[indexPath.row];
    
    if ([object isKindOfClass:[PFUser class]]) {
        PFUser *user = (PFUser *)object;
        cell.textLabel.text = user[@"username"];
    }
    else {
        cell.textLabel.text = @"Not a user";
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUser *user = (PFUser *)self.queryResults[indexPath.row];
    PFUser *currentUser = [PFUser currentUser];
    
    // currentUser adds user
    PFRelation *friendRelation = [currentUser relationForKey:@"Friends"];
    [friendRelation addObject:user];
    [currentUser saveInBackground];
    
    // user adds currentUser
    PFRelation *otherFriendRelation = [user relationForKey:@"Friends"];
    [otherFriendRelation addObject:currentUser];
    [user saveInBackground];
    
    // Dismiss the view controller
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" containsString:self.userNameTextField.text];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
        else {
            NSLog(@"Found objects: %@", objects);
            self.queryResults = objects;
            [self.lookupTableView reloadData];
        }
    }];
    
    return YES;
}


@end
