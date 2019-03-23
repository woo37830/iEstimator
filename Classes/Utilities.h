//
//  Utilities.h
//  NavBar
//
//  Created by John Wooten on 1/23/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utilities : NSObject {

}

+ (NSDate *)adjustDate:(NSDate *)aDate byYear:(int) theYears months:(int)theMonths days:(int)theDays;

+ (NSDate *) dateDiffFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;

+ (int) yearsBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (int) monthsBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (int) daysBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (NSDate *) dateStrToDate:(NSString *)startDateStr;

+ (NSString *) dateToDateStr:(NSDate *)aDate;

// persistence methods

+ (NSString *)dataFilePath;

+ (id) float2Object:(float)aFloat;
+ (float) object2Float:(NSNumber *)numberObject;
+ (id) integer2Object:(int) anInteger;
+ (int) object2Integer:(NSNumber *)numberObject;

@end
