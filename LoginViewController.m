//
//  LoginViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/28/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (){
    BOOL resized1;
    BOOL resized2;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation LoginViewController
@synthesize usernameField,passwordField,scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeTextFields];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    
    
}


-(void)initializeTextFields{
    resized1 = NO;
    resized2 = NO;
    usernameField.delegate = self;
    passwordField.delegate = self;
    [usernameField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [passwordField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [usernameField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [passwordField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [passwordField setSecureTextEntry:YES];
    [usernameField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [passwordField setAutocorrectionType:UITextAutocorrectionTypeNo];
}

#pragma mark - uitextfield

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
        CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y/2);
        [scrollView setContentOffset:scrollPoint animated:YES];

    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    
    
    [scrollView setContentOffset:CGPointZero animated:YES];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"textFieldShouldReturn:");
    if (textField.tag == 1) {
        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:2];
        [passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
     
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
