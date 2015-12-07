//
//  BookRoomViewController.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/2/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//
#import "BookRoomViewController.h"
#import "NSObject+NSmanagedObjectContext_Category.h"

@interface BookRoomViewController ()
@property(strong,nonatomic)UITextField *firstName;
@property(strong,nonatomic)UITextField *lastName;
@property(strong,nonatomic)NSNumber *age;
@property(strong, nonatomic)UILabel *topLabel;
@end

@implementation BookRoomViewController

- (void)loadView
{
	[super loadView];
	[self.view setBackgroundColor:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupBookViewController];
	[self setupMessageLabel];
	[self firstNameTextField];
	[self lastNameTextField];
//	[self setupTopLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupBookViewController
{
	[self.navigationItem setTitle:self.room.hotel.name];
	[self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];
}

- (void)setupMessageLabel
{
	UILabel *messageLabel = [[UILabel alloc]init];
	messageLabel.textAlignment = NSTextAlignmentCenter;
	messageLabel.numberOfLines = 0;
	messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
	
	messageLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Reservation at %@, Room: %i, From: %@ - To: %@", nil), self.room.hotel.name, self.room.roomNumber.intValue, [NSDateFormatter localizedStringFromDate:self.startDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle], [NSDateFormatter localizedStringFromDate:self.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
	
	NSLog(@"%@ %@", self.startDate, self.endDate);
	
	[self.view addSubview:messageLabel];
	
	NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
	
	NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
	
	NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
	
	leading.active = YES;
	trailing.active = YES;
	centerY.active = YES;

}

//- (void)setupTopLabel
//{
//	UILabel *topLabel = [[UILabel alloc]init];
//	topLabel.textAlignment = NSTextAlignmentCenter;
//	topLabel.text = @"Finish your Reservation";
//
//	topLabel.textColor = [UIColor colorWithRed:136.0 / 255.0 green:160.0 / 255.0 blue:168.0 / 255.0 alpha:1.0];
//	topLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0];
//	
//	NSLayoutConstraint *labelConstraintTop = [NSLayoutConstraint constraintWithItem:self.topLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:74.0];
//	NSLayoutConstraint *labelConstrainX = [NSLayoutConstraint constraintWithItem:self.topLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
//	
//	
//	labelConstraintTop.active = YES;
//	labelConstrainX.active = YES;
//	topLabel.translatesAutoresizingMaskIntoConstraints = NO;
//
//	
//	[self.view addSubview:topLabel];
//
//}

- (void)firstNameTextField
{
	self.firstName = [[UITextField alloc]init];
	self.firstName.placeholder = NSLocalizedString(@"First Name", nil);
	self.firstName.translatesAutoresizingMaskIntoConstraints = NO;

	[self.view addSubview:self.firstName];

	NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.firstName attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];

	NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.firstName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:104.0];

	NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.firstName attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];

	leading.active = YES;
	top.active = YES;
	trailing.active = YES;

	[self.firstName becomeFirstResponder];
}

- (void)lastNameTextField
{
	self.lastName = [[UITextField alloc]init];
	self.lastName.placeholder = NSLocalizedString(@"Last Name", nil);
	self.lastName.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.view addSubview:self.lastName];
	
	NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
	
	NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:160.0];
	
	NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
	
	leading.active = YES;
	top.active = YES;
	trailing.active = YES;
	
	[self.lastName becomeFirstResponder];
}


- (void)saveButtonSelected:(UIBarButtonItem *)sender
{
	Reservation *reservation = [Reservation reservationWithStartDate:[NSDate date] endDate:self.endDate room:self.room];

	self.room.reservation = reservation;
	
	reservation.guest = [Guest guestWithName:self.firstName.text];
	
	NSError *saveError;
	[[NSManagedObjectContext managerContext] save:&saveError];
	
	if (saveError) {
		NSLog(@"Save error is %@", saveError);
	} else {
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
}

@end
