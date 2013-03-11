//
//  PDTRViewController.m
//  DeelioBiz
//
//  Created by Nikunj on 10/03/13.
//  Copyright (c) 2013 Me. All rights reserved.
//

#import "CloudQueryViewController.h"
@interface CloudQueryViewController ()
{
    NSDate *lastUpdateDate;
    BOOL firstTimeLoad;
    UIView *firsTimeLoadingView;
    int tableSeperatorStyle;
    UIColor *tableSeperatorColor;
}
- (void) reloadTableViewDataSource;
- (void) doneLoadingTableViewData;
@end

@implementation CloudQueryViewController
@synthesize cloudData;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id) initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
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
    
    if(_refreshHeaderView==nil){
        EGORefreshTableHeaderView *view=[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f-self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate=self;
        [self.tableView addSubview:view];
        _refreshHeaderView=view;
        firstTimeLoad=YES;
        tableSeperatorStyle=self.tableView.separatorStyle;
        tableSeperatorColor=self.tableView.separatorColor;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        firsTimeLoadingView=[self getLoadingView];
        self.tableView.scrollEnabled=NO;
        [self.view addSubview:firsTimeLoadingView];
        
        
    }
    self.cloudData=[[NSMutableArray alloc] init];
    lastUpdateDate=[NSDate date];
    [_refreshHeaderView refreshLastUpdatedDate];
    [self egoRefreshTableHeaderDidTriggerRefresh:_refreshHeaderView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.cloudData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *object=[self.cloudData objectAtIndex:indexPath.row];
    return [self tableView:tableView cellForRowAtIndexPath:indexPath object:object];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark Data source Loading / Reloading Methods
-(void) reloadTableViewDataSource{
    _reloading=YES;
    MyCloud *cloud=[self queryCloud];
    [self objectsWillLoad];
    [PFCloud callFunctionInBackground:cloud.functionName withParameters:cloud.functionParamters block:^(id object, NSError *error) {
        [self doneLoadingTableViewData];
        if([object isKindOfClass:[NSArray class]]){
            self.cloudData=object;
        }
        [self objectsDidLoad:error];        
        [self.tableView reloadData];
    }];
}

-(void) doneLoadingTableViewData{
    _reloading=NO;
    firstTimeLoad=NO;
    [firsTimeLoadingView removeFromSuperview];
    self.tableView.separatorStyle=tableSeperatorStyle;
    self.tableView.separatorColor=tableSeperatorColor;
    self.tableView.scrollEnabled=YES;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    lastUpdateDate=[NSDate date];
}

#pragma mark ScrollView Delegate
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark EGORefreshTableHeader Delegate
-(void) egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    [self reloadTableViewDataSource];
}

-(BOOL) egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
    return _reloading;
}

-(NSDate*) egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view{
    return lastUpdateDate;
}

#pragma mark Cloud Call 
-(void) objectsWillLoad{

}

-(void) objectsDidLoad:(NSError *)error{

}

-(UIView*) getLoadingView{
    CGFloat navBarH=self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarH=self.tabBarController.tabBar.frame.size.height;
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height-(navBarH+tabBarH))];
    v.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame=CGRectMake(0, 0, 20, 20);
    indicator.center=CGPointMake((v.frame.size.width/2.0)-40.0, floorf(v.frame.size.height/2.0));    
    
    [v addSubview:indicator];
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 76, 22)];
    lbl.font=[UIFont fontWithName:@"Helvetica NeueUI" size:17.0];
    lbl.text=@"Loading...";
    lbl.center=CGPointMake((v.frame.size.width/2.0)+12.0, floorf(v.frame.size.height/2.0));
    lbl.shadowOffset=CGSizeMake(0, 1);
    lbl.shadowColor=[UIColor whiteColor];
    lbl.backgroundColor=[UIColor clearColor];
    [v addSubview:lbl];
    [indicator startAnimating];
    return v;
}

@end
