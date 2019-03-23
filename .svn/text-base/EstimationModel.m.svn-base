//
//  EstimationModel.m
//  iEstimator
//
//  Created by John Wooten on 12/31/08.
//  Copyright 2008 ShouldersCorp.. All rights reserved.
//

#import "EstimationModel.h"
#import "Statistics.h"
#import "Utilities.h"
#import "Constants.h"
#import <math.h>


@implementation EstimationModel

- (id) initWithName:(NSString *)aName	{
	[super init];
	[self setName:aName];
	[self reset];
	extInputs = 4;
	extOutputs = 5;
	queries = 4;
	logicalFiles = 10;
	extInterfaces = 7;
	ability = 0.0f;
	exponent = 0.36f;
	slocPPM = 1000;
	blendedCostPerHour = 150.0f;
	hoursPerMonth = 160.0f;
	accuracy = 0.1f;
	// initialize arrays of keys and values
	[self initKeysAndValues];
	[self setLanguage:@"Java"];

	return self;
}

- (void) reset	{
	fp = -1.0f;
	fps = -1.0f;
	sloc = -1;
	teamSize = -1;	
}

- (void) initKeysAndValues	{
	// initialize arrays of keys and values
	abilityKeys = [[NSArray alloc] initWithObjects:@"Good", @"Average", @"Worse",nil];
	abilityValues = [[NSArray alloc] initWithObjects:@"-0.03", @"0.00", @"0.03", nil];
	systemTypeKeys = [[NSArray alloc] initWithObjects:@"Obj. Oriented", @"Client/Server",@"Bus. Systems", @"Shrink Wrap", @"Embedded",nil];
	systemTypeValues = [[NSArray alloc] initWithObjects:@"0.36", @"0.37", @"0.39", @"0.40", @"0.41" ,nil];
	languageKeys = [[NSArray alloc] initWithObjects:@"Ada 83", @"Ada95", @"C", @"C#", @"C++",
					@"Cobol", @"Fortran 90", @"Fortran 95", @"Java", @"Macro Assembly", @"Perl", @"2nd Gen", @"Smalltalk",
					@"SQL", @"3rd Gen", @"VB", @"Objective-C", nil];
	languageValues = [[NSArray alloc] initWithObjects:@"0.80", @"0.50", @"1.28", @"0.55", @"0.55", @"1.07", @"0.81",
					  @"0.71", @"0.55", @"2.13", @"0.20", @"1.071", @"0.201", @"0.13", @"0.80", @"0.32", @"0.55", nil]; 
	estimationAccuracyKeys = [[NSArray alloc] initWithObjects:@"Very Bad", @"Bad", @"Average", @"Good", @"Very Good", nil];
	estimationAccuracyValues = [[NSArray alloc] initWithObjects:@"1.50", @"1.00", @"0.50", @"0.20", @"0.10", nil];
	
}
- (void) setName:(NSString *)aName	{
	[aName retain];
	[name release];
	name = aName;
}
- (NSString *) name	{
		return name;
	}
- (int) calculateFunctionPoints	{
	if( fp == -1.0f )	{
		printf("\ncalculating fp");
	return 	40*extInputs 
	+ 50*extOutputs 
	+ 40*queries
	+ 60*logicalFiles
	+ 40*extInterfaces;	
	} else	{
		printf("\nreturning set fp");
		return fp;
	}
}

- (void) update {
	fps = -1.0f;
	printf("\nupdate the model data");
	[self totalCost];
}
- (int) functionPoints	{
	return [self calculateFunctionPoints];
}

