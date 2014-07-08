//
//  NPNotesTableViewController.m
//  MbraceTest
//
//  Created by Nissim Pardo on 7/8/14.
//  Copyright (c) 2014 androdogs. All rights reserved.
//

#import "NPNotesTableViewController.h"
#import "NPDataBaseManager.h"
#import "Notes.h"
#import <MessageUI/MessageUI.h>


@interface NPNotesTableViewController ()<MFMailComposeViewControllerDelegate> {
    NSArray *notes;
}

@end

@implementation NPNotesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [DBMgr contextWithCompletion:^{
        [DBMgr updateDataBaseWithCompletion:^{
            notes = DBMgr.allNotes;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [notes[indexPath.row] text];
    cell.detailTextLabel.text = [notes[indexPath.row] link];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *linkStr = [notes[indexPath.row] link];
    if (linkStr) {
        NSURL *link = [NSURL URLWithString:linkStr];
        if ([link.scheme isEqualToString:@"mailto"]) {
            NSString *email = [linkStr stringByReplacingOccurrencesOfString:@"mailto:" withString:@""];
            MFMailComposeViewController *picker = [MFMailComposeViewController new];
            picker.mailComposeDelegate = self;
            
            [picker setSubject:@"You have pressed on email link"];
            [picker setToRecipients:@[email]];
            [self presentViewController:picker
                               animated:YES
                             completion:nil];
        }
        [[UIApplication sharedApplication] openURL:link];
    } else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
