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
@end

@implementation BookRoomViewController

- (void)loadView
{
	[super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
	
	messageLabel.text = [NSString stringWithFormat:@"Reservation at %@, Room: %i, From: Today - To: %@", self.room.hotel.name, self.room.roomNumber.intValue, [NSDateFormatter localizedStringFromDate:self.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
	
	[self.view addSubview:messageLabel];
	
	NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
	
	NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
	
	NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
	
	leading.active = YES;
	trailing.active = YES;
	centerY.active = YES;

}

- (void)setupTextFields
{
	UITextField *firstName = [[UITextField alloc]init];
	UITextField *lastName = [[UITextField alloc]init];
	UITextField *age = [[UITextField alloc]init];
	firstName.placeholder = @"First Name";
	lastName.placeholder = @"Last Name";
	age.placeholder = @"Age";
	
	firstName.translatesAutoresizingMaskIntoConstraints = NO;
	lastName.translatesAutoresizingMaskIntoConstraints = NO;
	age.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.view addSubview:firstName];
	[self.view addSubview:lastName];
	[self.view addSubview:age];
	
	NSLayoutConstraint *firstNameLeading = [NSLayoutConstraint constraintWithItem:self.firstName attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
	NSLayoutConstraint *firstNameTop = [NSLayoutConstraint constraintWithItem:self.firstName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:60.0];
	NSLayoutConstraint *firstNametrailing = [NSLayoutConstraint constraintWithItem:self.firstName attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
	
	NSLayoutConstraint *lastNameLeading = [NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
	NSLayoutConstraint *lastNametop = [NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:70.0];
	NSLayoutConstraint *lastNameTrailing = [NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
	
	NSLayoutConstraint *ageLeading = [NSLayoutConstraint constraintWithItem:self.age attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
	NSLayoutConstraint *ageTop = [NSLayoutConstraint constraintWithItem:self.age attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:80.0];
	NSLayoutConstraint *ageTrailing = [NSLayoutConstraint constraintWithItem:self.age attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
	
	firstNameLeading.active = YES;
	firstNameTop.active = YES;
	firstNametrailing.active = YES;
	
	[self.firstName becomeFirstResponder];
	
	lastNameLeading.active = YES;
	lastNametop.active = YES;
	lastNameTrailing.active = YES;
	
	[self.lastName becomeFirstResponder];
	
	ageLeading.active = YES;
	ageTop.active = YES;
	ageTrailing.active = YES;
	
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

//	[Reservation createReservationWithStartDate:self.startDate endDate:self.endDate room:self.room firstName:self.firstNameTextField.text lastName:self.lastNameTextField.text completion:^(BOOL success) {
//		if (success) {
//			[self.navigationController popToRootViewControllerAnimated:YES];
//		}
//	}];
//} else {
//	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"What!?!" message:@"Put your names in there!" preferredStyle:UIAlertControllerStyleAlert];
//	UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//	[alertController addAction:okAction];
//	[self presentViewController:alertController animated:YES completion:nil];
//}

}
@end
