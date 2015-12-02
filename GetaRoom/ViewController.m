//
//  ViewController.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 11/30/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "HotelsViewController.h"
#import "DateViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
	[super loadView];
	[self setUpCustomLayout];
}
- (void)viewDidLoad {
	[super viewDidLoad];
	[self setUpViewController];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)setUpViewController {
	self.navigationItem.title = @"GetaRoom";
}

- (void)setUpCustomLayout
{
	float navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
	
	UIButton *browseButton = [[UIButton alloc]init];
	UIButton *bookButton = [[UIButton alloc]init];
	UIButton *lookupButton = [[UIButton alloc]init];
	
	[browseButton setTitle:@"Browse" forState:UIControlStateNormal];
	[bookButton setTitle:@"Book" forState:UIControlStateNormal];
	[lookupButton setTitle:@"Lookup" forState:UIControlStateNormal];
	
	[browseButton setBackgroundColor:[UIColor colorWithRed:100.0 / 255.0 green:210.0 / 255.0 blue:100.0 / 255.0 alpha:1.0]];
	[lookupButton setBackgroundColor:[UIColor colorWithRed:136.0 / 255.0 green:160.0 / 255.0 blue:168.0 / 255.0 alpha:1.0]];
	[bookButton setBackgroundColor:[UIColor colorWithRed:84.0 / 255.0 green:160.0 / 255.0 blue:168.0 / 255.0 alpha:1.0]];

	[browseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[lookupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	[browseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[bookButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[lookupButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	NSLayoutConstraint *browseButtonLeading = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
	NSLayoutConstraint *browseButtonTop = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64.0];
	NSLayoutConstraint *browseButtonTrailing = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
	
	NSLayoutConstraint *bookButtonLeading = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
	NSLayoutConstraint *bookButtonCenterY= [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:navigationBarHeight / 1.4]; // Height is set to be 0.3 of the view. 0.3333333333333 problem.
	NSLayoutConstraint *bookButtonTrailing = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
	
	NSLayoutConstraint *lookupButtonLeading = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
	NSLayoutConstraint *lookupButtonBottom = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
	NSLayoutConstraint *lookupButtonTrailing = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
	
	// Setup equal height.
	NSLayoutConstraint *bookButtonHeight = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.3 constant:0.0];
	NSLayoutConstraint *browseButtonHeight = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:bookButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
	NSLayoutConstraint *lookupButtonHeight = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:bookButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
	
	[self.view addSubview:browseButton];
	[self.view addSubview:bookButton];
	[self.view addSubview:lookupButton];
	
	browseButtonLeading.active = YES;
	browseButtonTrailing.active = YES;
	browseButtonTop.active = YES;
	browseButtonHeight.active = YES;
	
	bookButtonLeading.active = YES;
	bookButtonTrailing.active = YES;
	bookButtonCenterY.active = YES;
	bookButtonHeight.active =YES;
	
	lookupButtonLeading.active = YES;
	lookupButtonTrailing.active = YES;
	lookupButtonBottom.active = YES;
	lookupButtonHeight.active = YES;
	
	[browseButton addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
	[bookButton addTarget:self action:@selector(bookButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
	[lookupButton addTarget:self action:@selector(lookupButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)browseButtonSelected:(UIButton *)sender
{
	[self.navigationController pushViewController:[[HotelsViewController alloc]init] animated:YES];

}
- (void)bookButtonSelected:(UIButton *)sender
{
//	BookViewController *bookVC = [[BookViewController alloc] init];
	[self.navigationController pushViewController:[DateViewController new] animated:YES];

}
- (void)lookupButtonSelected:(UIButton *)sender
{
	//
}


@end
