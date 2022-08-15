//
//  generateQRTableViewController.m
//  TopCarsX
//
//  Created by Mike on 8/8/2022.
//

#import "generateQRTableViewController.h"
#import <CoreImage/CoreImage.h>

#define Artura @"https://gdurl.com/gNMy"
#define M4 @"https://gdurl.com/8BLt"
#define GTB @"https://gdurl.com/aMNz"
#define MSportCoupe @"https://gdurl.com/kv2g"
#define Vantage @"https://gdurl.com/wkTX"
#define Carrera @"https://gdurl.com/mqp1"
#define GR86 @"https://gdurl.com/rsl5"
#define Huracan @"https://gdurl.com/0irq"
#define MC20 @"https://gdurl.com/vBoc"
#define Emira @"https://gdurl.com/7bYH"

@interface generateQRTableViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property CarViewController * carViewController;
@property CarDetailsTableViewController * carDetailsTableViewController;
@end

@implementation generateQRTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.firestore = [FIRFirestore firestore];
    [[self carViewController] setFirestore:[self firestore]];
    

}

- (UIImage *)resizedImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate
{
    UIImage *imgResized = nil;
    CGFloat CGwidth = image.size.width * rate;
    CGFloat CGheight = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(CGwidth, CGheight));
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(contextRef, quality);
    [image drawInRect:CGRectMake(0, 0, CGwidth, CGheight)];
    imgResized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imgResized;
}


// Function to generate code of car object
-(void) generateQRCode {

    NSString* carModel = [[self car] model];
   
    NSLog(@"CAR %@", carModel);
   
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    // Conditional statements to check car model
    if ([carModel isEqualToString:@"Artura"]) {
        NSData *data = [Artura dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    } else if ([carModel isEqualToString:@"M4 Competition Convertible"]) {
        NSData *data = [M4 dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    } else if ([carModel isEqualToString:@"296 GTB Coupe"]) {
        NSData *data = [GTB dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    } else if ([carModel isEqualToString:@"220i M Sport Coupe"]) {
        NSData *data = [MSportCoupe dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    } else if ([carModel isEqualToString:@"Vantage F1 Coupe"]) {
        NSData *data = [Vantage dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    } else if ([carModel isEqualToString:@"911 Carrera GTS Coupe"]) {
        NSData *data = [Carrera dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    } else if ([carModel isEqualToString:@"GR86"]) {
        NSData *data = [GR86 dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    } else if ([carModel isEqualToString:@"Huracan"]) {
        NSData *data = [Huracan dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    } else if ([carModel isEqualToString:@"MC20 Coupe"]) {
        NSData *data = [MC20 dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    } else if ([carModel isEqualToString:@"Emira"]) {
        NSData *data = [Emira dataUsingEncoding:NSUTF8StringEncoding];
           [filter setValue:data forKey:@"inputMessage"];
    }
    
    
        // Instantiate a CIImage object in conjuntion to CIFilter to process an image from the data we gathered from car model
       CIImage *outputImage = [filter outputImage];

        //Evaluation context for Core Image processing
       CIContext *ciContext = [CIContext contextWithOptions:nil];
       CGImageRef cgImageRef = [ciContext createCGImage:outputImage
                                          fromRect:[outputImage extent]];

        // Object to represent image data
       UIImage *uiImage = [UIImage imageWithCGImage:cgImageRef
                                            scale:1.
                                      orientation:UIImageOrientationUp];

        // Instance an object of uiImage without interpolation
       UIImage *myResized = [self resizedImage:uiImage
                                withQuality:kCGInterpolationNone
                                       rate:5.0];
    
    //Assigned the generated image to our imageView
    self.imageView.image = myResized;
    
    // clean memory for allocated image
    CGImageRelease(cgImageRef);

}

// Action button to Generate code of car object by call the generateQRCode function
- (IBAction)didPressGenerateQRCode:(id)sender {
    [self generateQRCode];
}


@end
