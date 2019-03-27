#import "MainViewController.h"
#import "InfoViewController.h"

#import "Team.h"
#import "Project.h"
#import "Resource.h"
#import "Utilities.h"

#import "ProjectViewController.h"

#import "MyCustomCell.h"
#import "Constants.h"	// contains the dictionary keys

enum PageIndices
{
	kPageOneIndex	= 0,
	kPageTwoIndex	= 1,
	kPageThreeIndex = 2,
	kPageFourIndex	= 3,
	kPageFiveIndex	= 4
};

@implementation MainViewController

@synthesize myTableView, addButtonItem, targetViewController, infoViewController;

- (void)awakeFromNib
{
    [super awakeFromNib];
	// make the title of this page the same as the title of this app
	//self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
	self.title = @"Projects";
	
	[self setMenuList:[[NSMutableArray alloc] init]];
	
	// We will lazily create our view controllers as the user requests them (at a later time),
	// but for now we will encase each title with an explanation text into a NSDictionary and add it to a mutable array.
	// This dictionary will be used by our table view data source to populate the text in each cell.
	//
	// When it comes time to create the corresponding view controller we will replace each NSDictionary.
	//
	// If you want to add more pages, simply call "addObject" on "menuList"
	// with an additional NSDictionary.  Note we use NSLocalizedString to load a localized version of its title.
	//
	//  Here we loop through Projects and addObjects name and client
	/*[menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
	 NSLocalizedString(@"PageOneTitle", @""), kTitleKey,
	 NSLocalizedString(@"PageOneExplain", @""), kExplainKey,
	 nil]];
	 */
	printf("\nmvc: awake from Nib called");
	UIApplication *app = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] addObserver:self	selector:@selector(applicationWillTerminate:)
												 name:UIApplicationWillTerminateNotification	object:app];
	printf("\nmvc: subscribed to 'application will terminate notification'");
    string = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"GitHash"];
    printf("\nmvc: GitHash: %s",[string UTF8String]);
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	if( ![[NSFileManager defaultManager] fileExistsAtPath:[Utilities dataFilePath]] )
	{
		printf("\nmvc: Initializing new application");
		[self initialize];
	} else	{
			printf("\nmvc: Loading data from archive storage");
		[self viewDidLoad];
	}
	//[pool release];
	[self buildMenuList];
	printf("\nmvc: menuList has %lu entries",[menuList count]);
	infoViewController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    printf("\nmvc: infoViewController initted");
	// add our custom button to show our modal view controller
	UIButton* modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[modalViewButton addTarget:self action:@selector(modalViewAction:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
	self.navigationItem.leftBarButtonItem = modalButton;
	//self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.addButtonItem = [[[UIBarButtonItem alloc] 
						   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
						   target:self
						   action:@selector(addButtonWasPressed)] autorelease];
	self.navigationItem.rightBarButtonItem = self.addButtonItem;
    printf("\nmvc: ready to release modalViewButton");
	//[modalViewButton release];
    printf("\nmvc: ready to reload data");
	[myTableView reloadData];
    printf("\nmvc: data was reloaded");
}

- (void) buildMenuList
{
	printf("\nmvc: buildMenuList");
	[menuList release];
	[self setMenuList:[[NSMutableArray alloc] init]];
	NSEnumerator *enumerator = [[self projects] objectEnumerator];
    id obj;
	
    while ( obj = [enumerator nextObject] ) {
		//printf( "\t%s\n", [[obj description]cStringUsingEncoding: [NSString defaultCStringEncoding]] );
		Project *project = (Project *) obj;
		printf("\nadding '%s' - '%s'", [[project name] UTF8String], [[project client] UTF8String]);
		[menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							 [project name], kTitleKey,
							 [project client], kExplainKey,
							 nil]];
    }
	
}

- (void) applicationWillTerminate:(NSNotification *)notification
{
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
								 initForWritingWithMutableData:data];
	printf("\nThere are %lu projects to encode",[projects count]);
	[archiver encodeObject:projects forKey:kDataKey];
	[archiver finishEncoding];
	[data writeToFile:[Utilities dataFilePath] atomically:YES];
	printf("\nApplication will terminate has written out projects with key: %s",[kDataKey UTF8String]);
	[projects release];
	[archiver release];
	[data release];
}

- (void) killHUD: (id) aHUD
{
	//[aHUD show:NO];
	[aHUD release];
}

