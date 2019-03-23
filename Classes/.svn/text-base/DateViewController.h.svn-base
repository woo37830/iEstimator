//
//  DateViewController.h
//  NavBar
//
//  Created by John Wooten on 1/10/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValueController.h"


@interface DateViewController :ValueController {
	UIBarButtonItem			*addButtonItem;
	IBOutlet UIDatePicker   *datePicker;
	IBOutlet UILabel *label;
	NSString *string;
	
	NSString *theLabel;
	NSString *theValue;
	NSDate   *theDate;
}

@property (nonatomic, retain) UIBarButtonItem *addButtonItem;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, retain) NSDate *theDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil label:(NSString *)aLabel
				value:(NSString *)aValue;
- (void)updateString;
- (void)saveAction:(id)sender;
- (NSString *) value;
- (void) setDate:(NSDate *)aDate;
- (NSDate *) date;
@end