- (float) duration	{
	printf("\ncalculating duration");
	return [self durationWithSigma: 0.0f];
}
// Problem here that if person enters SLOC then we have to use sloc not calc it
- (float) durationWithSigma: (float) s	{
	printf("\ncalculating duration with sigma");
	float rule_of_thumb_power = exponent + ability;
	float retVal = 0.0f;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	if( sloc != -1 )	{
		retVal = sloc/slocPPM;
		fps2 = 0.0f;
	}
	else if( fp != -1.0f )	{
		//printf("fp != -1 \n");
		fps = (float)fp;
		Statistics *stats = [[Statistics alloc] init: (double)fps
										   accuracy: accuracy count:monteCarloCount];
		retVal = [stats valueWithSigma: s];
		fps2 = [stats stdDev];
//
        [stats release];
		double adjFP = fps + s*fps2;
		//printf("adjFP for s = %3.2f and fps = %3.2f is %3.2f\n", s, fps, adjFP);
		retVal = pow(adjFP, rule_of_thumb_power);
		double adjFP1 = fps +(s+1.0)*fps2;
		//printf("adjF1 for s = %3.2f and fps = %3.2f is %3.2f\n", s+1.0, fps, adjFP1);
		float val2 = pow(adjFP1, rule_of_thumb_power);
		durationStdDev = val2 - retVal;
		printf("\nend of fp provided duration calc, val1 = %3.2f, val2 = %3.2f, fps2 = %3.2f\n", retVal, val2, durationStdDev);
		
	} else	{
		if( fps == -1.0f )	{
			//printf("fps == -1.0f, sigma = %3.2f\n", s);
			Statistics *extInputStats = [[Statistics alloc] init: (double)extInputs*40 accuracy: accuracy count: monteCarloCount];
			Statistics *extOutputStats = [[Statistics alloc] init: (double)extOutputs*50 accuracy: accuracy count: monteCarloCount];
			Statistics *queriesStats = [[Statistics alloc] init: (double)queries*40 accuracy: accuracy count: monteCarloCount];
			Statistics *logicalFilesStats = [[Statistics alloc] init: (double)logicalFiles*60 accuracy: accuracy count: monteCarloCount];
			Statistics *extInterfacesStats = [[Statistics alloc] init: (double)extInterfaces*40 accuracy: accuracy count: monteCarloCount];
			fps = [extInputStats mean]
				+ [extOutputStats mean]
				+ [queriesStats mean]
				+ [logicalFilesStats mean]
				+ [extInterfacesStats mean];
			fps2 = [extInputStats stdDev] * [extInputStats stdDev]
				+ [extOutputStats stdDev] * [extOutputStats stdDev]
				+ [queriesStats stdDev] * [queriesStats stdDev]
				+ [logicalFilesStats stdDev] * [logicalFilesStats stdDev]
			+ [extInterfacesStats stdDev] * [extInterfacesStats stdDev];
			fps2 = sqrt(fps2);
			printf("\nend of monteCarlo, fps = %3.2f, +/- %3.2f\n", fps, fps2);
		}
		//printf("fps != -1.0f, fps = %3.2f, +/- %3.2f\n", fps, fps2);
		//printf("fps = %3.2f, sigma = %3.2f\n", fps, s);
		double adjFP = fps + s*fps2;
		//printf("adjFP for s = %3.2f and fps = %3.2f is %3.2f\n", s, fps, adjFP);
		retVal = pow(adjFP, rule_of_thumb_power);
		double adjFP1 = fps +(s+1.0)*fps2;
		//printf("adjF1 for s = %3.2f and fps = %3.2f is %3.2f\n", s+1.0, fps, adjFP1);
		float val2 = pow(adjFP1, rule_of_thumb_power);
		durationStdDev = val2 - retVal;
		printf("\nend of duration calc, duration = %3.2f, val2 = %3.2f, durationStdDev = %3.2f\n", retVal, val2, [self stdDev]);
	}
	[pool release];
	int _val = (int)([self effort]/retVal+0.5); // calculated team size
	if( _val < 1 )
		_val = 1;
	printf("\ncalculated teamSize = %d", _val);
	if( teamSize == -1 ) {
		[self setTeamSize:_val];
	}
	if( teamSize != -1 ) {
		_val = teamSize;
	}
		int minVal = _val;
		if( minVal > 3 )
			minVal = 3;
		retVal = [self effort]/(minVal+pow((double)(_val - minVal),.50));
	return retVal;
}

- (float) stdDev	{
	return durationStdDev;
}

- (int) sloc	{
	if( sloc == -1 )	{
		int _sloc = (int)[self calculateFunctionPoints] * [self slocFactor];
		printf("\ncalculating sloc: %d", _sloc);
		return _sloc;
	} else	{
		return sloc;
	}
}
- (float) effort	{
	printf("\ncalculating effort");
	return ((float)[self sloc])/slocPPM;
}

- (int) teamSize {
	if( teamSize == 0 || teamSize < -1 )
		teamSize = -1; // tell it to calculate team size if zero
	if( teamSize != -1 )
		return teamSize;
	int _val = (int)([self effort]/[self duration]);
	if( _val < 1 )
		_val = 1;
	printf("\ncalculating teamSize = %d", _val);
	return _val;
}

- (void)setTeamSize: (int)n	{
	teamSize = n;
}

