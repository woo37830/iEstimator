//
//  DateViewController.m
//  NavBar
//
//  Created by John Wooten on 1/10/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "DateViewController.h"
#import "Utilities.h"


@implementation DateViewController

@synthesize addButtonItem,  datePicker, label, string, theDate;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil label:(NSString *)aLabel
				value:(NSString *)aValue {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.addButtonItem = [[[UIBarButtonItem alloc]
							   initWithTitle:@"Save"
							   style:UIBarButtonItemStyleBordered
							   target:self
							   action:@selector(saveAction:)] autorelease];
		self.navigationItem.rightBarButtonItem = self.addButtonItem;
		theLabel = aLabel;
    }
	if( aValue != nil )
		theDate = [Utilities dateStrToDate:aValue];
	else
		theDate = [[NSDate alloc] init];
    return self;
}

#pragma mark UIViewController delegates

- (void)saveAction:(id)sender {
	printf("\nSave button was pressed");
	[self setDate:[datePicker date]];	
	// Invoke the method that changes the greeting.
	[self updateString];
	[self.navigationController popViewControllerAnimated:YES]; 

}

- (void)setDate:(NSDate *)aDate
{
	theDate = aDate;
}

- (NSDate *)date	{
	return theDate;
}

- (NSString *)value	{
	printf("\nreturning %s", [[[NSString stringWithFormat:@"%@",label.text] description] cStringUsingEncoding: [NSString defaultCStringEncoding]]);
	return label.text;
}

- (void)updateString {
	
	// Store the text of the text field in the 'string' instance variable.
	self.string = [Utilities dateToDateStr:theDate];
    // Set the text of the label to the value of the 'string' instance variable.
	label.text = self.string;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	if( theDate == nil )
		printf("\nviewDidLoad finds theDate is nil");
	[datePicker setDate:theDate];
	self.title = theLabel;
	[self updateString];
	
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
	[theDate release];
    [super dealloc];
}


@end
