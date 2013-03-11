//
//  MyCloud.h
//  DeelioBiz
//
//  Created by Nikunj on 10/03/13.
//  Copyright (c) 2013 Me. All rights reserved.
//

#import <Parse/Parse.h>

@interface MyCloud : PFCloud
@property (weak,nonatomic) NSString *functionName;
@property (weak,nonatomic) NSDictionary *functionParamters;
@end
