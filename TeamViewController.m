//
//  TeamViewController.m
//  NavBar
//
//  Created by John Wooten on 1/16/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "TeamViewController.h"
#import "ResourceViewController.h"
#import "MyCustomCell.h"
#import "Team.h"
#import "Resource.h"
#import "Constants.h"
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@implementation TeamViewController

@synthesize myTableView, menuList, targetViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil team:(Team *)aTeam {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	team = aTeam;
	printf("\n initwith aTeam = %s\n",[[aTeam name] UTF8String]);
	if( self ) {
		self.title = [team name];
		self.menuList = [[NSMutableArray alloc] init];
		myTableView.delegate = self;
		myTableView.dataSource = self;
		targetViewController = nil;
    }
	myTableView = [[UITableView alloc] init];
	myTableView.delegate = self;
	myTableView.dataSource = self;
	// We will lazily create our view controllers as the user requests them (at a later time),
	// but for now we will encase each title with an explanation text into a NSDictionary and add it to a mutable array.
	// This dictionary will be used by our table view data source to populate the text in each cell.
	//
	// When it comes time to create the corresponding view controller we will replace each NSDictionary.
	//
	// If you want to add more pages, simply call "addObject" on "menuList"
	// with an additional NSDictionary.
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSMutableArray *resources = [team resources];
    NSEnumerator *enumerator = [resources objectEnumerator];
    id obj;
	
    while ( obj = [enumerator nextObject] ) {
        printf( "\t%s\n", [[obj description]cStringUsingEncoding: [NSString defaultCStringEncoding]] );
		Resource *resource = (Resource *) obj;
		[menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							 [resource fName], kTitleKey,
							 [resource role], kExplainKey,
							 nil]];
    }
	//[pool release];
	
	[myTableView reloadData];
    return self;
}

- (void)dealloc {
    [super dealloc];
}