- (float) totalCost	{
	printf("\ncalculating totalCost");
	if( teamSize != -1 )	{
		return [self duration] * teamSize * blendedCostPerHour * hoursPerMonth;
	}
	return [self effort] * blendedCostPerHour * hoursPerMonth;
}

// getters and setters

- (void) setExtInputs: (int) inputs	{
	fp = -1;
	fps = -1;
	extInputs = inputs;
	printf("\nextInputs set to %d", inputs);
}

- (int) extInputs	{
	return extInputs;
}

- (void) setExtOutputs: (int) n	{
	fp = -1;
	extOutputs = n;
	printf("\nextOutputs set to %d", n);
}

- (int) extOutputs	{
	return extOutputs;
}

- (void) setQueries: (int) n	{
	fp = -1;
	queries = n;
	printf("\nqueries set to %d", n);
}

- (int) queries	{
	return queries;
}

- (void) setLogicalFiles: (int) n	{
	logicalFiles = n;
	printf("\nlogicalFiles set to %d", n);
}
- (int) logicalFiles	{
	return logicalFiles;
}

- (void) setExtInterfaces: (int) n	{
	fp = -1;
	extInterfaces = n;
	printf("\nextInterfaces set to %d", n);
}

- (int) extInterfaces	{
	return extInterfaces;
}

- (void) setFunctionPoints: (int) n	{
	fp = n;
	printf("\nfunctionPoints set to %d", n);
}

- (void ) setAbilityStr: (NSString *) aStr	{
	[self setAbility:[self keyToFloat:aStr usingsKeys:abilityKeys andValues:abilityValues]];
}
- (void) setAbility: (float) x	{
	ability = x;
	printf("\nability has been set to: %3.2f", ability);
}

- (float) ability	{
	return ability;
}

- (NSString *)abilityStr	{
	return [self floatValueToKey:[self ability] usingsValues:abilityValues andKeys:abilityKeys];
}

- (void) setSystemType: (NSString *) aStr
{
	[self setExponent:[self keyToFloat:aStr usingsKeys:systemTypeKeys andValues:systemTypeValues]];
}

- (void) setExponent: (float) x {
	exponent = x;
	printf("\nexponent has been set to %3.2f", x);
}

- (float) exponent	{
	return exponent;
}

- (NSString *) systemType	{
	return [self floatValueToKey:[self exponent] usingsValues:systemTypeValues andKeys:systemTypeKeys];
}

- (void) setLanguage: (NSString *)aLanguage	{
	[aLanguage retain];
	[language release];
	printf("\nSetting the language to %s",[aLanguage UTF8String]);
	language = aLanguage;
}
- (void) setSLOC: (int) n	{
	sloc = n;
}
- (int) slocFactor	{
	float factor = [self keyToFloat:language usingsKeys:languageKeys andValues:languageValues];
	return (int)(100 * factor);
}
- (NSString *) language	{
	return language;
}
- (void) setSlocPPM: (int) n	{
	slocPPM = n;
	printf("\nslocPPM has been set to %d", n);
}
- (int) slocPPM	{
	return slocPPM;
}
- (void) setBlendedCostPerHour: (float) x	{
	blendedCostPerHour = x;
	printf("\nblendedCostPerHour has been set to %6.2f", x);
}
- (float) blendedCostPerHour	{
	return blendedCostPerHour;
}
- (void) setHoursPerMonth: (int) n	{
	hoursPerMonth = n;
	printf("\nhoursPerMonth has been set to %d", n);
}
- (int) hoursPerMonth	{
	return hoursPerMonth;
}

- (void) setAccuracyStr:(NSString *)aStr	{
	printf("\nSetting the accuracy string to %s",[aStr UTF8String]);
	double value = [self keyToFloat:aStr usingsKeys:estimationAccuracyKeys andValues:estimationAccuracyValues];
	[self setAccuracy:value];	
}
- (void) setAccuracy: (double) x	{
	accuracy = x;
	printf("\naccuracy has been set to %3.2f", accuracy);
}
	
- (double) accuracy	{
	return accuracy;
}

- (NSString *) accuracyStr	{
	float value = [self accuracy];
	return [self floatValueToKey:value usingsValues:estimationAccuracyValues andKeys:estimationAccuracyKeys];
}

