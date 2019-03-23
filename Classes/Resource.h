//
//  Resource.h
//  iEstimator
//
//  Created by John Wooten on 1/7/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Resource : NSObject <NSCoding> {
	NSString* fName;
	NSString* lName;
	NSString *role;
	NSString *phone;
	NSString *imageName;
	NSDate *startDate;
	NSDate *endDate;
	float billoutRate;
	float hoursPerMonth;
}

@property (nonatomic, retain) NSString *fName;
@property (nonatomic, retain) NSString *lName;
@property (nonatomic, retain) NSString *role;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;

- (id)init: (NSString *) fName last: (NSString *) lName phone: (NSString *) phone imageName: (NSString *) iName started: (NSDate *)startDate role: (NSString *)aRole billout: (float)aRate;

- (void)setStartDateStr:(NSString *) startDateStr;

-(NSString *)startDateStr;

- (void)setEndDateStr:(NSString *) endDateStr;

- (NSString *)endDateStr;

- (void) setBilloutRate:(float)aRate;

- (float)billoutRate;

- (void) setHoursPerMonth:(int)hours;

- (int) hoursPerMonth;

- (float) totalCost;

- (float) totalCostAsOf:(NSDate *)lastDate;

- (NSString *) description;


- (void) dealloc;
@end
