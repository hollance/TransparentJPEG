
#import "ViewController.h"
#import "UIImage+MHCombineAlpha.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation ViewController
{
	UIImage *sourceImage;
	UIImage *alphaImage;
	UIImage *convertedImage;
	UIImage *originalImage;
}

@synthesize imageView;

- (void)viewDidLoad
{
	[super viewDidLoad];

	//NSString *sourceImageName = @"Test-Source-Q40-White.jpg";
	//NSString *alphaImageName = @"Test-Alpha-Q40.jpg";
	//NSString *originalImageName = @"Test.png";

	NSString *sourceImageName = @"Bird-Source-Q40.jpg";
	NSString *alphaImageName = @"Bird-Alpha-Q40.jpg";
	NSString *originalImageName = @"Bird.png";

	UIColor *color = [UIColor whiteColor];
	sourceImage = [UIImage imageNamed:sourceImageName];
	alphaImage = [UIImage imageNamed:alphaImageName];
	convertedImage = [sourceImage mh_combineWithAlphaImage:alphaImage backgroundColor:color];
	originalImage = [UIImage imageNamed:originalImageName];

	self.imageView.image = convertedImage;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)imageSegmentChanged:(UISegmentedControl *)sender
{
	if (sender.selectedSegmentIndex == 0)
		self.imageView.image = convertedImage;
	else if (sender.selectedSegmentIndex == 1)
		self.imageView.image = sourceImage;
	else if (sender.selectedSegmentIndex == 2)
		self.imageView.image = alphaImage;
	else if (sender.selectedSegmentIndex == 3)
		self.imageView.image = originalImage;
}

- (IBAction)backgroundSegmentChanged:(UISegmentedControl *)sender
{
	if (sender.selectedSegmentIndex == 0)
		self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	else if (sender.selectedSegmentIndex == 1)
		self.view.backgroundColor = [UIColor whiteColor];
	else if (sender.selectedSegmentIndex == 2)
		self.view.backgroundColor = [UIColor blackColor];
}

@end
