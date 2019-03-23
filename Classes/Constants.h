//
// File:	   Constants.h
//
// Abstract:   Contant screen placement values for controls.
//
// Version:    1.7
//
//
// Copyright (C) 2008 Apple Inc. All Rights Reserved.
//

#define kCustomButtonHeight		30.0

// keys to our dictionary holding info on each page
#define kCellIdentifier			@"MyIdentifier"
#define kViewControllerKey		@"viewController"
#define kTitleKey				@"title"
#define kExplainKey				@"explainText"

#define kEntry					0
#define kPro                    1
#define kEnterprise				2
#define kLevel					kEntry

// constants for PickerController
// these are the various screen placement constants used across all the UIViewControllers

// padding for margins
#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kBottomMargin			20.0
#define kTweenMargin			10.0

// control dimensions
#define kStdButtonWidth			106.0
#define kStdButtonHeight		40.0
#define kSegmentedControlHeight 40.0
#define kPageControlHeight		20.0
#define kPageControlWidth		160.0
#define kSliderHeight			7.0
#define kSwitchButtonWidth		94.0
#define kSwitchButtonHeight		27.0
#define kTextFieldHeight		30.0
#define kSearchBarHeight		40.0
#define kLabelHeight			20.0
#define kProgressIndicatorSize	40.0
#define kToolbarHeight			40.0
#define kUIProgressBarWidth		160.0
#define kUIProgressBarHeight	24.0

// specific font metrics used in our text fields and text views
#define kFontName				@"Arial"
#define kTextFieldFontSize		18.0
#define kTextViewFontSize		18.0

// UITableView row heights
#define kUIRowHeight			50.0
#define kUIRowLabelHeight		22.0

// table view cell content offsets
#define kCellLeftOffset			8.0
#define kCellTopOffset			12.0

#define monteCarloCount			1000

// persistent constants
#define kFilename				@"archive"
#define kDataKey				@"Data"
