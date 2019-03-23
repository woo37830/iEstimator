//
//  Utilities.m
//  NavBar
//
//  Created by John Wooten on 1/23/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "Utilities.h"
#import "Constants.h"


@implementation Utilities

+ (NSDate *)dateStrToDate:(NSString *)dateStr	{
	if( dateStr == nil )
		return nil;
	// Convert string to date object
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"MM-dd-yyyy"];
	NSDate *date = [dateFormat dateFromString:dateStr];  
	[dateFormat release];
	return date;
}

+ (NSString *)dateToDateStr:(NSDate *)aDate	{
	[aDate retain];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"MM-dd-yyyy"];
	NSString *dateStr = [dateFormat stringFromDate:aDate];
	[dateFormat release];
	//[aDate release];
	return dateStr;
}


+ (int) yearsBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate	{
	if( startDate == nil || endDate == nil )
		return 0;
	if( startDate > endDate )
		return 0;
	NSString *sStr = [Utilities dateToDateStr:startDate];
	NSString *eStr = [Utilities dateToDateStr:endDate];
	printf("\nyearsBetweenStartDate: %s - %s",[sStr UTF8String], [eStr UTF8String]);
	NSCalendar *calendar = [NSCalendar currentCalendar];
	unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	
	NSDateComponents *comps = [calendar components:unitFlags fromDate:startDate  toDate:endDate  options:0];
	
	return [comps year];
}

+ (int) monthsBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate	{
	if( startDate == nil || endDate == nil )
		return 0;
	if( startDate > endDate )
		return 0;
	NSCalendar *calendar = [NSCalendar currentCalendar];
	unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	
	NSDateComponents *comps = [calendar components:unitFlags fromDate:startDate  toDate:endDate  options:0];
	
	return [comps month];	
}

+ (int) daysBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate	{
	if( startDate == nil || endDate == nil )
		return 0;
	if( startDate > endDate )
		return 0;
	NSCalendar *calendar = [NSCalendar currentCalendar];
	unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	
	NSDateComponents *comps = [calendar components:unitFlags fromDate:startDate  toDate:endDate  options:0];
	
	return [comps day];
}

+ (NSDate *) dateDiffFromDate:(NSDate *)startDate toDate:(NSDate *)endDate	{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
	
	NSDateComponents *comps = [calendar components:unitFlags fromDate:startDate  toDate:endDate  options:0];
	
	int years = [comps year];
	
	int months = [comps month];
	
	int days = [comps day];
	printf("\ndates differ by %d years, %d months, and %d days",years, months, days);
	
	return [calendar dateFromComponents:comps];
}

+ (NSDate *)adjustDate:(NSDate *)aDate byYear:(int) theYears months:(int)theMonths days:(int)theDays {
	[aDate retain];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:aDate];
	NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit ) fromDate:aDate];
	int adjYears = [dateComponents year];
	adjYears += theYears;
	[timeComponents setYear:adjYears];
	int adjMonths = [dateComponents month];
	adjMonths += theMonths;
	[timeComponents setMonth:adjMonths];
	int adjDays = [dateComponents day];
	adjDays += theDays;
	[timeComponents setDay:adjDays];
	//[aDate release];
	return [calendar dateFromComponents:timeComponents];
}


+ (NSString *)dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

+ (id) float2Object:(float) aFloat
{
	return [[NSNumber alloc] initWithFloat:aFloat];
}

+ (float) object2Float:(NSNumber *)numberObject
{
	return [numberObject floatValue];
}

+ (id) integer2Object:(int) anInteger
{
	return [[NSNumber alloc] initWithInteger:anInteger];	
}

+ (int) object2Integer:(NSNumber *)numberObject
{
	return [numberObject integerValue];	
}

@end
