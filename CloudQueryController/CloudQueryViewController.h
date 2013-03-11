//
//  PDTRViewController.h
//  DeelioBiz
//
//  Created by Nikunj on 10/03/13.
//  Copyright (c) 2013 Me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "MyCloud.h"

@interface CloudQueryViewController : UITableViewController <EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    MyCloud *myCloud;
}
@property (strong,nonatomic) NSMutableArray *cloudData;
//Loading Methods
- (void) objectsWillLoad;
- (void) objectsDidLoad:(NSError *)error;
- (MyCloud*) queryCloud;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object;

@property (strong,nonatomic) NSMutableArray *data;
@end
