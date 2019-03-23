//
//  ResourceViewController.h
//  NavBar
//
//  Created by John Wooten on 1/16/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Resource.h"
#import "ValueController.h"


@interface ResourceViewController : UIViewController <	UINavigationBarDelegate,
UITableViewDelegate, UITableViewDataSource,
UIActionSheetDelegate> {
	Resource				*resource;
	Boolean					editing;
	UIViewController		*targetViewController;
	IBOutlet UITableView	*myTableView;
	NSMutableDictionary		*menuList;
	IBOutlet UILabel		*totalCostLabel;
	IBOutlet UIImageView	*photo;
	IBOutlet UILabel		*fName;
	IBOutlet UILabel		*lName;
	IBOutlet UILabel		*roleLabel;
	IBOutlet UILabel		*phoneLabel;
	
}
@property (nonatomic, retain)   NSMutableDictionary *menuList;
@property (nonatomic, retain) 	UIViewController *targetViewController;
@property (nonatomic, retain)	UITableView		*myTableView;
@property (nonatomic, retain) 	UILabel			 *totalCostLabel;
@property (nonatomic, retain)   Resource		 *resource;
@property (nonatomic, retain) UIImageView	*photo;
@property (nonatomic, retain) UILabel		*fName;
@property (nonatomic, retain) UILabel		*lName;
@property (nonatomic, retain) UILabel		*roleLabel;
@property (nonatomic, retain) UILabel		*phoneLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil resource:(Resource *)aResource;
- (ValueController *) controllerForKey:(int)key;	
@end
