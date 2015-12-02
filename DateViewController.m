//
//  DateViewController.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/1/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "DateViewController.h"

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
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupDateViewController];
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
	self.startDateLabel.textColor = [UIColor whiteColor];
	self.startDateLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11.0];
	NSLayoutConstraint *startDateLabelTop = [NSLayoutConstraint constraintWithItem:self.startDateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:50.0];
	NSLayoutConstraint *startDateLabelX = [NSLayoutConstraint constraintWithItem:self.startDateLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
	
	self.endDateLabel = [[UILabel alloc]init];
	self.endDateLabel.text = @"Check In";
	self.endDateLabel.textColor = [UIColor whiteColor];
	self.endDateLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11.0];
	NSLayoutConstraint *endDateLabelTop = [NSLayoutConstraint constraintWithItem:self.endDateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:380.0];
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
	self.startDatePicker.frame = CGRectMake(0.0, 60.0, CGRectGetWidth(self.view.frame), 150.0);
	[self.view addSubview:self.startDatePicker];
	// endDatePicker
	self.endDatePicker = [[UIDatePicker alloc]init];
	self.endDatePicker.datePickerMode = UIDatePickerModeDate;
	self.endDatePicker.frame = CGRectMake(0.0, 400.0, CGRectGetWidth(self.view.frame), 150.0);
	[self.view addSubview:self.endDatePicker];
}

- (void)doneButtonSelected:(UIBarButtonItem *)sender
{
	NSDate *startDate = [self.startDatePicker date];
	NSDate *endDate = [self.endDatePicker date];
	
	if (startDate > endDate) {
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops..." message:@"Please choose a valid date" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertViewStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			self.endDatePicker.date = [NSDate date];
		}];
		
		[alertController addAction:okAction];
		[self presentViewController:alertController animated:YES completion:nil];
		
		return;
	}
	
}



@end
