//
//  HelpViewController.m
//  moments
//
//  Created by jKool LLC on 6/6/16.
//  Copyright © 2016 jKool LLC. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    helpText.text = @"Welcome to jKools Moments app. This app demonstrates streaming and querying to and from a jKool Repository. To use this app you must first register an account in jKool. To do this, simply go to the Account Screen. Enter your information and save. This will create a jKool account for you and store your access token on your device. If you ever delete the app off of your device, you will need to re-register. ";
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
