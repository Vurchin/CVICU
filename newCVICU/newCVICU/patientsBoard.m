//
//  patientsBoard.m
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "patientsBoard.h"

@implementation patientsBoard

- (void)viewDidLoad{
    self.title = @"Select Patient FIN";
    self.navigationController.navigationBarHidden = NO;
    self.patientTable.delegate = self;
    self.patientTable.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.report = [[NSMutableDictionary alloc]init]; // init the final report every time this view is accessed.
}


#pragma mark - configure the table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.patientList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patient" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.patientList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.report setObject:self.patientList[indexPath.row] forKey:@"FIN"];
    [self performSegueWithIdentifier:@"ComplicationTable" sender:self];
}

#pragma mark - navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier]isEqualToString:@"ComplicationTable"]){
        ComplicationTable *destination = segue.destinationViewController;
        destination.report = self.report;
    }
}

@end