// helper methods for converting from keys to values and back
-(float) keyToFloat:(NSString *)aStr usingsKeys:(NSArray *)keys andValues:(NSArray *)values	{
	printf("\n%s", [[aStr description] cStringUsingEncoding: [NSString defaultCStringEncoding]]);
	NSEnumerator *enumerator = [keys objectEnumerator];
    NSString *obj;
	int k = 0;
    while ( obj = [enumerator nextObject] ) {
		//printf(" cf to %s\n", [[obj description] cStringUsingEncoding: [NSString defaultCStringEncoding]]);
		if( [obj isEqualToString:aStr] )
			return [[values objectAtIndex:k] floatValue];
		k++;
	}
	return 0.0f;
}

-(NSString *)floatValueToKey:(float)floatValue usingsValues:(NSArray *)values andKeys:(NSArray *)keys	{
	NSString *aStr = [[NSString alloc] initWithFormat:@"%3.2f",floatValue];
	//printf("\n%s", [[aStr description] cStringUsingEncoding: [NSString defaultCStringEncoding]]);
	NSEnumerator *enumerator = [values objectEnumerator];
    NSString *obj;
	int k = 0;
    while ( obj = [enumerator nextObject] ) {
		//printf(" cf to %s\n", [[obj description] cStringUsingEncoding: [NSString defaultCStringEncoding]]);

		if( [obj isEqualToString:aStr] )
			return [keys objectAtIndex:k];
		k++;
	}
	return @"nil";	
}

- (NSArray *) abilityKeys	{
	return abilityKeys;
}
- (NSArray *) systemTypeKeys	{
	return systemTypeKeys;
}
- (NSArray *) languageKeys	{
	return languageKeys;
}
- (NSArray *) accuracyKeys	{
	return estimationAccuracyKeys;
}

- (id) initWithCoder:(NSCoder *)decoder
{
	if( self = [super init] )
	{
		[self initKeysAndValues];
		self.name = [decoder decodeObjectForKey:@"modelName"];
		self.extInputs = [Utilities object2Integer:[decoder decodeObjectForKey:@"extInputs"]];
		self.extOutputs = [Utilities object2Integer:[decoder decodeObjectForKey:@"extOutputs"]];
		self.queries = [Utilities object2Integer:[decoder decodeObjectForKey:@"queries"]];
		self.logicalFiles = [Utilities object2Integer:[decoder decodeObjectForKey:@"logicalFiles"]];
		self.extInterfaces = [Utilities object2Integer:[decoder decodeObjectForKey:@"extInterfaces"]];
		self.slocPPM = [Utilities object2Integer:[decoder decodeObjectForKey:@"slocPPM"]];
		[self setAbilityStr:[decoder decodeObjectForKey:@"abilityStr"]];
		[self setSystemType:[decoder decodeObjectForKey:@"systemTypeStr"]];
		[self setLanguage:[decoder decodeObjectForKey:@"languageStr"]];
		[self setAccuracyStr:[decoder decodeObjectForKey:@"accuracyStr"]];
		[self setBlendedCostPerHour:[Utilities object2Float:[decoder decodeObjectForKey:@"costPerHour"]]];
		[self setHoursPerMonth:[Utilities object2Float:[decoder decodeObjectForKey:@"hoursPerMonth"]]];
		printf("\nModel has decoded %s",[[self name] UTF8String]);
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *) encoder
{
	[encoder encodeObject:[self name] forKey:@"modelName"];
	[encoder encodeObject:[Utilities integer2Object:extInputs] forKey:@"extInputs"]; 
	[encoder encodeObject:[Utilities integer2Object:extOutputs] forKey:@"extOutputs"];
	[encoder encodeObject:[Utilities integer2Object:queries] forKey:@"queries"]; 
	[encoder encodeObject:[Utilities integer2Object:logicalFiles] forKey:@"logicalFiles"]; 
	[encoder encodeObject:[Utilities integer2Object:extInterfaces] forKey:@"extInterfaces"]; 
	[encoder encodeObject:[Utilities integer2Object:slocPPM] forKey:@"slocPPM"]; 
	[encoder encodeObject:[self abilityStr] forKey:@"abilityStr"];
	[encoder encodeObject:[self systemType] forKey:@"systemTypeStr"];
	[encoder encodeObject:[self language] forKey:@"languageStr"];
	[encoder encodeObject:[self accuracyStr] forKey:@"accuracyStr"];
	[encoder encodeObject:[Utilities float2Object:blendedCostPerHour] forKey:@"costPerHour"];
	[encoder encodeObject:[Utilities float2Object:hoursPerMonth] forKey:@"hoursPerMonth"];
	printf("\nModel has encoded %s",[[self name] UTF8String]);
}

@end
