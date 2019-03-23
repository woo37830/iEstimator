//
//  EstimationModel.h
//  iEstimator
//
//  Created by John Wooten on 12/31/08.
//  Copyright 2008 ShouldersCorp.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EstimationModel : NSObject <NSCoding> {
	NSString *name;
	NSString *language;  // used to calculate slocFactor
	int extInputs; // input
	int extOutputs; // input
	int queries; // input
	int logicalFiles; // input
	int extInterfaces; // input
	int fp;
	float fps;
	float fps2;
	float ability; // modifies exponent by +- .03
	float exponent; // depends upon system type.
	float dur;
	int slocPPM;
	float sloc; // result of language and system type + inputs
	float effortPM;
	int teamSize;
	float blendedCostPerHour; // input
	float hoursPerMonth; // input
	float totalCost;
	double accuracy; 
	float durationStdDev;
	// Storage for keys and values for selectors
	NSArray *abilityValues;
	NSArray *abilityKeys; // input
	NSArray *systemTypeValues;
	NSArray *systemTypeKeys; // input
	NSArray *languageValues;
	NSArray *languageKeys; // input
	NSArray *estimationAccuracyValues;
	NSArray *estimationAccuracyKeys; // input
}

- (id) initWithName:(NSString *)aName;
- (void) initKeysAndValues;
- (void) update;
- (void) reset;
- (int) functionPoints;
- (int) sloc;
- (float) duration;
- (float) durationWithSigma: (float) sigma;
- (float) effort;
- (int) teamSize;
- (float) totalCost;
- (float) stdDev;

- (void) setExtInputs: (int)inputs;
- (int) extInputs;
- (void) setExtOutputs: (int)outputs;
- (int) extOutputs;
- (void) setQueries: (int) n;
- (int) queries;
- (void) setLogicalFiles: (int) n;
- (int) logicalFiles;
- (void) setExtInterfaces: (int) n;
- (int) extInterfaces;
- (void) setFunctionPoints: (int) n;
- (void) setAbilityStr: (NSString *) str;
- (void) setAbility: (float) x;
- (float) ability;
- (NSString *)abilityStr;
- (void) setSystemType:(NSString *) str;
- (void) setExponent: (float) x;
- (float) exponent;
- (NSString *)systemType;
- (void) setLanguage:(NSString *) str;
- (void) setSLOC: (int) n;
- (int) slocFactor;
- (NSString *)language;
- (void) setSlocPPM: (int) n;
- (int) slocPPM;
- (void) setBlendedCostPerHour: (float) x;
- (float) blendedCostPerHour;
- (void) setHoursPerMonth: (int) n;
- (int) hoursPerMonth;
- (void) setAccuracyStr:(NSString *) str;
- (void) setAccuracy: (double) x;
- (double) accuracy;
- (NSString *) accuracyStr;
- (void)setName:(NSString *)aName;
- (NSString *)name;
- (void)setTeamSize: (int)n;
// helper methods for converting from keys to values and back
-(float) keyToFloat:(NSString *)aStr usingsKeys:(NSArray *)keys andValues:(NSArray *)values;
-(NSString *)floatValueToKey:(float)floatValue usingsValues:(NSArray *)values andKeys:(NSArray *)keys;
- (NSArray *) abilityKeys;
- (NSArray *) systemTypeKeys;
- (NSArray *) languageKeys;
- (NSArray *) accuracyKeys;
@end
