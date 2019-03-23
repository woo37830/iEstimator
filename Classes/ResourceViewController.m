//
//  ResourceViewController.m
//  NavBar
//
//  Created by John Wooten on 1/16/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//  TODO:  Add if editing, click on photo brings up image selection with camera option
//         Also if click on any part of personal info, bring up personal information edit panel ( with ability to select from
//		   contacts?
//

#import "ResourceViewController.h"
#import "DateViewController.h"
#import "NumberViewController.h"
#import "ValueController.h"
#import "Resource.h"
#import "MyCustomCell.h"
#import "Constants.h"


@implementation ResourceViewController

@synthesize	targetViewController, myTableView, menuList,
	totalCostLabel, resource, photo, fName, lName, roleLabel, phoneLabel;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil resource:(Resource *)aResource {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if( self ) {
		self.resource = aResource;
		self.title = [resource fName];
		self.menuList = [[NSMutableDictionary alloc] init];
		photo = [[UIImageView alloc] initWithFrame:CGRectZero];
		fName = [[UILabel alloc] initWithFrame:CGRectZero];
		lName = [[UILabel alloc] initWithFrame:CGRectZero];
		roleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
	myTableView = [[UITableView alloc] init];
	myTableView.autoresizesSubviews = YES;
	myTableView.delegate = self;
	myTableView.dataSource = self;
	if( self.navigationItem.rightBarButtonItem == nil )	{
		printf("\nAdding the addButton");	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"Edit"
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(addAction:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;	
		editing = false;
	}
	[myTableView reloadData];
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[photo setImage:[UIImage imageNamed:@"Icon.png"]]; // default 
	fName.text = [resource fName];
	lName.text = [resource lName];
	roleLabel.text = [resource role];
	phoneLabel.text = [resource phone];
	
	totalCostLabel.text = [NSString stringWithFormat:@"$%6.0f",[resource totalCost]];
	if( editing )	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSetLineWidth(context, 5.0);
		//CGContextSetStrokeColor(context, [UIColor redColor]);
		float imgWidth = 64.0f;
		float imgHeight = 64.0f;
		float imgX = 50.0f;
		float imgY = 50.0f;
		
		float diff = fabs(imgWidth - imgHeight);
		
		//CGRect theRect = CGMakeRect(0, 0, 100, 100);
		//CGContextAddEllipseInRect(context, theRect);
		//CGContextDrawPath(context, kCGPathFillStroke);
	}
	
	[myTableView reloadData];
}

- (void)setEditing:(BOOL)edit animated:(BOOL)animated {
		[super setEditing:edit animated:animated];
	[myTableView setEditing:edit animated:animated];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (ValueController *) controllerForKey:(int)key
{
	NSMutableDictionary *list = [menuList objectForKey:[NSString stringWithFormat:@"%d",key]];
	return [list objectForKey:kViewControllerKey];	
}

- (void)addAction:(id)sender
{
	// the add button was clicked, handle it here
	editing = !editing;
	if( editing )	{
		printf("\nEdit button pressed");
		self.navigationItem.rightBarButtonItem.title = @"Done";
	} else	{
		self.navigationItem.rightBarButtonItem.title = @"Edit";
		printf("\nTurned off 'Done'");
		ValueController *controller = [self controllerForKey:0];
		if( controller != nil )
			[resource setStartDate:[controller date]];
		controller = [self controllerForKey:1];
		if( controller != nil )
			[resource setEndDate:[controller date]];
		controller = [self controllerForKey:2];
		if( controller != nil )
			[resource setBilloutRate:[[controller value] floatValue]];
		controller = [self controllerForKey:3];
		if( controller != nil )
			[resource setHoursPerMonth:[[controller value] intValue]];
	}
	[self viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	//self.navigationItem.rightBarButtonItem.title = @"Edit";
	//editing = false;
	//[self viewDidLoad];
}

#pragma mark UITableView delegates

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellAccessoryType accessory = 0;
	if( editing )	{
				accessory =  UITableViewCellAccessoryDisclosureIndicator;
	}
	return accessory;
}

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath { 
	
} 

#pragma mark UITableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	printf("\nNumber of sections in tableView requested");
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *theCell = nil;
	printf("\n cell For row at index path requested, section = %d, row = %d",indexPath.section, indexPath.row);
		
	MyCustomCell *cell = (MyCustomCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (cell == nil)
	{
		printf("\ncreating cell at row %d", indexPath.row);
		cell = [[[MyCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
	}
	
		NSString *title = nil;
		NSString *text = nil;
		switch( indexPath.row )	{
			case 0:
				title = @"Start Date: ";
				text =  [resource startDateStr];
				break;
			case 1:
				title = @"End Date: ";
				text = [resource endDateStr];
				break;
			case 2:
				title = @"Billout Rate: ";
				text = [NSString stringWithFormat:@"%5.2f", [resource billoutRate]];
				break;
			case 3:
				title = @"Hours/mo. ";
				text = [NSString stringWithFormat:@"%3d",[resource hoursPerMonth]];
				break;
			default:
				break;
		}
		NSString *theKey = [NSString stringWithFormat:@"%d",indexPath.row];
	printf("\nValue for row %d is %s, %s", indexPath.row, [title UTF8String], [text UTF8String]);
		[menuList setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							 title, kTitleKey,
							 text, kExplainKey,
							 nil] forKey:theKey];

		cell.dataDictionary = [menuList objectForKey: theKey];
		theCell = cell;
	return theCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	targetViewController = nil;
	if( editing )
	{
		
		NSString *theKey = [NSString stringWithFormat:@"%d",indexPath.row];
		if( [menuList objectForKey: theKey] != nil )	{
			targetViewController = [[menuList objectForKey:theKey] objectForKey:kViewControllerKey];
		}
		if (targetViewController == nil)
		{
			// the view controller has not been created yet, create it and set it to our menuList array
			
			// create a new dictionary with the new view controller
			//
			NSMutableDictionary *newItemDict = [NSMutableDictionary dictionaryWithCapacity:3];
			[newItemDict addEntriesFromDictionary: [menuList objectForKey: theKey]];	// copy the title and explain strings
			
			// which view controller do we create?
			switch	(indexPath.row)	{
				case 0:
					targetViewController = [[DateViewController alloc] initWithNibName:@"DateViewController" bundle:nil label:@"Start Date" value:[resource startDateStr]];
					break;
				case 1:
					targetViewController = [[DateViewController alloc] initWithNibName:@"DateViewController" bundle:nil label:@"End Date" value:[resource endDateStr]];
					break;
				case 2:
					targetViewController = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:resource label:@"Billout" value:[resource billoutRate]
											];
					break;
				case 3:
					targetViewController = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:resource label:@"Hours/mo." value:[resource hoursPerMonth]
											];
					break;
			}
			if( targetViewController != nil )	{
				
				// add the new view controller to the dictionary and then to the 'menuList' array
				[newItemDict setObject:targetViewController forKey:kViewControllerKey];
				[menuList setObject:newItemDict	forKey:theKey];
				//[targetViewController release];
			}
			// load the view control back in to push it
			
			targetViewController = [[menuList objectForKey: theKey] objectForKey:kViewControllerKey];
		}
		
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


- (void)dealloc {
    [super dealloc];
}


@end
