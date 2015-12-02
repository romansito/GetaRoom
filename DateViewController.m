//
//  DateViewController.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/1/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()
@property (strong, nonatomic)UIDatePicker *startDatePicker;
@property (strong, nonatomic)UIDatePicker *endDatePicker;
@end

@implementation DateViewController

- (void)loadView
{
	[self superclass];
	[self.view setBackgroundColor:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupDateViewController];
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
// setup TWO day pickers!
- (void)setupDatePickers
{
	// startDatePicker
	self.startDatePicker = [[UIDatePicker alloc]init];
	self.startDatePicker.datePickerMode = UIDatePickerModeDate;
	self.startDatePicker.frame = CGRectMake(0.0, 84.0, CGRectGetWidth(self.view.frame), 400);
	[self.view addSubview:self.startDatePicker];
	// endDatePicker
	self.endDatePicker = [[UIDatePicker alloc]init];
	self.endDatePicker.datePickerMode = UIDatePickerModeDate;
	self.endDatePicker.frame = CGRectMake(0.0, 84.0, CGRectGetWidth(self.view.frame), 0.0);
}

- (void)doneButtonSelected:(UIBarButtonItem *)sender
{
	//
}



@end
