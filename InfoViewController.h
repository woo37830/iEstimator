#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
{
	IBOutlet UILabel *appName;
	IBOutlet UILabel *copyright;
	IBOutlet UITextView *helpText;
}
@property (nonatomic, retain) IBOutlet UILabel *appName;
@property (nonatomic, retain) IBOutlet UILabel *copyright;
@property (nonatomic, retain) IBOutlet UITextView *helpText;

- (IBAction)dismissAction:(id)sender;
- (IBAction) openBrowser:(id)sender;

@end
