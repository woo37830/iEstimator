//
//  EstimatorViewController.h
//  NavBar
//
//  Created by John Wooten on 1/10/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstimationModel.h"
#import "ValueController.h"


@interface EstimatorViewController : UIViewController  <	UINavigationBarDelegate,
UITableViewDelegate, UITableViewDataSource,
UIActionSheetDelegate>	{
	EstimationModel *model;
	IBOutlet UITableView	*myTableView;
	NSMutableDictionary		*menuList;
	Boolean					editing;
	UIViewController		*targetViewController;
}

@property (nonatomic, retain) NSMutableDictionary *menuList;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) 	UIViewController *targetViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(EstimationModel *)aModel;
- (void)addAction:(id)sender;
- (void)updateView;
- (EstimationModel *)model;
- (ValueController *) controllerForKey:(int)key;
- (void) removeControllerForKey:(int)key;
@end
