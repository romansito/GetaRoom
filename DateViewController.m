//
//  DateViewController.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/1/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityViewController.h"

@interface DateViewController()
@property (strong, nonatomic)UIDatePicker *startDatePicker;
@property (strong, nonatomic)UIDatePicker *endDatePicker;
@property (strong, nonatomic)UILabel *startDateLabel;
@property (strong, nonatomic)UILabel *endDateLabel;
@end

@implementation DateViewController

- (void)loadView
{
	[super loadView];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[self setupDateViewController];

}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupLabels];
	[self setupDatePickers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupDateViewController
{
	[self.navigationItem setTitle:@"Book Date"];
	[self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
}

// setup labels
- (void)setupLabels
{
	self.startDateLabel = [[UILabel alloc]init];
	self.startDateLabel.text = @"Check In";
	self.startDateLabel.textColor = [UIColor colorWithRed:136.0 / 255.0 green:160.0 / 255.0 blue:168.0 / 255.0 alpha:1.0];
	self.startDateLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0];
	NSLayoutConstraint *startDateLabelTop = [NSLayoutConstraint constraintWithItem:self.startDateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:90.0];
	NSLayoutConstraint *startDateLabelX = [NSLayoutConstraint constraintWithItem:self.startDateLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
	
	self.endDateLabel = [[UILabel alloc]init];
	self.endDateLabel.text = @"Check Out";
	self.endDateLabel.textColor = [UIColor colorWithRed:136.0 / 255.0 green:160.0 / 255.0 blue:168.0 / 255.0 alpha:1.0];
	self.endDateLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0];
	NSLayoutConstraint *endDateLabelTop = [NSLayoutConstraint constraintWithItem:self.endDateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:340.0];
	NSLayoutConstraint *endDateLabelX = [NSLayoutConstraint constraintWithItem:self.endDateLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
	
	[self.view addSubview:self.startDateLabel];
	self.startDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
	
	startDateLabelTop.active = YES;
	startDateLabelX.active = YES;
	
	[self.view addSubview:self.endDateLabel];
	self.endDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
	
	endDateLabelTop.active = YES;
	endDateLabelX.active = YES;
}

// setup TWO day pickers!
- (void)setupDatePickers
{
	// startDatePicker
	self.startDatePicker = [[UIDatePicker alloc]init];
	self.startDatePicker.datePickerMode = UIDatePickerModeDate;
	self.startDatePicker.frame = CGRectMake(0.0, 140.0, CGRectGetWidth(self.view.frame), 100.0);
	[self.view addSubview:self.startDatePicker];
	// endDatePicker
	self.endDatePicker = [[UIDatePicker alloc]init];
	self.endDatePicker.datePickerMode = UIDatePickerModeDate;
	self.endDatePicker.frame = CGRectMake(0.0, 380.0, CGRectGetWidth(self.view.frame), 100.0);
	[self.view addSubview:self.endDatePicker];
}

- (void)doneButtonSelected:(UIBarButtonItem *)sender
{
	NSDate *startDate = self.startDatePicker.date;
	NSDate *endDate = self.endDatePicker.date;
	
	if (startDate >= endDate) {
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops..." message:@"Please choose a valid date" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			self.endDatePicker.date = [NSDate date];
		}];
		
		[alertController addAction:okAction];
		[self presentViewController:alertController animated:YES completion:nil];
		
//		return;
		
	} else {
		AvailabilityViewController *availabilityVC = [[AvailabilityViewController alloc] init];
		availabilityVC.startDate = startDate;
		availabilityVC.endDate = endDate;
		[self.navigationController pushViewController:availabilityVC animated:YES];
		
	}
}

@end
