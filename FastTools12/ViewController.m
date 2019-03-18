/*
 HI GUYS, THIS IS EXACTLY HOW FASTTOOL12 WORKS, IF YOU WANT TO HELP ME TO IMPROVE IT
 JUST CONTACT ME ON MY TWITTER: @ABOUTZEPH
 OFFICIAL REPO: HTTPS://MATTEOZAPPIA.GITHUB.IO/REPO
 OFFICIAL GITHUB REPO: HTTPS://GITHUB.COM/MATTEOZAPPIA/FASTTOOLS12
 */
//
//  ViewController.m
//  FastTools12
//
//  Created by Matteo Zappia on 17/02/2019.
//  Copyright © 2019 Matteo Zappia. All rights reserved.
//

#import "ViewController.h"
#import <NMSSH/NMSSH.h>
#import <AudioToolbox/AudioServices.h>



@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *shutdownButton;
@property (strong, nonatomic) IBOutlet UIButton *uiCacheButton;
@property (strong, nonatomic) IBOutlet UIButton *safeModeButton;
@property (strong, nonatomic) IBOutlet UIButton *ldRestartButton;
@property (strong, nonatomic) IBOutlet UIButton *rebootButton;
@property (strong, nonatomic) IBOutlet UIButton *respringButton;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastPassword = [defaults objectForKey:@"lastPassword"];

    [defaults registerDefaults:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:@"HAVE_SHOWN_REMINDER"]];
    BOOL haveShownReminder = [defaults boolForKey:@"HAVE_SHOWN_REMINDER"];
    if (!haveShownReminder)
    {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Welcome to FastTools12"
        message:@"This is the first time that you open it, so insert your root password in the Settings to make it correctly work."
        delegate:self
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
            [alert2 show];

        [[NSUserDefaults standardUserDefaults]  setObject:[NSNumber numberWithInt:1] forKey:@"HAVE_SHOWN_REMINDER"];
    }

    NSString *rootPassword = lastPassword;
    NSLog(@"%@", rootPassword);
}

NSString *rootPassword;

- (IBAction)changePassword:(id)sender {
    
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Not working?"
                               message:@"If you tap on a button and FastTools12 crashes, probably you've changed your root password.\nNo problem, just type it down here to make it work!\n\nIMPORTANT: I'll not save your password to do malicious stuff."
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       NSLog(@"cancel btn");
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                   }];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   UITextField *textField = alert.textFields[0];
                                                   rootPassword = textField.text;
                                                   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                   NSString *lastPassword  = [textField text];
                                                   [defaults setObject:lastPassword forKey:@"lastPassword"];
                                                   [defaults synchronize];
                                               }];
    
    
    [alert addAction:cancel];
    [alert addAction:ok];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"type your root password here";
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.secureTextEntry = YES;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)LoadRootPassword{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastPassword = [defaults objectForKey:@"lastPassword"];
    rootPassword = lastPassword;
}

- (IBAction)respringAction:(id)sender {
    [self LoadRootPassword];
    NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                           withUsername:@"root"];
    
    if (session.isConnected) {
        [session authenticateByPassword:rootPassword];
        
        if (session.isAuthorized) {
            NSLog(@"Authentication succeeded");
        } else{
            NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
            @throw NSInternalInconsistencyException;
        }
    }
    
    NSError *error = nil;
    NSString *response = [session.channel execute:@"killall backboardd" error:&error];
    NSLog(@"%@", response);
    [session disconnect];
}




- (IBAction)rebootAction:(id)sender {
    [self LoadRootPassword];
    NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                           withUsername:@"root"];
    
    if (session.isConnected) {
        [session authenticateByPassword:rootPassword];
        
        if (session.isAuthorized) {
            NSLog(@"Authentication succeeded");
        } else{
            NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
            @throw NSInternalInconsistencyException;
        }
    }
    
    NSError *error = nil;
    NSString *response = [session.channel execute:@"reboot" error:&error];
    NSLog(@"%@", response);
    [session disconnect];
}


- (IBAction)uicacheAction:(id)sender {
    [self LoadRootPassword];
    NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                          withUsername:@"root"];
    
    if (session.isConnected) {
       [session authenticateByPassword:rootPassword];
        if (session.isAuthorized) {
            NSLog(@"Authentication succeeded");
        } else{
            NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
            @throw NSInternalInconsistencyException;
        }
    }
    
    NSError *error = nil;
    NSString *response = [session.channel execute:@"uicache" error:&error];
    NSLog(@"%@", response);
    [session disconnect];
}


- (IBAction)ldrestartAction:(id)sender {
    [self LoadRootPassword];
    NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                           withUsername:@"root"];
    
    if (session.isConnected) {
        [session authenticateByPassword:rootPassword];
        
        if (session.isAuthorized) {
            NSLog(@"Authentication succeeded");
        } else{
            NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
            @throw NSInternalInconsistencyException;
        }
    }
    
    NSError *error = nil;
    NSString *response = [session.channel execute:@"ldrestart" error:&error];
    NSLog(@"%@", response);
    [session disconnect];
}


- (IBAction)followTwitterme:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"https://twitter.com/aboutzeph"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

- (IBAction)donateAction:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"https://paypal.me/matteozappia"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];

}

- (IBAction)safemodeAction:(id)sender {
    [self LoadRootPassword];
    NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                           withUsername:@"root"];
    
    if (session.isConnected) {
        [session authenticateByPassword:rootPassword];
        
        if (session.isAuthorized) {
            NSLog(@"Authentication succeeded");
        } else{
            NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
            @throw NSInternalInconsistencyException;
        }
    }
    
    NSError *error = nil;
    NSString *response = [session.channel execute:@"killall -SEGV SpringBoard" error:&error];
    NSLog(@"%@", response);
    [session disconnect];
}


- (IBAction)shutdownAction:(id)sender {
    [self LoadRootPassword];
    NMSSHSession *session = [NMSSHSession connectToHost:@"127.0.0.1:2222"
                                           withUsername:@"root"];
    
    if (session.isConnected) {
        [session authenticateByPassword:rootPassword];
        
        if (session.isAuthorized) {
            NSLog(@"Authentication succeeded");
        } else{
            NSLog(@"FAILED!FAILED!FAILED!FAILED!FAILED!");
            @throw NSInternalInconsistencyException;
        }
    }
    
    NSError *error = nil;
    NSString *response = [session.channel execute:@"killall -SEGV SpringBoard" error:&error];
    NSLog(@"%@", response);
    [session disconnect];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        NSLog(@"called");
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"Respring?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self respringAction:nil];
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        [alert2 addAction:cancel];
        [alert2 addAction:ok];
        [self presentViewController:alert2 animated:YES completion:nil];
        
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
   
@end
