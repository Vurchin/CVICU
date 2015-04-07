//
//  ViewController.m
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - view config

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)configView { // all configures of the view go on here
    self.passfield.secureTextEntry = YES;
    //tap to hide keyboard.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    //add login action to the button
    [self.loginbutton addTarget:self action:@selector(checkUser) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissKeyboard { // hide the keyboard.
    [self.userfield resignFirstResponder];
    [self.passfield resignFirstResponder];
}

#pragma mark - request sending

- (void)checkUser{ //Login button clicked
    if([self.userfield.text isEqual:@""] || [self.passfield.text isEqual:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Blank name or password"
                                                        message:@"Please give me your email and password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        [self sendLoginRequest];
    }
}

- (void)sendLoginRequest { //send login request.
    NSString *string = [NSString stringWithFormat:@"{\"Target Action\":\"Log In\",\"UserName\":\"%@\",\"PassWord\":\"%@\"}",self.userfield.text,self.passfield.text];
    NSData *sent = [string dataUsingEncoding:NSASCIIStringEncoding];
    NSString *datalentgh = [NSString stringWithFormat:@"%ld",[sent length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:@"http://localhost:3000"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:datalentgh forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:sent];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(conn){
        //do something here maybe?
    }
    else{
        NSLog(@"not yet");
    }

}

#pragma mark - request handling

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.dataChunk = [[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.dataChunk appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    id backmsg = [NSJSONSerialization JSONObjectWithData:self.dataChunk options:0 error:nil];
    if([backmsg[@"BackMsg"] isEqual: @"LogInRes"]){
        if([backmsg[@"Result"] isEqual: @"true"]){ // segue goes on here
            [self performSegueWithIdentifier:@"mainview" sender:self];
        }
        else{ // false and alert
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:@"incorrect email or password"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            self.userfield.text = @"";
            self.passfield.text = @"";
        }
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connection failed");
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier]isEqualToString:@"mainview"]){
        
    }
}

#pragma mark - other things

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
