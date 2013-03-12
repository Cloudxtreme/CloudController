**OverView**
Parse providing a wonderful framework for developers across all platforms, out of which iOS is one of them.
PFQueryTableViewController helps to manage UITableViewController with PFQuery. But, if we can't use the same UITableViewController in-coordination with PFCloud.

Hence, I created my own UITableViewController which suports the same functionality but for Cloud Code.
Use -(PFCloud*) queryCloud instead of - (PFQuery *)queryForTable.
    
    -(PFCloud*) queryCloud{
        MyCloud *qCloud=[[MyCloud alloc] init];
    	qCloud.functionName=@"functionName";
    	qCloud.functionParamters=[NSDictionary dictionaryWithObjectsAndKeys:@"xxxx",@"yyyy", nil];
    	return qCloud;
    }