//
//  Cardiopulmonary resuscitation.m
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "Cardiopulmonary resuscitation.h"


@implementation Cardiopulmonary_resuscitation

- (void)viewDidLoad{
    self.title = @"Cardiopulmonary resuscitation";
    [[NSNotificationCenter defaultCenter]addObserver:self
                                        selector:@selector(receiveNotification:)
                                        name:@"CPRoptions"
                                        object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(receiveNotification:)
                                                name:@"Hypoth"
                                              object:nil];
    [self configView];
}

#pragma mark - view config
- (void)configView { // all configures of the view go on here
    //tap to hide keyboard.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard { // hide the keyboard.
    [self.startdate resignFirstResponder];
    [self.enddate resignFirstResponder];
    [self.startfield resignFirstResponder];
    [self.endField resignFirstResponder];
}


#pragma mark - request sending
- (IBAction)clickSubmit:(id)sender {
    NSString *string = [NSString stringWithFormat:@"{\"Target Action\":\"add log\",\"Table\":\"CPRLog\",\"FIN\":\"%@\",\"startDate\":\"%@\",\"endDate\":\"%@\",\"outcome\":\"%@\",\"hypothermia\":\"%@\"}",self.report[@"FIN"],self.startfield.text,self.endField.text,self.report[@"CPRoption"],self.report[@"Hypothermia protocol"]];
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
    if([backmsg[@"Result"]isEqual: @"true"]){
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"Adding failed(Maybe you missed some information)."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connection failed");
}

#pragma mark - notification
- (void)receiveNotification:(NSNotification *)notification{ // receive notification from sub viewcontrollers
    if([[notification name]isEqual:@"CPRoptions"]){
        [self.report setObject:notification.object forKey:@"CPRoption"];
    }
    if([[notification name]isEqual:@"Hypoth"]){
        [self.report setObject:notification.object forKey:@"Hypothermia protocol"];
    }
}


@end
