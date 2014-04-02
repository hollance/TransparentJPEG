
#import "ViewController.h"
#import "UIImage+MHCombineAlpha.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation ViewController
{
	UIImage *_sourceImage;
	UIImage *_alphaImage;
	UIImage *_convertedImage;
	UIImage *_originalImage;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	// Note: The project includes the test images at various quality levels.
	// The lower the quality, the higher the level of compression, but at some
	// point you start to see too many artifacts. Keep in mind that the source
	// and alpha images may be compressed at different levels.

#if 1
	NSString *sourceImageName = @"Bird-Source-Q40.jpg";
	NSString *alphaImageName = @"Bird-Alpha-Q40.jpg";
	NSString *originalImageName = @"Bird.png";
#else
	NSString *sourceImageName = @"Test-Source-Q40-White.jpg";
	NSString *alphaImageName = @"Test-Alpha-Q40.jpg";
	NSString *originalImageName = @"Test.png";
#endif

	UIColor *color = [UIColor whiteColor];
	_sourceImage = [UIImage imageNamed:sourceImageName];
	_alphaImage = [UIImage imageNamed:alphaImageName];
	_convertedImage = [_sourceImage mh_combineWithAlphaImage:_alphaImage backgroundColor:color];
	_originalImage = [UIImage imageNamed:originalImageName];

	self.imageView.image = _convertedImage;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)imageSegmentChanged:(UISegmentedControl *)sender
{
	if (sender.selectedSegmentIndex == 0)
		self.imageView.image = _convertedImage;
	else if (sender.selectedSegmentIndex == 1)
		self.imageView.image = _sourceImage;
	else if (sender.selectedSegmentIndex == 2)
		self.imageView.image = _alphaImage;
	else if (sender.selectedSegmentIndex == 3)
		self.imageView.image = _originalImage;
}

- (IBAction)backgroundSegmentChanged:(UISegmentedControl *)sender
{
	if (sender.selectedSegmentIndex == 0)
		self.view.backgroundColor = [UIColor grayColor];
	else if (sender.selectedSegmentIndex == 1)
		self.view.backgroundColor = [UIColor whiteColor];
	else if (sender.selectedSegmentIndex == 2)
		self.view.backgroundColor = [UIColor blackColor];
}

@end
