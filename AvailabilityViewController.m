//
//  AvailabilityViewController.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/2/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//
#import "AppDelegate.h"
#import "AvailabilityViewController.h"
#import "Reservation.h"
#import "Room.h"
#import "Hotel.h"
#import "BookRoomViewController.h"

@interface AvailabilityViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic)NSArray *dataSource;
@property (strong,nonatomic)UITableView *tableView;
@end

@implementation AvailabilityViewController 

- (NSArray *)dataSource
{
	if (!_dataSource) {
		AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
		
		NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
		request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.endDate, [NSDate date]];
		NSArray *results = [delegate.managedObjectContext executeFetchRequest:request error:nil];
		NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
		
		for (Reservation *reservation in results)
		{
			[unavailableRooms addObject:reservation.room];
		}
		
		NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
		checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
		
		_dataSource = [delegate.managedObjectContext executeFetchRequest:checkRequest error:nil];
		
		return _dataSource;
	}
	
	return _dataSource;
	
}


- (void)loadView
{
	[super loadView];
	[self.view setBackgroundColor:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupAvailabilityViewController {
	[self setTitle:@"Rooms"];
}

- (void)setupTableView
{
	self.tableView = [[UITableView alloc]init];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	[self.view addSubview:self.tableView];
	
	NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
	NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
	NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
	NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
	
	top.active = YES;
	trailing.active = YES;
	bottom.active = YES;
	leading.active = YES;
}

#pragma mark - tableViewDatasource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	
	Room *room = self.dataSource[indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"Room: %i (%i beds, $%0.2f per night)", room.roomNumber.intValue, room.beds.intValue, room.rate.floatValue];
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 200.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIImage *headerImage = [UIImage imageNamed:@"room.jpg"];
	UIImageView *imageView = [[UIImageView alloc]initWithImage:headerImage];
	imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 200.0);
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	imageView.clipsToBounds = YES;
	
	return imageView;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Room *room = self.dataSource[indexPath.row];
	
	BookRoomViewController *bookViewController = [[BookRoomViewController alloc]init];
	bookViewController.room = room;
	bookViewController.endDate = self.endDate;
	
	[self.navigationController pushViewController:bookViewController animated:YES];
}

@end