- (void)viewDidLoad	{
	printf("\nmvc: viewDidLoad");
	NSString *filePath = [Utilities dataFilePath];
	if( [[NSFileManager defaultManager] fileExistsAtPath:filePath] )
	{
		NSData *data = [[NSMutableData alloc]
						initWithContentsOfFile:filePath];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
										 initForReadingWithData:data];
		printf("\nbeginning decoding archive of projects using key '%s'",[kDataKey UTF8String]);
		NSMutableDictionary *dictionary = [unarchiver decodeObjectForKey:kDataKey];
		printf("\nThe dictionary has been created");
		[self setProjects:dictionary];
		printf("\nJust before finishDecoding");
		[unarchiver finishDecoding];
		printf("\nJust before printProjects");
		[self printProjects];
		printf("\ncompleted decoding projects from archive");
		[unarchiver release];
		//[data release];
	}
}

- (void) printProjects
{
	printf("\nprojects has %lu elements", [[self projects] count]);
	NSEnumerator *enumerator = [[self projects] objectEnumerator];
	id obj;
	
	while ( obj = [enumerator nextObject] ) {
		//printf( "\t%s\n", [[obj description]cStringUsingEncoding: [NSString defaultCStringEncoding]] );
		Project *project = (Project *) obj;
		printf("\nchecking '%s' - '%s'", [[project name] UTF8String], [[project client] UTF8String]);
	}	
}

- (void) setProjects:(NSMutableDictionary *)aDictionary
{
	printf("\nReached setProjects");
	[aDictionary retain];
	if( projects != nil )	{
		[projects release];	
	}
	projects = aDictionary;
}
- (NSMutableDictionary *) projects
{
	return projects;
}

- (void) setMenuList:(NSMutableArray *)anArray
{
	[anArray retain];
	[menuList release];
	menuList = anArray;
}

- (NSMutableArray *) menuList
{
	return menuList;
}

- (Project *)findProject:(NSString *)aName
{
	NSEnumerator *enumerator = [[self projects] objectEnumerator];
	id obj;
	
	while ( obj = [enumerator nextObject] ) {
		//printf( "\t%s\n", [[obj description]cStringUsingEncoding: [NSString defaultCStringEncoding]] );
		Project *project = (Project *) obj;
		printf("\nchecking '%s' - '%s' against '%s'", [[project name] UTF8String], [[project client] UTF8String], [aName UTF8String]);
		if( [project name] == aName )
			return project;
	}	
	return nil;
}

- (void) initialize	{
	projects = [[NSMutableDictionary alloc] init];
	Project *project1 = [self createProjectWithName: @"Example" andClient: @"Client"];
	[projects setObject: project1 forKey: [project1 name] ];
	Project *project2 = [self createProjectWithName: @"Another" andClient: @"Client"];
	[projects setObject: project2 forKey: [project2 name] ];
}

- (Project *)createProjectWithName:(NSString *)aName andClient: (NSString *)aClient	{
	Team *team1 = nil;
	Team *team2 = nil;
	if( kLevel != kEntry)	{			
		team1 = [[Team alloc] init: @"Shoulders"];
		NSDate *today = [[NSDate alloc] init];
		NSDate *twoMonthsAgo = today;
		[team1 addResource: [[Resource alloc] init: @"Tom" last:@"Love" phone:@"800-555-1212" imageName:@"Icon.png" started:twoMonthsAgo 
											  role: @"PM" billout: 200.0f]];
		[team1 addResource: [[Resource alloc] init: @"John" last:@"Wooten" phone:@"800-555-1212" imageName:@"Icon.png" started:twoMonthsAgo 
											  role: @"Arch" billout: 175.0f]];
		[team1 print];
		team2 = [[Team alloc] init: @"ADP"];
		[team2 addResource: [[Resource alloc] init: @"Roger" last:@"Doofus" phone:@"800-555-1212" imageName:@"Icon.png" started:twoMonthsAgo
											  role: @"Dev." billout: 75.0f]];
		[team2 addResource: [[Resource alloc] init: @"Aziz" last:@"Abdul" phone:@"800-555-1212" imageName:@"Icon.png" started:today 
											  role: @"Arch" billout: 55.0f]];
		[team2 print];
	}
	printf("\nGoing to init the project %s",[aName UTF8String]);
	Project *project1 = [[Project alloc] init:aName client:aClient];
	if( kLevel != kEntry )	{		
		[project1 addTeam: team1];
		[project1 addTeam: team2];
	}
	[project1 print];
	return project1;
	}
	- (void)dealloc
	{
		[myTableView release];
		[menuList release];
		[infoViewController release];
		[addButtonItem release];
		[super dealloc];
	}
	
	// user clicked the "i" button, present InfoView as modal UIViewController
	- (IBAction)modalViewAction:(id)sender
	{
		// present page six as a modal child or overlay view
        [self presentViewController:infoViewController animated:YES completion:nil];
		//[[self navigationController] presentModalViewController:infoViewController animated:YES];
	}
	
