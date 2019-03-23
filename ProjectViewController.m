#import "MyCustomCell.h";
#import "ProjectViewController.h"
#import "EstimationModel.h"
#import "ValueController.h"
#import "EstimatorViewController.h"
#import "TeamViewController.h"
#import "StringEditorViewController.h"
#import "DateViewController.h"
#import "NumberViewController.h"
#import "Constants.h"
#import "Utilities.h"

@implementation ProjectViewController

@synthesize myTableView, menuList, targetViewController, project;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil project:(Project *)aProject
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	[aProject retain];
	[project release];
	project = aProject;
	if (self)
	{
		// this will appear as the title in the navigation bar
		self.title = [project name];
		self.menuList = [[NSMutableDictionary alloc] init];
		targetViewController = nil;
		printf("\nPvC init self");
	}
	myTableView = [[UITableView alloc] init];
    myTableView.delegate = self;
    myTableView.dataSource = self;
	//printf("\nready to reload tableview data");
	[myTableView reloadData];
	printf("\nPvc completed initWithNibName");
	return self;
}

- (Project *) project		{
	return project;
}

- (void)dealloc
{
	[super dealloc];
	printf("\nPvC dealloc");
}

// Automatically invoked after -loadView
// This is the preferred override point for doing additional setup after -initWithNibName:bundle:
//
- (void)viewDidLoad
{
	// add our custom add button as the nav bar's custom right view
	/*UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"Edit"
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(addAction:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	*/
	editing = YES; // allows entering data via sub-views.
	printf("\nPvC completed viewDidLoad");
}

- (void)setEditing:(BOOL)edit animated:(BOOL)animated {
	[super setEditing:edit animated:animated];
    [myTableView setEditing:edit animated:animated];
}
- (UIViewController *) controllerForKey:(int)key
{
	NSMutableDictionary *list = [menuList objectForKey:[NSString stringWithFormat:@"%d",key]];
	return [list objectForKey:kViewControllerKey];	
}

