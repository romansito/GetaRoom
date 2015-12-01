//
//  AppDelegate.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 11/30/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Hotel.h"
#import "Room.h"
#import "Reservation.h"
#import "Guest.h"

@interface AppDelegate ()

@property (strong, nonatomic)ViewController *viewController;
@property (strong, nonatomic)UINavigationController *navigationController;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self setUpRootViewController];
	[self bootStrapApp];
	return YES;
}

- (void)setUpRootViewController
{
	self.viewController = [[ViewController alloc]init];
	self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
	self.navigationController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
	self.viewController.view.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = self.navigationController;
	
	[self.window makeKeyAndVisible];
}
// Request all hotel objects in our jSon file.
- (void)bootStrapApp
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
	// If there is nothing to pull lets create our own request.
	NSError *error;
	NSInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
	if (count == 0)
	{
		NSDictionary *hotels = [NSDictionary new];
		NSDictionary *rooms = [NSDictionary new];
		NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"hotels" ofType:@"json"];
		NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
		
		NSError *jsonError;
		NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
		
		if (jsonError)
		{ NSLog(@"Error serialization Json"); return; }
	
		hotels = rootObject[@"Hotels"];
		for (NSDictionary *hotel in hotels)
		{
			Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
			
			newHotel.name = hotel[@"name"];
			newHotel.location = hotel[@"location"];
			newHotel.stars = hotel[@"stars"];
			
			
		rooms = hotel[@"rooms"];
			
		for (NSDictionary *room in rooms)
			{
			Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
			
			newRoom.roomNumber = room[@"number"];
			newRoom.rate = room[@"rate"];
			newRoom.beds = room[@"beds"];
			newRoom.hotel = newHotel;	
			
				NSLog(@"%@", newRoom);
				
			}
		}
		
		NSError *saveError;
		BOOL isSaved = [self.managedObjectContext save:&saveError];
		
		if (isSaved) {
			NSLog(@"Saved Successfully");
		} else {
			NSLog(@"%@", saveError.localizedDescription);
		}
	}
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	// Saves changes in the application's managed object context before the application terminates.
	[self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.romansalazar.GetaRoom" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GetaRoom" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GetaRoom.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