#pragma mark UIViewController delegates
	
	//START:code.addButtonWasPressed:
	- (IBAction)addButtonWasPressed {
		printf("\nAdd button was pressed");
		Project *newProject = [self createProjectWithName:@"New Project" andClient: @"New Client"]; 
		[self addProject:newProject];
	}
	//END:code.addButtonWasPressed:
	
	//START:code.addProject:
	- (void)addProject: (Project *)aProject {
		[[self projects] setObject: aProject forKey: [aProject name] ];
		printf("\nProject %s added to list of projects",[[aProject name] UTF8String]);
		[self printProjects];
		printf("\nEnd of listing of projects");
		[menuList  addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  [aProject name], kTitleKey,
							  [aProject client], kExplainKey,
							  nil]];
		[myTableView reloadData];
	}
	
	- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
		[super setEditing:editing animated:animated];
		[myTableView setEditing:editing animated:animated];
	}
	- (void)buildMenuList:(BOOL)animated
	{
		printf("\nmvc: viewWillAppear");
		NSIndexPath *tableSelection = [myTableView indexPathForSelectedRow];
        printf("\nmvc: tableSelection done");
		[myTableView deselectRowAtIndexPath:tableSelection animated:NO];
        printf("\nmvc: deselectRowAtIndexPath done");
	}
	
	- (void)viewDidAppear:(BOOL)animated
	{
		printf("\nmvc: viewDidAppear");
		[self buildMenuList]; // This shows main correctly but messes up project!
		[myTableView reloadData];
	}
	
	
	
	
#pragma mark UITableView delegates
	
	- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath { 
		[tableView beginUpdates]; 
		if (editingStyle == UITableViewCellEditingStyleDelete) {
			NSString *pName = [[menuList objectAtIndex:indexPath.row] objectForKey:kTitleKey];
			[[self projects] removeObjectForKey:pName];
			[menuList removeObjectAtIndex:indexPath.row]; 
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
							 withRowAnimation:UITableViewRowAnimationFade]; 
		} 
		[tableView endUpdates]; 
	} 
	
//	- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView //accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
//	{
//		return UITableViewCellAccessoryDisclosureIndicator;
//	}
	
	- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
	{
		targetViewController = [[menuList objectAtIndex: indexPath.row] objectForKey:kViewControllerKey];
		if (targetViewController == nil)
		{
			// the view controller has not been created yet, create it and set it to our menuList array
			
			// create a new dictionary with the new view controller
			//
			NSMutableDictionary *newItemDict = [NSMutableDictionary dictionaryWithCapacity:3];
			[newItemDict addEntriesFromDictionary: [menuList objectAtIndex: indexPath.row]];	// copy the title and explain strings
			
			// which view controller do we create?
			NSString *projectName = [[menuList objectAtIndex: indexPath.row] objectForKey:kTitleKey];
			printf("\ncreating the controller for project '%s'",[projectName UTF8String]);
			[self printProjects];
			Project *aProject = [self findProject:projectName]; // Hokey way to find since below doesn't work
			//Project *aProject = [[self projects] objectForKey:projectName];
			if( aProject == nil )
				printf("\nThe project for the selected name is null");
			targetViewController = [[ProjectViewController alloc] initWithNibName:@"ProjectViewController" bundle:nil
				project:aProject];
			
			
			
			//add the new view controller to the dictionary and then to the 'menuList' array
			[newItemDict setObject:targetViewController forKey:kViewControllerKey];
			[menuList replaceObjectAtIndex:	indexPath.row withObject: newItemDict];
			[targetViewController release];
			
			// load the view control back in to push it
			
			targetViewController = [[menuList objectAtIndex: indexPath.row] objectForKey:kViewControllerKey];
		} 
		
		// present the rest of the pages normally
		[[self navigationController] pushViewController:targetViewController animated:YES];
	}
	
	
#pragma mark UITableView datasource methods
	
	- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
	{
		return 1;
	}
	
	- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
	{
		return [menuList count];
	}
	
	- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
	{
		MyCustomCell *cell = (MyCustomCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
		if (cell == nil)
		{
			cell = [[[MyCustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
		}
		
		NSMutableDictionary *item = [[self menuList] objectAtIndex:indexPath.row];
		//NSString *pName = [item objectForKey:kTitleKey];
		//NSString *cName = [item objectForKey:kExplainKey];
		//printf("\ncellForRow %d has name %s, and desc %s",indexPath.row, [pName UTF8String], [cName UTF8String]);
		/*Project *oldProject = [projects objectForKey:pName];
		if( oldProject != nil )	{
			[item setObject:[oldProject name] forKey:kTitleKey];
			NSString *text = [NSString stringWithFormat: @"%@     ",[oldProject client]];
			
			[item setObject:text forKey:kExplainKey];
		}
		*/
		// get the view controller's info dictionary based on the indexPath's row
		cell.dataDictionary = item;
		
		return cell;
	}
	
	@end
	
