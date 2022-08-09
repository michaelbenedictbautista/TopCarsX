//
//  generateQRTableViewController.m
//  TopCarsX
//
//  Created by Mike on 8/8/2022.
//


#import "generateQRTableViewController.h"
#import <CoreImage/CoreImage.h>

#define Vantage @"https://gdurl.com/N8yt"

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

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImage *)resizeImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate
{
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}


//// function to generate code
-(void) generateQRCode {

    NSString* carModel = [[self car] model];
   
    NSLog(@"CAR %@", carModel);
   
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [Vantage dataUsingEncoding:NSUTF8StringEncoding];
       [filter setValue:data forKey:@"inputMessage"];

       CIImage *outputImage = [filter outputImage];

       CIContext *context = [CIContext contextWithOptions:nil];
       CGImageRef cgImage = [context createCGImage:outputImage
                                          fromRect:[outputImage extent]];


       UIImage *image = [UIImage imageWithCGImage:cgImage
                                            scale:1.
                                      orientation:UIImageOrientationUp];
//
////       // Resize without interpolating
       UIImage *resized = [self resizeImage:image
                                withQuality:kCGInterpolationNone
                                       rate:5.0];
    
    
    self.imageView.image = resized;
    
    CGImageRelease(cgImage);
    


   
    
    //[[self photoImageView] setImage:[UIImage imageNamed:@"220iImg"]];
    
    
//       self.imageView.image = resized;

}

- (IBAction)didPressGenerateQRCode:(id)sender {
    [self generateQRCode];
}


@end
