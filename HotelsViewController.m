//
//  HotelsViewController.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 11/30/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "HotelsViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomsViewController.h"

@interface HotelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HotelsViewController

- (NSArray *)datasource
{
	if (!_datasource)
	{
		AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
		NSManagedObjectContext *context = delegate.managedObjectContext;
		NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
		NSError *fetchError;
		_datasource = [context executeFetchRequest:request error:&fetchError];
		if (fetchError)
		{
			NSLog(@"Error loading objects from Core Data");
		}
	}
	return _datasource;
}

- (void)loadView
{
	[super loadView];
	[self.view setBackgroundColor : [UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupTableView];
	[self setupHotelsViewController];
}

- (void)setupHotelsViewController
{
	//
}

- (void)setupTableView
{
	self.tableView = [[UITableView alloc]init];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	[self.view addSubview:self.tableView];
	
	NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
	NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64.0];
	NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
	NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
	
	leading.active = YES;
	top.active = YES;
	trailing.active = YES;
	bottom.active = YES;
	
	self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	if (!cell)
	{
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	
	Hotel *hotel = self.datasource[indexPath.row];
	cell.textLabel.text = hotel.name;
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 200.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIImage *headerImage = [UIImage imageNamed:@"hotel.jpg"];
	UIImageView *imageView = [[UIImageView alloc]initWithImage:headerImage];
	imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame) , 200.0);
	imageView.contentMode = UIViewContentModeScaleToFill;
	imageView.clipsToBounds = YES;
	
	return imageView;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Hotel *hotel = self.datasource[indexPath.row];
	RoomsViewController *roomsViewController = [[RoomsViewController alloc]init];
	roomsViewController.hotel = hotel;
	[self.navigationController pushViewController:roomsViewController animated:YES];
}

@end
