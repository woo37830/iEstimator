#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
{
	IBOutlet UILabel *appName;
    IBOutlet UILabel *hashCode;
	IBOutlet UILabel *copyright;
	IBOutlet UITextView *helpText;
    NSString *hashText;
}
@property (nonatomic, retain) IBOutlet UILabel *appName;
@property (nonatomic, retain) IBOutlet UILabel *hashCode;
@property (nonatomic, retain) IBOutlet UILabel *copyright;
@property (nonatomic, retain) IBOutlet UITextView *helpText;

- (void)viewDidLoad;
- (IBAction)dismissAction:(id)sender;
- (IBAction) openBrowser:(id)sender;

@end
