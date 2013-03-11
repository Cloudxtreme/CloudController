//
//  ListViewController.m
//  CloudQueryController
//
//  Created by Nikunj on 11/03/13.
//  Copyright (c) 2013 Me. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) objectsWillLoad{
    [super objectsWillLoad];
}

-(void) objectsDidLoad:(NSError *)error{
    [super objectsDidLoad:error];
}


-(PFCloud*) queryCloud{
    MyCloud *qCloud=[[MyCloud alloc] init];
    qCloud.functionName=@"functionName";
    qCloud.functionParamters=[NSDictionary dictionaryWithObjectsAndKeys:@"xxxx",@"yyyy", nil];
    return qCloud;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    static NSString *cellId=@"Cellid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.textLabel.text=[object objectForKey:@"message"];
    return cell;
}

@end
