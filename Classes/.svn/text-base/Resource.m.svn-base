//
//  Resource.m
//  iEstimator
//
//  Created by John Wooten on 1/7/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "Resource.h"
#import "Utilities.h"


@implementation Resource

@synthesize endDate, startDate, fName, lName, role, phone, imageName;

- (id)init: (NSString *) aFirstName last:(NSString *) aLastName phone:(NSString *)aPhone imageName:(NSString *)image started: (NSDate *)sDate role: (NSString *)aRole billout: (float)aRate	{
	[super init];
	fName = aFirstName;
	lName = aLastName;
	phone = aPhone;
	imageName = image;
	role = aRole;
	self.startDate = sDate;
	billoutRate = aRate;
	hoursPerMonth = 150;
	return self;
}

- (void)setStartDateStr:(NSString *) startDateStr	{
	if( startDateStr == nil )
		return;
	[self setStartDate:[Utilities dateStrToDate:startDateStr]];
}

-(NSString *)startDateStr	{
	if( [self startDate] == nil )
		return @"";
	NSString *sStr = [NSString stringWithFormat:@"%@", [self startDate]];
	printf("\nstartDateStr -> %s", [sStr UTF8String]);
	return [Utilities dateToDateStr:[self startDate]];
}

- (void)setEndDateStr:(NSString *) endDateStr	{
	if( endDateStr == nil )
		return;
	[self setEndDate:[Utilities dateStrToDate:endDateStr]];
}

- (NSString *)endDateStr	{
	if( [self endDate] == nil )
		return @"";
	return [Utilities dateToDateStr:[self endDate]];
}

- (void) setBilloutRate:(float)aRate	{
	billoutRate = aRate;
}

- (float)billoutRate	{
	return billoutRate;
}

- (void) setHoursPerMonth: (int)hours	{  // if not set will be $150.0
	hoursPerMonth = hours;
}

- (int) hoursPerMonth	{
	return hoursPerMonth;
}

- (float) totalCost	{
	if( [self startDate] == nil )
		return 0.0f;
	NSDate *lastDate = nil;
	if( [self endDate] != nil )
		lastDate = [self endDate];
	else
		lastDate = [[NSDate alloc] init];
	return [self totalCostAsOf:lastDate];
}

- (float) totalCostAsOf:(NSDate *)lastDate	{ // useful for graphing
	int years = [Utilities yearsBetweenStartDate:[self startDate] endDate:lastDate];
	int months = [Utilities monthsBetweenStartDate:[self startDate] endDate:lastDate];
	int days = [Utilities daysBetweenStartDate:[self startDate] endDate:lastDate];
	float totalDuration =  years * 12.0f  + months + days/30.0f; // duration as a fraction of months
	printf("\ntotalDuration = %3.2f", totalDuration);
	float val = hoursPerMonth * totalDuration * billoutRate;
	printf("\ntotal Billout is %4.2f", val);
	return val;	
}

- (id) initWithCoder:(NSCoder *)decoder
{
	if( self = [super init] )
	{
		self.fName = [decoder decodeObjectForKey:@"fName"];
		self.lName = [decoder decodeObjectForKey:@"lName"];
		self.role =  [decoder decodeObjectForKey:@"role"];
		self.phone = [decoder decodeObjectForKey:@"phone"];
		self.imageName = [decoder decodeObjectForKey:@"imageName"];
		[self setStartDateStr:[decoder decodeObjectForKey:@"startDateStr"]];
		[self setEndDateStr:[decoder decodeObjectForKey:@"endDateStr"]];
		self.hoursPerMonth = [Utilities object2Float:[decoder decodeObjectForKey:@"hoursPerMonth"]];
		self.billoutRate = [Utilities object2Float:[decoder decodeObjectForKey:@"billoutRate"]];
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *) encoder
{
	[encoder encodeObject:[self fName] forKey:@"fName"];
	[encoder encodeObject:[self lName] forKey:@"lName"];
	[encoder encodeObject:[self role] forKey:@"role"];
	[encoder encodeObject:[self phone] forKey:@"phone"];
	[encoder encodeObject:[self imageName] forKey:@"imageName"];
	[encoder encodeObject:[self startDateStr] forKey:@"startDateStr"];
	[encoder encodeObject:[self endDateStr] forKey:@"endDateStr"];
	[encoder encodeObject:[Utilities float2Object:[self hoursPerMonth]] forKey:@"hoursPerMonth"];
	[encoder encodeObject:[Utilities float2Object:[self billoutRate]] forKey:@"billoutRate"];
}



- (NSString *) description	{
	return [NSString stringWithFormat: @"%@  \t%@  \t%@\t%@\t$%3.2f/hr. \t%d hrs/mo.\t$%4.2f",self.fName,
			self.role,
			[self startDate],
			[self endDate],
			self.billoutRate,
			[self hoursPerMonth],
			[self totalCost]];
}

- (void) dealloc	{
	/*[name release];
	[role release];
	[started release];
	[ended release];*/
	[super dealloc];
}
@end
