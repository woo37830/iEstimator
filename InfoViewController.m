#import "InfoViewController.h"
#import "Constants.h"

@implementation InfoViewController
@synthesize	copyright, appName, helpText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    printf("\nmvc: InfoViewController initWithNibName");
	if (self)
	{
		// this will appear as the title in the navigation bar
		self.title = NSLocalizedString(@"InfoTitle", @"");
		//self.title = @"About ProjectEstimator";
	}
	
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

// fetch objects from our bundle based on keys in our Info.plist
- (id)infoValueForKey:(NSString*)key
{
	if ([[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:key])
		return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:key];
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
}

// Automatically invoked after -loadView
// This is the preferred override point for doing additional setup after -initWithNibName:bundle:
//
- (void)viewDidLoad
{
	self.view.backgroundColor = [UIColor whiteColor];	// use the table view background color
	
	//appName.text = [self infoValueForKey:@"CFBundleName"];
	//copyright.text = [self infoValueForKey:@"NSHumanReadableCopyright"];
	appName.text = @"iEstimator\nv1.2";
	copyright.text = @"Copyright 2009, ShouldersCorp Inc.";
	helpText.text = @"The iEstimator is used to estimate the duration in months of a software project.  The proposed begin, actual begin, actual cost to date, and other project items can be set.  In the Default Estimation Model, the metrics such as number of inputs, queries, etc. are set to estimates during the functional specifications.  If you are confident of your estimates then select that as the estimation Ability, also set your teams ability and other parameters.  Select the predominant language of the application or divide the application into several sub-projects.  The duration and its standard deviation based upon several thousand commercial projects with similar characteristics are provided.  Based upon the parameters, the number of person months, team size, and estimated costs are similarily provided.\nLater versions will add milestone predictions, risk alert graphics, and the ability to investigate changes in the team size taking schedule incompressibility into account.";
}

- (IBAction)dismissAction:(id)sender
{
	printf("\nThe dismiss Action has been clicked");
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
	// do something here as our view re-appears
}

- (IBAction) openBrowser:(id)sender
{
    NSURL *target = [[NSURL alloc] initWithString:@"http://jwooten37830.com/iEstimator"];
    [[UIApplication sharedApplication] openURL:target];
}


@end
