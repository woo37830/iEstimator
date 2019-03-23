//
//  EstimatorViewController.m
//  NavBar
//
//  Created by John Wooten on 1/10/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "EstimatorViewController.h"
#import "EstimationModel.h"
#import "ValueController.h"
#import "StringEditorViewController.h"
#import "NumberViewController.h"
#import "DateViewController.h"
#import "PickerViewController.h"
#import "MyCustomCell.h"
#import "Constants.h"


@implementation EstimatorViewController

@synthesize myTableView, menuList, targetViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(EstimationModel *)aModel
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	model = aModel;
	self.title = [model name];
	self.menuList = [[NSMutableDictionary alloc] init];
	
	return self;
}

- (EstimationModel *) model	{
	return model;
}

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

- (void) viewDidAppear:(BOOL)animated	{
	//[self refreshFields];
	[myTableView reloadData];	
	[super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[self updateView];
	[myTableView reloadData];	
}

- (void)viewDidLoad
{
	// add our custom add button as the nav bar's custom right view
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"Reset"
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(addAction:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	editing = true;
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

- (ValueController *) controllerForKey:(int)key
{
	NSMutableDictionary *list = [menuList objectForKey:[NSString stringWithFormat:@"%d",key]];
	ValueController *c = [list objectForKey:kViewControllerKey];
	return c;
}
- (void) removeControllerForKey:(int)key
{
	NSMutableDictionary *list = [menuList objectForKey:[NSString stringWithFormat:@"%d",key]];
	[list removeObjectForKey:kViewControllerKey];
}

- (void)updateView
{
	ValueController *controller = [self controllerForKey:100];
	if( controller != nil )	{		 
		[model setExtInputs:[[controller value] intValue]];
		[self removeControllerForKey:100];
	}
	controller = [self controllerForKey:101];
	if( controller != nil )	{
		[model setExtOutputs:[[controller value] intValue]];
		[self removeControllerForKey:101];
	}
	controller = [self controllerForKey:102];
	if( controller != nil )	{
		[model setQueries:[[controller value] intValue]];
		[self removeControllerForKey:102];
	}
	controller = [self controllerForKey:103];
	if( controller != nil )	{
		[model setLogicalFiles:[[controller value] intValue]];
		[self removeControllerForKey:103];
	}
	controller = [self controllerForKey:104];
	if( controller != nil )	{
		[model setExtInterfaces:[[controller value] intValue]];
		[self removeControllerForKey:104];
	}
	// Allow explicit setting of FunctionPoints
	controller = [self controllerForKey:105];
	if( controller != nil )	{
		[model setFunctionPoints:[[controller value] intValue]];
		[self removeControllerForKey:105];
	}
	controller = [self controllerForKey:106];
	if( controller != nil )	{
		NSString *prtStr = [NSString stringWithFormat:@"%@", [controller value]];
		printf("\nability str is: %s",[[prtStr description] cStringUsingEncoding: [NSString defaultCStringEncoding]]); 
		[model setAbilityStr:[controller value]];
		[self removeControllerForKey:106];
	}
	controller = [self controllerForKey:107];
	if( controller != nil )	{
		[model setSystemType:[controller value]];
		[self removeControllerForKey:107];
	}
	controller = [self controllerForKey:108];
	if( controller != nil )	{
		[model setLanguage:[controller value]];
		[self removeControllerForKey:108];
	}
	// Allow explicit setting of SLOC
	controller = [self controllerForKey:109];
	if( controller != nil )	{
		[model setSLOC:[[controller value] intValue]];
		[self removeControllerForKey:109];
	}
	controller = [self controllerForKey:110];
	if( controller != nil )	{
		[model setSlocPPM:[[controller value] intValue]];
		[self removeControllerForKey:110];
	}
	controller = [self controllerForKey:111];
	if( controller != nil )	{
		[model setBlendedCostPerHour:[[controller value] floatValue]];
		[self removeControllerForKey:111];
	}
	controller = [self controllerForKey:112];
	if( controller != nil )	{
		[model setHoursPerMonth:[[controller value] intValue]];
		[self removeControllerForKey:112];
	}
	controller = [self controllerForKey:113];
	if( controller != nil )	{
		[model setAccuracyStr:[controller value]];
		[self removeControllerForKey:113];
	}
	controller = [self controllerForKey:202];
	if( controller != nil )	{
		[model setTeamSize:[[controller value] intValue]];
		[self removeControllerForKey:202];
	}
	[model update];
	
}
// This is where I reset the values for the model.
- (void)addAction:(id)sender
{
	// the add button was clicked, handle it here
	//editing = !editing;
	printf("\nReset button pressed");
	[model reset];
	[model update];
	[myTableView reloadData];
}

#pragma mark UITableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//printf("\nNumber of sections in tableView requested");
	return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	//printf("\nTitle for header requested for section %d", section);
	NSString *title = nil;
	switch (section) {
		case 0:
			title = @"";
			break;
		case 1:
			title = @"Input Data";
			break;
		case 2:
			title = @"Results";
			break;
		default:
			break;
	}
	return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//printf("\nnumber of rows in section %d requested", section);
	if (section == 0) return 1;
	if (section == 1) return 14;
	if (section == 2) return 4;
	else return 0;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	int selector = indexPath.section*100 + indexPath.row;
	UITableViewCellAccessoryType accessory = 0;
	if( editing )	{
		switch( selector )	{
			//case 105:
			//case 109:
			case 200:
				break;
			case 201:
			case 203:
				break;
			default:
				accessory =  UITableViewCellAccessoryDisclosureIndicator;
				break;
				
		}
	}
	return accessory;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//printf("\n data requested for row %d in section %d", indexPath.row, indexPath.section);
	MyCustomCell *cell = (MyCustomCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (cell == nil)
	{
		cell = [[[MyCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
	}
	
	
	// this will become a MyCustomCell withe label, value, and view (initially null).
	NSString *text = nil;
	NSString *title = nil;
	int selector = indexPath.section*100 + indexPath.row;
	NSString *theKey = [NSString stringWithFormat:@"%d",selector];
    switch( selector )
	{
		case 0:
			title = @"Model Name: ";
			text = [NSString stringWithFormat: @" %@     ",[model name]];
			self.title = [model name];
			break;
		case 100:
			title = @"Ext. Inputs: ";
			text = [NSString stringWithFormat: @"%d     ",
					[model extInputs] ];
			break;
		case 101:
			title = @"Ext. Outputs: "; 
			text = [NSString stringWithFormat: @"%d     ",
					[model extOutputs] ];
			break;
		case 102:
			title = @"Queries: ";
			text = [NSString stringWithFormat: @"%d     ",
					[model queries]];
			break;
		case 103:
			title = @"Logical Files: ";
			text = [NSString stringWithFormat: @"%d     ",
					[model logicalFiles]];	
			break;
		case 104:
			title = @"Ext. Interfaces: ";
			text = [NSString stringWithFormat: @"%d     ",
					[model extInterfaces]];
			break;
		case 105:
			title = @"Function Points: ";
			text = [NSString stringWithFormat: @"%d     ",
					[model functionPoints]];
			break;
		case 106:
			title = @"Ability: ";
			text = [NSString stringWithFormat: @"%@     ",
					[model abilityStr]];
			break;
		case 107:
			title = @"System Type: ";
			text = [NSString stringWithFormat: @"%@     ",
					[model systemType]];
			break;
		case 108:
			title = @"Language: ";
			text = [NSString stringWithFormat: @"%@     ",
					[model language]];
			break;
		case 109:
			title = @"SLOC: ";
			text = [NSString stringWithFormat: @"%d     ",
					[model sloc]];
			break;
		case 110:
			title = @"SLOC/PM: ";
			text = [NSString stringWithFormat: @"%d     ", [model slocPPM]];
			break;
		case 111:
			title = @"Blended Cost/Hr.";
			text = [NSString stringWithFormat: @"$%4.2f     ", [model blendedCostPerHour]];
			break;
		case 112:
			title = @"Hours/mo.: ";
			text = [NSString stringWithFormat: @"%d     ", [model hoursPerMonth]];
			break;
		case 113:
			title = @"Est. Accuracy: ";
			text = [NSString stringWithFormat: @"%@     ", [model accuracyStr]];
			break;
		case 200:
			title = @"Duration: ";
			text = [NSString stringWithFormat: @"%3.1f +/- %3.2f mo.     ", [model duration], [model stdDev]];
			break;
		case 201:
			title = @"Effort: ";
			text = [NSString stringWithFormat: @"%4.1f PM     ", [model effort]];
			break;
		case 202:
			title = @"Team Size: ";
			text = [NSString stringWithFormat: @"%d     ", [model teamSize]];
			break;
		case 203:
			title = @"Cost: ";
			text = [NSString stringWithFormat: @"$%6.0f     ", [model totalCost]];
			break;
		default:
			title = @"";
			text = @"Shoulders";
			// Will bring up team Viewer (and editor)
			// need to be able to add here.
	}
	//if( [menuList objectForKey:theKey] == nil )
	//{
		[menuList setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							 title, kTitleKey,
							 text, kExplainKey,
							 nil] forKey:theKey];
	//} else	{
	/*	NSMutableDictionary *item = [menuList objectForKey:theKey];
		if( selector == 109 )
			printf("\nSetting %s for value in 109", [text UTF8String]);
		[item setObject:text forKey:kExplainKey];			
		[item setObject:title forKey:kTitleKey];
	}*/
	cell.dataDictionary = [menuList objectForKey: theKey];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ValueController *controller = nil;
	if( editing )
	{
		int selector = indexPath.section*100 + indexPath.row;
		printf("\nselector = %d", selector);
		NSString *theKey = [NSString stringWithFormat:@"%d",selector];
		if( [menuList objectForKey: theKey] != nil )	{
			controller = [[menuList objectForKey:theKey] objectForKey:kViewControllerKey];
		}
		//if (controller == nil)
		if (true)
		{
			// the view controller has not been created yet, create it and set it to our menuList array
			
			// create a new dictionary with the new view controller
			//
			NSMutableDictionary *newItemDict = [NSMutableDictionary dictionaryWithCapacity:3];
			[newItemDict addEntriesFromDictionary: [menuList objectForKey: theKey]];	// copy the title and explain strings
			
			// which view controller do we create?
			switch	(selector)	{
				case 0:
					controller = [[StringEditorViewController alloc] initWithNibName:@"StringEditorViewController" bundle:nil target:model selector:@"name"
											];
					break;
				case 100:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"ExtInputs" value:[model extInputs]
											];
					printf("\ntVC created for 100");
					break;
				case 101:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"ExtOutputs" value:[model extOutputs]
											];
					break;
				case 102:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"Queries" value:[model queries]
											];
					break;
				case 103:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"LogicalFiles" value:[model logicalFiles]
											];
					break;
				case 104:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"ExtInterfaces" value:[model extInterfaces]
											];
					break;
				case 105:
					printf("\nReceived click on FunctionPoints");
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"FunctionPoints" value:[model functionPoints]
								  ];
					break;
				case 106:
					controller = [[PickerViewController alloc] initWithTitle:@"Ability" andValues:[model abilityKeys] withSelected:[model abilityStr]];
					break;
				case 107:
					controller = [[PickerViewController alloc] initWithTitle:@"System Type" andValues:[model systemTypeKeys] withSelected:[model systemType]];
					break;
				case 108:
                    controller = [[PickerViewController alloc] initWithTitle:@"Language" andValues:[model languageKeys] withSelected:[model language]];
					break;
				case 109:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"SLOC" value:[model sloc]
								  ];
					break;
				case 110:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"SLOC/PM" value:[model slocPPM]
								  ];
					break;
				case 111:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"Blended $/hr." value:[model accuracy]
								  ];
					break;
				case 112:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"Hours/mo." value:[model hoursPerMonth]
								  ];
					break;
				case 113:
                    controller = [[PickerViewController alloc] initWithTitle:@"Est. Accuracy" andValues:[model accuracyKeys] withSelected:[model accuracyStr]];
					break;
				case 202:
					controller = [[NumberViewController alloc] initWithNibName:@"NumberViewController" bundle:nil target:model label:@"Team Size" value:[model teamSize]
								  ];
					break;
				default:
					break;
			}
			if( controller != nil )	{
				
				// add the new view controller to the dictionary and then to the 'menuList' array
				[newItemDict setObject:controller forKey:kViewControllerKey];
				[menuList setObject:newItemDict	forKey:theKey];
			}
			// load the view control back in to push it
			
			controller = [[menuList objectForKey: theKey] objectForKey:kViewControllerKey];
		}
		
		// present the rest of the pages normally
		if( controller != nil )	{
			[[self navigationController] pushViewController:controller animated:YES];
			[controller release];
		}
	}
}




@end
