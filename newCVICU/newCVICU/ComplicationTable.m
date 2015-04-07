//
//  ComplicationTable.m
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "ComplicationTable.h"

NSMutableDictionary *sendingreport; //report to be sent

@implementation ComplicationTable

- (void)viewDidLoad{
    self.title = @"Select Complication";
    self.ComplicationTable.dataSource = self;
    self.ComplicationTable.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    sendingreport = self.report;
    self.ComplicationList = [[NSMutableArray alloc]init];
    [self.ComplicationList addObject:@"Cardiopulmonary resuscitation"]; // just for temorary test.
}



#pragma mark - Table config

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"complication" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.ComplicationList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [sendingreport setObject:self.ComplicationList[indexPath.row] forKey:@"Complication"];
    if([self.ComplicationList[indexPath.row]isEqual: @"Cardiopulmonary resuscitation"]){
        [self performSegueWithIdentifier:@"CPR" sender:self];
    }
}

#pragma mark - navigations
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier]isEqualToString:@"CPR"]){
        Cardiopulmonary_resuscitation *destination = segue.destinationViewController;
        destination.report = sendingreport;
    }
}

@end