- (void) updateView
{
	NSString *theKey = nil;

	[[project model] update];
	theKey = [self controllerForKey:0];
	NSMutableDictionary *list = [menuList objectForKey:theKey];
	self.title = [project name];
	[list setObject:[project name] forKey:kExplainKey];
	theKey = [self controllerForKey:1];
	list = [menuList objectForKey:theKey];
	[list setObject:[project client] forKey:kExplainKey];
	/*theKey = [menuList objectForKey:[self controllerForKey:10]];
	 list = [menuList objectForKey:theKey];
	 [list setObject:[NSString stringWithFormat: @"%3.1f +/- %3.2f mo.", [[project model] duration], [[project model] stdDev]]] ;
	 theKey = [menuList objectForKey:[self controllerForKey:11]];
	 list = [menuList objectForKey:theKey];
	 [list setObject:[NSString stringWithFormat: @"$%6.0f",
	 [[project model] totalCost]]];
	 */
	ValueController *controller = [self controllerForKey:13];
	if( controller != nil ) {
		[project setActualCost:[controller value]];
	} else	{
		printf("\ncontroller nil for key 13");
	}
	controller = [self controllerForKey:20];
	if( controller != nil ) {
		[project setProposedStart:[controller date]];
	} else	{
		printf("\ncontroller nil for key 20");
	}
	controller = [self controllerForKey:22];
	if( controller != nil )	{
		[project setActualStart:[controller date]];
	} else	{
		printf("\ncontroller nil for key 22");
	}
	controller = [self controllerForKey:23];
	if( controller != nil )
		[project setActualEnd:[controller date]];
	//self.navigationItem.rightBarButtonItem.title = @"Edit";
	printf("\nTurned off 'Done'");
	[project update]; // Need to update the end Date
	printf("\nValue of totalCost is %6.0f", [[project model] totalCost]);
	printf("\nValue of predictedEnd is %s", [[project predictedEndStr] UTF8String]);
	[myTableView reloadData];
}
- (void)addAction:(id)sender
{
	NSString *theKey = nil;
	// the add button was clicked, handle it here
	editing = !editing;
	if( editing )	{
		printf("\nEdit button pressed");
		self.navigationItem.rightBarButtonItem.title = @"Done";
	} else	{
	}	
	[myTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
	NSIndexPath *tableSelection = [myTableView indexPathForSelectedRow];
	[myTableView deselectRowAtIndexPath:tableSelection animated:NO];
	printf("\nProjectViewController: viewWillAppear");
	[[project model] update];
	[project update];
	printf("\nReady to reload project view");
	[self updateView];
	[myTableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
	printf("\nPvC completed viewDidAppear");
}

- (void) test	{
	printf("\nTest was pressed");
}

- (void) testAction:(id)sender	{
	[self test];
}

#pragma mark UITableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//printf("\nNumber of sections in tableView requested");
	if( kLevel == kEntry )
		return 3;
	return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	//printf("\nTitle for header requested for section %d", section);
	NSString *title = nil;
	switch (section) {
		case 0:
			title = @"";
			break;
		case 1:
			title = @"Summary";
			break;
		case 2:
			title = @"Dates";
			break;
		case 3:
			title = @"Teams";
			break;
		default:
			break;
	}
	return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//printf("\nnumber of rows in section %d requested", section);
	if (section == 0) return 3;
	if (section == 1) return 6;
	if (section == 2) return 4;
	if (section == 3) return 1;
	if (section == 4) return [[project teams] count];
	else return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	MyCustomCell *cell = (MyCustomCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (cell == nil)
	{
		cell = [[[MyCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
	}
	
	// this will be come a MyCustomCell withe label, value, and view (initially null).
	NSString *text = nil;
	NSString *title = nil;
	selector = indexPath.section*10 + indexPath.row;
	NSString *theKey = [NSString stringWithFormat:@"%d     ",selector];
    switch( selector )
	{
		case 0:
			title = @"Project: ";
			text = [NSString stringWithFormat: @"%@     ",[project name]];
			break;
		case 1:
			title = @"Client: ";
			text = [NSString stringWithFormat: @"%@     ",[project client]];
			break;
		case 2:
			title = [[project model] name];
			printf("\nThe model name is %s", [title UTF8String]);
			text = @"";
			break;
		case 10:
			title = @"Duration: ";
			text = [NSString stringWithFormat: @"%3.1f +/- %3.2f mo.     ", [[project model] duration], [[project model] stdDev]];
			break;
		case 11:
			title = @"Proposed Cost: ";
			text = [NSString stringWithFormat: @"$%6.0f     ",
					[[project model] totalCost]];
			printf("\nThe proposed cost has been reloaded for display with %6.0f",[[project model] totalCost]);
			break;
		case 12:
			title = @"Actual Duration: ";
			text = [NSString stringWithFormat: @"%3.1f mo.     ",
					[project actualDuration]];
			break;
		case 13:
			title = @"Actual Cost: ";
			text = [NSString stringWithFormat: @"$%6.0f     ",
					[project actualCost]];
			break;
		case 14:
			title = @"Percent Completion: ";
			text = [NSString stringWithFormat: @"%2.0f%c     ", [project percentComplete],'%'];
			break;
		case 15:
			title = @"Percent Cost: ";
			text = [NSString stringWithFormat: @"%2.0f%c     ", [project percentCost],'%'];
			break;
		case 20:
			title = @"Proposed Start: "; 
			text = [NSString stringWithFormat: @"%@      ",
					[project proposedStartStr]];
			break;
		case 21:
			title = @"Predicted End: ";
			text = [NSString stringWithFormat: @"%@      ",
					[project predictedEndStr]];
			printf("\nthe Predicted End has been reloaded for view with %s",[text UTF8String]);
			break;
		case 22:
			title = @"Actual Start: ";
			text = [NSString stringWithFormat: @"%@      ",
					[project actualStartStr]];	
			printf("\nthe Actual start has been reloaded for view with %s",[text UTF8String]);
			break;
		case 23:
			title = @"Actual End: ";
			text = [NSString stringWithFormat: @"%@      ",
					[project  actualEndStr]];
			break;
		default:
			title = @"Another Team";
			text = @"";
			break;
	}
	if( indexPath.section == 4 )	{
		title = [[project teamAtIndex:indexPath.row] name];
		text = @"";
	}
	//if( [menuList objectForKey:theKey] == nil )
	//{
		[menuList setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							 title, kTitleKey,
							 text, kExplainKey,
							 nil] forKey:theKey];
	//} 
	//NSMutableDictionary *item = [menuList objectForKey:theKey];
	//[item setObject:text forKey:kExplainKey];			
	//[item setObject:title forKey:kTitleKey];			

	cell.dataDictionary = [menuList objectForKey: theKey];
	//cell.text = text;
    return cell;
}


/*
 - (void)tableView:(UITableView *)tableView 
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
 forRowAtIndexPath:(NSIndexPath *)indexPath { 
 [tableView beginUpdates]; 
 if (editingStyle == UITableViewCellEditingStyleDelete) { 
 [menuList removeObjectAtIndex:indexPath.row]; 
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
 withRowAnimation:UITableViewRowAnimationFade]; 
 } 
 [tableView endUpdates]; 
 } 
 */
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	selector = indexPath.section*10 + indexPath.row;
	UITableViewCellAccessoryType accessory = 0;
	if( editing )	{
		switch( selector )	{
			case 21:
				break;
			case 10:
			case 11:
			case 12:
			case 14:
			case 15:
				break;
			default:
				accessory =  UITableViewCellAccessoryDisclosureIndicator;
				break;
		}	
	}
	if( indexPath.section == 3 || indexPath.section == 4 )	{
		accessory =  UITableViewCellAccessoryDisclosureIndicator;
	}
	return accessory;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	targetViewController = nil;
	if( 
	   (!editing && (indexPath.section == 3 || indexPath.section == 4 ) )
	   || editing )
	{
		
		selector = indexPath.section*10 + indexPath.row;
		NSString *theKey = [NSString stringWithFormat:@"%d",selector];
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
			switch	(selector)	{
				case 0:
					targetViewController = [[StringEditorViewController alloc] initWithNibName:@"StringEditorViewController" bundle:nil target:[self project] selector:@"name"
											];
					break;
				case 1:
					targetViewController = [[StringEditorViewController alloc] initWithNibName:@"StringEditorViewController" bundle:nil target:[self project] selector:@"client"
											];
					break;
				case 2:
				{				
					//NSString *projectName = [[menuList objectAtIndex: indexPath.row] objectForKey:kTitleKey];
					targetViewController = [[EstimatorViewController alloc] initWithNibName:@"EstimatorViewController" bundle:nil model:[[self project] model]];
					break;
				}				case 13:
					targetViewController = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:[self project] label:@"Actual Cost" value:[[self project] actualCost]
											];
					break;
					
				case 20:
					targetViewController = [[DateViewController alloc] initWithNibName:@"DateViewController" bundle:nil label:@"Proposed Start" value:[[self project] proposedStartStr]];
					break;
				case 22:
					targetViewController = [[DateViewController alloc] initWithNibName:@"DateViewController" bundle:nil label:@"Actual Start" value:[[self project] actualStartStr]];
					break;
				case 23:
					targetViewController = [[DateViewController alloc] initWithNibName:@"DateViewController" bundle:nil label:@"Actual End" value:[[self project] actualEndStr]];
					break;
					
				
					break;
			}
			if( indexPath.section == 4 )	{
				NSString *teamName = [[project teamAtIndex:indexPath.row] name];
				printf("\nSliding to %s",[teamName UTF8String]);
				targetViewController = [[TeamViewController alloc] initWithNibName:@"TeamViewController" bundle:nil team:[[self project] teamAtIndex:indexPath.row]]; // will have to change to send
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

			[myTableView reloadData];
			
		}
	}
}



@end