- (void)viewDidLoad
{
	// add our custom add button as the nav bar's custom right view
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"Add"
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(addAction:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	editing = false;
}

- (void)setEditing:(BOOL)edit animated:(BOOL)animated {
	[super setEditing:edit animated:animated];
    [myTableView setEditing:edit animated:animated];
}
- (UIViewController *) controllerForKey:(int)key
{
	NSMutableDictionary *list = [menuList objectAtIndex:key];
	return [list objectForKey:kViewControllerKey];	
}

// Handle the tap on a userName
/*
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
	  shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	//Contact *contact = [[Contact alloc] initWithRef:person];
	//printf("\nPicked : %s", [[contact fullName] UTF8String]);
	id theProperty = (id)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	printf("\nPicked %s", [theProperty UTF8String]);
	Resource *resource = [[Resource alloc] init: @"fName" last: @"lName" phone: @"900-555-1212" imageName: nil started: nil role: @"aRole" billout: 0.0f];

	if( ABPersonHasImageData(person) )	{
		UIImage *img = [UIImage imageWithData:(NSData *) ABPersonCopyImageData(person)];
		[resource setImg:img];
	}
	[team addResource:resource];
	[menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
						 [resource fName], kTitleKey,
						 [resource role], kExplainKey,
						 nil]];
	return NO;
}

- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
	// These three lines in for testing in simulator
	Resource *resource = [[Resource alloc] init: @"fName" last: @"lName" phone: @"900-555-1212" imageName: nil started: nil role: @"aRole" billout: 0.0f];
	[team addResource:resource];
	[menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
						 [resource fName], kTitleKey,
						 [resource role], kExplainKey,
						 nil]];
	
	[self dismissModalViewControllerAnimated:YES];
	[peoplePicker release];
}

- (void)addAction:(id)sender
{
	// the add button was clicked, handle it here
	editing = !editing;
	if( editing )	{
		printf("\nAdd button pressed");
		self.navigationItem.rightBarButtonItem.title = @"Done";
		ABPeoplePickerNavigationController *ab = [[ABPeoplePickerNavigationController alloc] init];
		[ab setPeoplePickerDelegate:self];
	[self presentModalViewController:ab  animated:YES];
	} else	{
		self.navigationItem.rightBarButtonItem.title = @"Add";
		printf("\nTurned off 'Done'");
	}	
	[myTableView reloadData];
}
*/
- (void)viewWillAppear:(BOOL)animated
{
	NSIndexPath *tableSelection = [myTableView indexPathForSelectedRow];
	[myTableView deselectRowAtIndexPath:tableSelection animated:NO];
	[myTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
	self.navigationItem.rightBarButtonItem.title = @"Add";
	editing = false;
}

#pragma mark UITableView delegates

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath { 
	printf("\n request for edit stile at %d", indexPath.row);
	[tableView beginUpdates]; 
	if (editingStyle == UITableViewCellEditingStyleDelete) { 
		[menuList removeObjectAtIndex:indexPath.row]; 
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						 withRowAnimation:UITableViewRowAnimationFade]; 
	} 
	[tableView endUpdates]; 
} 

#pragma mark UITableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	printf("\nNumber of sections in tableView requested");
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *title = nil;
	switch (section) {
		case 0:
			title = @"Resources";
			break;
		default:
			break;
	}
	printf("\nreturning title %s for header requested for section %d", [title UTF8String], section);
	return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	printf("\nnumber of rows in section %d requested", section);
	int items = 0;
	if (section == 0) 
		items = [team resourceCount];
	printf("\n returning row count for section %d = %d", section, items);

	return items;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	printf("\n cell For row at index path requested, section = %d, row = %d",indexPath.section, indexPath.row);
	MyCustomCell *cell = (MyCustomCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (cell == nil)
	{
		printf("\ncreating cell at row %d", indexPath.row);
		cell = [[[MyCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
	}
	
	Resource *resource = [team resourceAtIndex: indexPath.row];
	NSString *title = [resource fName];
	NSString *text = [NSString stringWithFormat: @"%@     ",[resource role]];
	printf("\nValue for row %d is %s, %s", indexPath.row, [title UTF8String], [text UTF8String]);
	NSMutableDictionary *item = [menuList objectAtIndex:indexPath.row];
	[item setObject:title forKey:kTitleKey];
	[item setObject:text forKey:kExplainKey];
	
	// get the view controller's info dictionary based on the indexPath's row
	cell.dataDictionary = [menuList objectAtIndex:indexPath.row];
	
	return cell;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	printf("\nrequest for accessory type at row %d", indexPath.row);
	return UITableViewCellAccessoryDisclosureIndicator;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	targetViewController = nil;
	if( true )	{
		
		/*if( [menuList objectAtIndex:indexPath.row] != nil )	{
			targetViewController = [[menuList objectAtIndex:indexPath.row] objectForKey:kViewControllerKey];
		}
		if (targetViewController == nil)
		{
		 */
			// the view controller has not been created yet, create it and set it to our menuList array
			
			// create a new dictionary with the new view controller
			//
			NSMutableDictionary *newItemDict = [NSMutableDictionary dictionaryWithCapacity:3];
			[newItemDict addEntriesFromDictionary: [menuList objectAtIndex:indexPath.row]];	// copy the title and explain strings
			
			targetViewController = [[ResourceViewController alloc] initWithNibName:@"ResourceViewController"bundle:nil resource:[team resourceAtIndex:indexPath.row]
											];
			if( targetViewController != nil )	{
				
				// add the new view controller to the dictionary and then to the 'menuList' array
				[newItemDict setObject:targetViewController forKey:kViewControllerKey];
				[menuList replaceObjectAtIndex:indexPath.row withObject:newItemDict];
				//[targetViewController release];
			}
			// load the view control back in to push it
			
			targetViewController = [[menuList objectAtIndex:indexPath.row] objectForKey:kViewControllerKey];
		//}
		
		// present the rest of the pages normally
		if( targetViewController != nil )	{
			if( [self navigationController] == nil )	{
				printf("\nnavigationController is null");
			}
			[[self navigationController] pushViewController:targetViewController animated:YES];
			
			//[myTableView reloadData];
			
		}
	}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}



@end
