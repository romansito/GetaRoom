//
//  SearchReservationsViewController.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/3/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//
#import "NSObject+NSmanagedObjectContext_Category.h"
#import "SearchReservationsViewController.h"
#import "Reservation.h"
#import "Guest.h"
#import "Room.h"
#import "Hotel.h"


@interface SearchReservationsViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property(strong,nonatomic)NSArray *datasource;
@property(strong,nonatomic)UITableView *tableView;
@end

@implementation SearchReservationsViewController

- (void)setDatasource:(NSArray *)datasource
{
	_datasource = datasource;
	[self.tableView reloadData];
}

- (void)loadView
{
	[super loadView];
	[self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupSearchRoomVC];
	[self setupTableView];
}

- (void)setupSearchRoomVC
{
	[self setTitle:@"Search Reservations"];
}

- (void)setupTableView
{
	self.tableView = [[UITableView alloc]init];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	[self.view addSubview:self.tableView];

	NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64.0];
	NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
	NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
	NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
	
	
	
	top.active = YES;
	trailing.active = YES;
	bottom.active = YES;
	leading.active = YES;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	
	Reservation *reservation = self.datasource[indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"Name: %@, Hotel: %@", reservation.guest.firstName, reservation.room.hotel.name];
	
	return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return  44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 44.0)];
	searchBar.delegate = self;
	return  searchBar;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	
	NSString *searchText = searchBar.text;
	NSManagedObjectContext *context = [NSManagedObjectContext managerContext];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
	request.predicate = [NSPredicate predicateWithFormat:@"guest.firstName == %@", searchText];
	
	NSError *error;
	NSArray *results = [context executeFetchRequest:request error:&error];
	
	if (!error) {
		self.datasource = results;
	}
}


@end
