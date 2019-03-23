//
//  NumberViewController.m
//  NavBar
//
//  Created by John Wooten on 1/10/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "NumberViewController.h"


@implementation NumberViewController

@synthesize addButtonItem, textField, label, string;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil target:(NSObject *)project label:(NSString *)aLabel value:(int)aValue {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.addButtonItem = [[[UIBarButtonItem alloc]
							   initWithTitle:@"Save"
							   style:UIBarButtonItemStyleBordered
							   target:self
							   action:@selector(saveAction:)] autorelease];
		self.navigationItem.rightBarButtonItem = self.addButtonItem;
		theLabel = aLabel;
		theValue = [NSString stringWithFormat:@"%d", aValue];

    }
    return self;
}

#pragma mark UIViewController delegates
		 


//START:code.addButtonWasPressed:
- (void)saveAction:(id)sender {
	printf("\nSave button was pressed");
	[textField resignFirstResponder];
	// Invoke the method that changes the greeting.
	[self updateString];
	[self.navigationController popViewControllerAnimated:YES]; 
}

- (NSString *)value	{
	return label.text;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
- (void)updateString {
	
	// Store the text of the text field in the 'string' instance variable.
	self.string = textField.text;
    // Set the text of the label to the value of the 'string' instance variable.
	label.text = self.string;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	[textField setText:theValue];
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
    [super dealloc];
}


@end
