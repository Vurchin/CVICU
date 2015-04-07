//
//  MainBoard.m
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "MainBoard.h"

@implementation MainBoard

- (void)viewDidLoad{

}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.sendinglist = [[NSMutableArray alloc]init]; // init every time this view is accessed 
}

#pragma mark - request sending
- (void)requestPatientList{
    NSString *string = @"{\"Target Action\":\"Patients\"}";
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
    for(id obj in backmsg){
        [self.sendinglist addObject:obj[@"FIN"]];
    }
    [self performSegueWithIdentifier:@"patients" sender:self];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connection failed");
}

- (IBAction)addNew:(id)sender {
    [self requestPatientList];
}

#pragma mark - navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier]isEqualToString:@"patients"]){
        patientsBoard *destination = segue.destinationViewController;
        destination.patientList = self.sendinglist;
    }
}

@end
