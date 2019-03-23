//
//  NumberViewController.h
//  NavBar
//
//  Created by John Wooten on 1/10/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValueController.h"


@interface NumberViewController : ValueController {
	UIBarButtonItem			*addButtonItem;
	IBOutlet UITextField *textField;
	IBOutlet UILabel *label;
	NSString *string;
	NSObject	*object;
	NSString	*theLabel;
	NSString	*theValue;
}

@property (nonatomic, retain) UIBarButtonItem *addButtonItem;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, copy) NSString *string;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil target:(NSObject *)project label:(NSString *)aLabel value:(int)aValue;
- (void)updateString;
- (void)saveAction:(id)sender;
- (NSString *)value;

@end
