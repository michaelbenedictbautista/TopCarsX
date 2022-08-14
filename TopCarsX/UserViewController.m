//
//  UserViewController.m
//  TopCarsX
//
//  Created by Mike on 31/7/2022.
//

#import "UserViewController.h"
#import "CarsTableViewController.h"
#import <WebKit/WebKit.h>

@interface UserViewController ()
@property(strong,nonatomic) WKWebView *webView;


@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Adjust the size of the scrollview
    _UserScrollView.contentSize = CGSizeMake(317, 950);
    
//    _webView.navigationDelegate = self;
//    _webView.uiDelegate = self;
    
//setDelegate:self];
//    [navigationDelegate] = [self webView];
    


}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// Will be called when system determines that the amount of available memory is low
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButton:(id)sender {

}

NSString *firstName = @"Joe";
NSString *lastName = @"Smith";
NSString *email = @"Joe@gmail.com";
NSString *password = @"12345678";

- (BOOL) emptyValue {
    
    BOOL isEmpty = YES;
    if (([[[self emailTextField] text] length] == 0) || ([[[self passwordTextField] text] length] == 0)) {
        isEmpty = YES;
        
    } else isEmpty = NO;
    
    return isEmpty;
}





// string comparison for lowercase letters
- (BOOL) caseSensitive {
    
    BOOL isCaseSensitive = YES;
        if ([[[self emailTextField] text] caseInsensitiveCompare:email] == NSOrderedSame){
            isCaseSensitive = YES;
        
        } else isCaseSensitive = NO;
    
    return isCaseSensitive;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    _user = [[User  alloc] init];
    
        [[self user] setFirstName:firstName];
        [[self user] setLastName: lastName];
        [[self user] setEmail:email];
        [[self user] setPassword: password];
        [[self user] setPhoto:[UIImage imageNamed:@"userPhoto"]];

    if ([[segue destinationViewController] isKindOfClass:[ CarsTableViewController class]] && ([self caseSensitive]==TRUE) && [[[self passwordTextField] text] isEqualToString: password]) {
        CarsTableViewController* carsTableViewController = [segue destinationViewController ];
        [carsTableViewController setUser:_user];
        
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


-(void) googleLogin {
    NSString *urlString;
    urlString = @"https://accounts.google.com/ServiceLogin/signinchooser?service=mail&passive=1209600&osid=1&continue=https%3A%2F%2Fmail.google.com%2Fmail%2Fu%2F0%2F&followup=https%3A%2F%2Fmail.google.com%2Fmail%2Fu%2F0%2F&emr=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
        [_webView loadRequest:requestObj];
        _webView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);

    //[self.view addSubview:_webView] ;
    //[self.view sendSubviewToBack:_webView];
    
    //[self.view willMoveToWindow:_webView] ;
    
    
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
-(void)stopLoading{
    [_webView removeFromSuperview];
}




- (IBAction)didPressGoogleLogin:(id)sender {
    [self googleLogin];
    NSLog(@"Login");
    
}






@end
