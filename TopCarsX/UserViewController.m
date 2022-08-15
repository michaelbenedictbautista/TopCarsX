//
//  UserViewController.m
//  TopCarsX
//
//  Created by Mike on 31/7/2022.
//

#import "UserViewController.h"
#import "CarsTableViewController.h"
#import <WebKit/WebKit.h>// to incorporate web content

@interface UserViewController ()
@property(strong,nonatomic) WKWebView *webView;


@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Adjust the size of the embedded scrollview
    _UserScrollView.contentSize = CGSizeMake(317, 950);
    
//    _UserScrollView.frame = CGRectMake(0,0,950,950);
//    _UserScrollView.contentSize = CGSizeMake(_UserScrollView.frame.size.width, _UserScrollView.frame.size.height);
//
    

}

//-(void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    [[self UserScrollView] layoutIfNeeded];
////    _UserScrollView.contentSize =_UserContentView.bounds.size;
//}


// Will be called when system determines that the amount of available memory is low
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender {

}

// Set hardcoded strings to a NSString variables
NSString *firstName = @"Joe";
NSString *lastName = @"Smith";
NSString *email = @"Joe@gmail.com";
NSString *password = @"12345678";


// check of empty value
- (BOOL) emptyValue {
    
    BOOL isEmpty = YES;
    if (([[[self emailTextField] text] length] == 0) || ([[[self passwordTextField] text] length] == 0)) {
        isEmpty = YES;
        
    } else isEmpty = NO;
    
    return isEmpty;
}

// String comparison for lowercase letters
- (BOOL) caseInSensitive {
    
    BOOL isCaseInSensitive = YES;
        if ([[[self emailTextField] text] caseInsensitiveCompare:email] == NSOrderedSame){
            isCaseInSensitive = YES;
        
        } else isCaseInSensitive = NO;
    
    return isCaseInSensitive;
}


/* Get the new view controller using [segue destinationViewController].
 Pass the selected object to the new view controller.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    _user = [[User  alloc] init];
    
        [[self user] setFirstName:firstName];
        [[self user] setLastName: lastName];
        [[self user] setEmail:email];
        [[self user] setPassword: password];
        [[self user] setPhoto:[UIImage imageNamed:@"userPhoto"]];

        // Email and password are correct and navigate to CarstableViewController(Homescreen)
    if ([[segue destinationViewController] isKindOfClass:[ CarsTableViewController class]] && ([self caseInSensitive]==TRUE) && [[[self passwordTextField] text] isEqualToString: password]) {
        CarsTableViewController* carsTableViewController = [segue destinationViewController ];
        [carsTableViewController setUser:_user];
        
        // Email and password are incorrect
    } else if (((![[[self emailTextField] text] isEqualToString: email]) || (![[[self passwordTextField] text] isEqualToString: password])) && ([self emptyValue] != TRUE)) {
        
        UIAlertController* alert = [[UIAlertController alloc] init];
        [alert setTitle:@"User verification"];
        [alert setMessage:@"Email or password is incorrect. Try again."];
        [alert modalPresentationStyle];
     
        // Action for the cancel button
        UIAlertAction* dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Dismissed");
        }];
        
        // close modal
        [alert addAction:dismiss];

        [self presentViewController:alert animated:YES completion:nil];
         
        // Will be triggered once the emailtexfield or passwordfield is emtpy
    } else if ([self emptyValue] == TRUE) {
        
        UIAlertController* alert = [[UIAlertController alloc] init];
        [alert setTitle:@"User verification"];
        [alert setMessage:@"Email or password cannot be empty. Try again."];
        [alert modalPresentationStyle];
     
        // Action for the cancel button
        UIAlertAction* dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Dismissed");
        }];
        
        // close modal
        [alert addAction:dismiss];

        [self presentViewController:alert animated:YES completion:nil];
    }
}

// unwind or to avoid going back to AddCarViewController
- (IBAction)unwindToUserViewController:(UIStoryboardSegue *)unwindSegue {
    UIViewController *sourceViewController = unwindSegue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[ UserViewController class]]) {
        NSLog(@"We can't go back to Add screen due to implemeneted unwind segue.");
        
    }
}

// Function to be called to navigate in Google sign in page
-(void) googleLogin {
    NSString *urlString;
    urlString = @"https://accounts.google.com/ServiceLogin/signinchooser?service=mail&passive=1209600&osid=1&continue=https%3A%2F%2Fmail.google.com%2Fmail%2Fu%2F0%2F&followup=https%3A%2F%2Fmail.google.com%2Fmail%2Fu%2F0%2F&emr=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Represents about the information of the object and encapsulates the load request property for the URL and the policies will be used for it
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
        [_webView loadRequest:requestObj];
        _webView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);

    //[self.view addSubview:_webView] ;
    //[self.view sendSubviewToBack:_webView];
        
    UIAlertController* alert = [[UIAlertController alloc] init];
    
    
    [alert modalPresentationStyle];
    
    [self.view addSubview:_webView] ;
    // Action for the cancel button
    UIAlertAction* dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self stopLoading];
    }];
    
    // Add action to alert
    [alert addAction:dismissAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

// Verify loading of google sign in page
- (BOOL)webView:(WKWebView*)webView
shouldStartLoadWithRequest:(NSURLRequest*)request
                                    navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString;
    urlString = @"https://accounts.google.com/ServiceLogin/signinchooser?service=mail&passive=1209600&osid=1&continue=https%3A%2F%2Fmail.google.com%2Fmail%2Fu%2F0%2F&followup=https%3A%2F%2Fmail.google.com%2Fmail%2Fu%2F0%2F&emr=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin";
    NSURL *url = [NSURL URLWithString:urlString];
    request = [NSURLRequest requestWithURL:url];

        if (request.URL == url) {

            //do close window magic here!!
            [self stopLoading];
            return NO;
        }
        return YES;
    }

// Function to stop webView loading screen
-(void)stopLoading{
    [_webView removeFromSuperview];
}

// Action button to sign in via google account
- (IBAction)didPressGoogleLogin:(id)sender {
    [self googleLogin];
    NSLog(@"Login");
    
}

@end
