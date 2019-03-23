//
//  TeamViewController.h
//  NavBar
//
//  Created by John Wooten on 1/16/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface TeamViewController : UIViewController <	UINavigationBarDelegate,
	UITableViewDelegate, UITableViewDataSource,
	UIActionSheetDelegate>
{ //, ABPeoplePickerNavigationControllerDelegate
	Team *team;
	IBOutlet UITableView	*myTableView;
	NSMutableArray			*menuList;
	Boolean					editing;
	UIViewController		*targetViewController;
	int						selector;
	
}
@property (nonatomic, retain) NSMutableArray *menuList;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) 	UIViewController *targetViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil team:(Team *)aTeam;
@end
