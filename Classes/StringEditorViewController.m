//
//  StringEditorViewController.m
//  NavBar
//
//  Created by John Wooten on 1/10/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "StringEditorViewController.h"


@implementation StringEditorViewController

@synthesize addButtonItem, textField, label, string;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil target:(NSObject *)target selector:(NSString *)aSelector	{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.addButtonItem = [[[UIBarButtonItem alloc]
								initWithTitle:@"Save"
								style:UIBarButtonItemStyleBordered
								target:self
								action:@selector(saveAction:)] autorelease];
		self.navigationItem.rightBarButtonItem = self.addButtonItem;
		object = target;
		methodName = aSelector;
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
	if( methodName == @"name" )
	{
		//textField.text = [object setName:string];
        textField.text = @"Test";
	} else if (methodName == @"client" )
	{
		textField.text = [object setClient:string];
	}
	[self.navigationController popViewControllerAnimated:YES]; 

}
- (NSString *)value	{
	return self.string;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.text = @"Dummy";
	if( methodName == @"name" )
	{
		textField.text = [object name];
	} else if (methodName == @"client" )
	{
		textField.text = [object client];
	}
	[self updateString];
}
- (void)updateString {
	
	// Store the text of the text field in the 'string' instance variable.
	self.string = textField.text;
    // Set the text of the label to the value of the 'string' instance variable.
	label.text = self.string;
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	// When the user presses return, take focus away from the text field so that the keyboard is dismissed.
	if (theTextField == textField) {
		[textField resignFirstResponder];
        // Invoke the method that changes the greeting.
        [self updateString];
	}
	return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [textField resignFirstResponder];
    // Revert the text field to the previous value.
    textField.text = self.string; 
    [super touchesBegan:touches withEvent:event];
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
