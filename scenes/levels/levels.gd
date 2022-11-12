extends Node








#
#var input_json = [
#	{"answer":"standard"},
#	{"answer":"computer"},
#	{"answer":"equipment"},
#	{"answer":"port"},
#	{"answer":"interface"}]


#[0] - word
#[1] - clue
#[2] - solved

var levels_json = [

	[["IS", ""],
	["SIX",""],
	],
	
	[["DAD", ""],
	["ADD",""],
	],
	
#	levle 1
	[["HOW", ""],
	["WHO",""],
	],

	[["ERA", ""],
	["EAR",""],
	["ARE",""],
	],
	
	[["LAW", ""],
	["ALL",""],
	["WALL",""],
	],
	
	[["YOUR", ""],
	["OUR",""],
	["OR",""],
	],
	
	[["RAY", ""],
	["DRY",""],
	["DAY",""],
	["YARD",""]
	],
	
	[["WAS", ""],
	["WAR",""],
	["SAW",""],
	["RAW", ""],
	["WARS", ""]
	],
	
#	levle 9
	[["YES", ""],
	["SEE",""],
	["EYE",""],
	["EYES", ""]
	],
	
#	levle 10
	[["OLD", ""],
	["LOG",""],
	["GOD",""],
	["DOG",""],
	["GOLD",""],
	],
	
#------------------------------------------------------------

#	Level 11
	[["WON", ""],
	["ROW",""],
	["OWN",""],
	["NOW",""],
	["NOR", ""],
	["WORN",""],
	],
	
#	Level 12
	[["TON", ""],
	["TOE",""],
	["TEN",""],
#	["ONE", ""],
	["NOT", ""],
	["NET",""],
	["TONE",""],
	["NOTE",""],
	],
	
	
#	Level 13
	[["PAY", ""],
	["PAL",""],
	["LAY",""],
	["LAP",""],
	["PLAY",""],
	],
	
#	Level 14
	[["TAP", ""],
	["PAT",""],
	["CAT",""],
	["ACT",""],
	["PACT",""],
	],
	
#	Level 15
	[["KIN", ""],
#	["SIN",""],
#	["SKI",""],
	["INK",""],
	["SKIN",""],
	["SINK", ""]
	],
	
#	Level 16
	[["SEE", ""],
	["SEES",""],
	["SEEM",""],
	["SEEMS",""],
	["MESS",""],
	],
	
#	Level 17
	[["TIE", ""],
	["THE",""],
	["HIT",""],
	["GET",""],
	["EIGHT",""],
	],
	
	
#	Level 18
	[["LAB", ""],
	["CAB",""],
	["LACK",""],
	["BACK",""],
#	["BLACK",""],
	],
	
#	Level 19
	[["SOLE", ""],
	["LOVE",""],
	["LOSE",""],
	["SOLVE",""],
	["LOVES",""],
	],

#	Level 20
	[["SEA", ""],
	["ASK",""],
	["SAKE",""],
	["SACK",""],
	["CASE",""],
	["CAKE",""],
	["CAKES",""],
	],

#----------------------------------------------------

	#	Level 21
	[["SEEM", ""],
	["MET",""],
	["STEM",""],
	["MEET",""],
	["MEETS",""],
	["TEEM",""],
	],
	
	#	Level 22
	[["HOST", ""],
	["TOSS",""],
	["SHOT",""],
#	["HOT",""],
	["SHOTS",""],
	["HOSTS",""],
	],

	#	Level 23
	[["DUE", ""],
#	["DUG",""],
	["DIG",""],
	["DIE",""],
	["GUIDE",""],
	],

	#	Level 24
	[["END", ""],
	["DEN",""],
	["SEND",""],
	["ENDS",""],
	["SENDS",""],
	],
	
	#	Level 25
	[["SIT", ""],
#	["ITS", ""],
	["SUIT",""],
	["SITS",""],
	["SUITS",""],
	],
	
	#	Level 26
	[["TIN", ""],
	["NUT",""],
	["UNIT",""],
	["TINY",""],
	["UNITY",""],
	],
	
	#	Level 27
	[["LIP", ""],
#	["SIP",""],
	["SLIP",""],
	["LIPS",""],
	["SLIPS",""],
	],
	
	#	Level 28
	[["USE", ""],
	["SUE",""],
	["SEC",""],
	["CUE",""],
	["CUES",""],
	["CLUE",""],
	["CLUES",""],
	],
	
	#	Level 29
	[["SEE", ""],
#	["SEA",""],
#	["SAD",""],
	["SEED",""],
	["EASE",""],
	["EASED",""],
	],
	
	#	Level 30
	[["YET", ""],
	["YEP",""],	
	["PET",""],
	["TYPE",""],
	["PETTY",""],
	],
	
#----------------------------------------------------------------
	
	#	Level 31
	[["HAS", ""],
	["BRA",""],
	["BAR",""],
#	["ASH",""],
	["RASH",""],
	["BASH",""],
	["BARS",""],
	["BRASH",""],
	],
	
	#	Level 32
	[["DUO", ""],
	["TUB",""],
	["DOT",""],
	["BOT",""],
	["BUT",""],
	["BUD",""],
	["BOUT",""],
	["DOUBT",""],
	],

	#	Level 33
	[["SUM", ""],
#	["RUM",""],
	["MUD",""],
	["DRUM",""],
	["DRUMS",""],
	],

	#	Level 34
	[["RED", ""],
	["TREE",""],
	["REED",""],
	["DEER",""],
	["DETER",""],
	],
		
	#	Level 35
	[["YOU", ""],
	["SOY",""],
	["SLY",""],
	["SOUL",""],
	["LOUSY",""],
	],

	#	Level 36
	[["OWL", ""],
	["LOW",""],
	["LAW",""],
	["ALL",""],
	["WALL",""],
	["ALLOW",""],
	],
		
	#	Level 37
	[["RAY", ""],
	["HAY",""],
	["HAD",""],
	["DRY",""],
	["DAY",""],
	["YARD",""],
	["HARD",""],
	["HARDY",""],
	],
	
	#	Level 38
	[["SEA", ""],
	["ERA",""],
	["EAR",""],
	["ARE",""],
	["SEAS",""],
	["EARS",""],
	["SEARS",""],
	],

	#	Level 39
	[["YET", ""],
	["YES",""],
	["SET",""],
	["LET",""],
	["LETS",""],
	["STYLE",""],
	],

	#	Level 40
	[["SEX", ""],
#	["SET",""],
	["TEXT",""],
	["TEST",""],
	["TEXTS",""],
	],

#------------------------------------------------------------

	#	Level 41
	[["FOOL", ""],
	["OLD",""],
#	["FOOD",""],
#	["FOLD",""],
	["FLOOD",""],
	],

	#	Level 42
	[["ROD", ""],
	["NOR",""],
#	["NOD",""],
	["DON",""],
	["ODOR",""],
	["DOOR",""],
	["DONOR",""],
	],
	
	#	Level 43
	[["WON", ""],
	["WAN",""],
	["OWN",""],
	["NOW",""],
#	["AGO",""],
	["GOWN",""],
	["WAGON",""],
	],

	#	Level 44
	[["PAL", ""],
#	["PAY",""],
	["LAY",""],
	["LAP",""],
	["PLAY",""],
	["APPLY",""],
	],

	#	Level 45
	[["HAT", ""],
#	["CAT",""],
	["ACT",""],
	["CHAT",""],
	["CATCH",""],
	],
	
	#	Level 46
	[["SKI", ""],
	["SIC",""],
	["SICK",""],
	["KICK",""],
	["KICKS",""],
	],

	#	Level 47
	[["SEE", ""],
	["EVE",""],
	["SEEN",""],
#	["EVEN",""],
	["SEVEN",""],
	],
	
	#	Level 48
	[["RID", ""],
	["HIT",""],
	["HID",""],
	["DIRT",""],
	["THIRD",""],
	],

	#	Level 49
	[["TEN", ""],
	["NET",""],
	["LET",""],
	["KEN",""],
	["KNELT",""],
	],
	
	#	Level 50
	[["SEA", ""],
#	["SAD",""],
	["VASE",""],
	["SAVE",""],
	["SAVED",""],
	],
	
#----------------------------------------------------------

	#	Level 51
	[["SIN", ""],
	["GIN",""],
	["SINS",""],
	["SING",""],
	["SINGS",""],
	["SIGN",""],
	["SIGNS",""],
	],

	#	Level 52
	[["SCAN", ""],
	["ASK",""],
	["CANS",""],
	["SANK",""],
	["SACK",""],
	["SNACK",""],
	],

	#	Level 53
	[["TOY", ""],
	["LOT",""],
	["FLY",""],
	["LOFT",""],
#	["LOFTY",""],
	],
	
	#	Level 54
	[["THE", ""],
	["HER",""],
	["BET",""],
	["HERB",""],
	["BERTH",""],
	],
	
	#	Level 55
	[["MIX", ""],
	["MID",""],
	["DIM",""],
	["DIE",""],
	["DIME",""],
	["MIXED",""],
	],

	#	Level 56
	[["END", ""],
	["DEN",""],
	["BED",""],
	["SEND",""],
	["ENDS",""],
	["BEND",""],
	["BEDS",""],
	["BENDS",""],
	],
	
	#	Level 57
	[["RUG", ""],
	["OUR",""],
#	["HUG",""],
	["HOG",""],
	["HOUR",""],
	["ROUGH",""],
	],
	
	#	Level 58
	[["SIP", ""],
	["LIP",""],
	["SLIP",""],
	["LIPS",""],
	["FLIP",""],
	["FLIPS",""],
	],
	
	#	Level 59
	[["ONE", ""],
#	["CUE",""],
	["ONCE",""],
	["CONE",""],
	["OUNCE",""],
	],

	#	Level 60
	[["INK", ""],
	["KIN",""],
	["BIN",""],
	["BRINK",""],
	],

#--------------------------------------------------------------

	#	Level 61
	[["COP", ""],
#	["HOP",""],
#	["PRO",""],
	["CROP",""],
	["CHOP",""],
	["PORCH",""],
	],

	#	Level 62
	[["TON", ""],
	["NOT",""],
#	["HOT",""],
	["COT",""],
	["NOTCH",""],
	],
	
	#	Level 63
	[["TUB", ""],
	["HUT",""],
	["HUM",""],
	["HUB",""],
	["BUT",""],
	["THUMB",""],
	],

	#	Level 64
	[["SUN", ""],
	["GUN",""],
	["SUNG",""],
	["SNUG",""],
	["GUNS",""],
	["SWUNG",""],
	],

	#	Level 65
	[["MORE", ""],
#	["ORE",""],
#	["CORE",""],
	["COME",""],
	["COMER",""],
	],

	#	Level 66
	[["SLY", ""],
#	["YES",""],
	["YELL",""],
	["SELL",""],
	["YELLS",""],
	],

	#	Level 67
	[["ALL", ""],
	["TALL",""],
	["SALT",""],
	["LAST",""],
	["STALL",""],
	],

	#	Level 68
	[["MAR", ""],
	["MAD",""],
	["DAM",""],
	["ARM",""],
	["DRAMA",""],
	],

	#	Level 69
	[["ERA", ""],
	["EAR",""],
	["ARE",""],
	["AGE",""],
	["RAGE",""],
	["GEAR",""],
	["EAGER",""],
	["AGREE",""],
	],
	
	#	Level 70
	[["DIG", ""],
#	["ILL",""],
	["GIRL",""],
	["LID",""],
	["GRILL",""],
	],

#-------------------------------------------------------------------------

	#	Level 71
	[["MET", ""],
#	["SET",""],
	["TERM",""],
	["STEM",""],
	["REST",""],
	["TERMS",""],
	],

	#	Level 72
	[["OWL", ""],
#	["OLD",""],
	["LOW",""],
	["DUO",""],
	["LOUD",""],
	["WOULD",""],
	],

	#	Level 73
	[["RAY", ""],
	["HAY",""],
	["AIR",""],
	["HAIR",""],
#	["AIRY",""],
#	["HAIRY",""],
	],

	#	Level 74
	[["NOW", ""],
#	["WON",""],
	["ROW",""],
	["OWN",""],
	["NOR",""],
	["COW",""],
	["WORN",""],
	["CROW",""],
	["CROWN",""],
	],

	#	Level 75
	[["PAN", ""],
	["PAL",""],
	["NAP",""],
	["LAP",""],
	["PLAN",""],
	["PLANK",""],
	],

	#	Level 76
	[["HAT", ""],
#	["MAT",""],
#	["HAM",""],
	["CAT",""],
	["ACT",""],
	["MATH",""],
#	["CHAT",""],
	["MATCH",""],
	],

	#	Level 77
	[["RAP", ""],
	["GAP",""],
	["RAG",""],
	["HARP",""],
	["GRAPH",""],
	],

	#	Level 78
	[["SEE", ""],
	["FEE",""],
	["FED",""],
	["SEED",""],
	["FEES",""],
	["FEED",""],
	["FEEDS",""],
	],

	#	Level 79
	[["SIX", ""],
	["SIT",""],
#	["HIT",""],
	["HIS",""],
	["THIS",""],
	["HITS",""],
	["SIXTH",""],
	],

	#	Level 80
	[["DRY", ""],
#	["RID",""],
#	["TRY",""],
	["TIDY",""],
	["DIRT",""],
	["DIRTY",""],
	],

#--------------------------------------------------------

	#	Level 81
	[["SEA", ""],
	["SEAS",""],
	["BASS",""],
#	["BASE",""],
	["BASES",""],
	],

	#	Level 82
	[["EVE", ""],
	["VET",""],
	["TEN",""],
	["NET",""],
	["VENT",""],
	["TEEN",""],
	["EVEN",""],
	["EVENT",""],
	],

	#	Level 83
	[["ASK", ""],
	["SACK",""],
	["LACK",""],
	["SLACK",""],
	["LACKS",""],
	],

	#	Level 84
	[["LOT", ""],
	["TOSS",""],
	["SLOT",""],
#	["LOTS",""],
	["LOST",""],
#	["LOSS",""],
	["SLOTS",""],
	],

	#	Level 85
	[["LAD", ""],
#	["SAD",""],
	["AND",""],
	["SAND",""],
	["LAND",""],
	["LANDS",""],
	],

	#	Level 86
	[["USE", ""],
	["SUE",""],
	["SUB",""],
	["BUS",""],
	["BLUE",""],
	["BLUES",""],
	],

	#	Level 87
	[["EYE", ""],
	["END",""],
	["DYE",""],
	["DEN",""],
	["NEED",""],
	["EYED",""],
	["DENY",""],
	["NEEDY",""],
	],

	#	Level 88
	[["RUG", ""],
	["DUG",""],
#	["GRAD",""],
	["DRUG",""],
	["DRAG",""],
	["GUARD",""],
	],

	#	Level 89
	[["SPY", ""],
#	["SIP",""],
#	["SIC",""],
	["ICY",""],
	["SPICY",""],
	],

	#	Level 90
	[["SON", ""],
	["ONE",""],
	["ZONE",""],
	["ONES",""],
	["NOSE",""],
	["ZONES",""],
	],

#-----------------------------------------------------

	#	Level 91
	[["SIN", ""],
	["SKI",""],
	["KIN",""],
	["INK",""],
	["SKIS",""],
	["SKIN",""],
	["SINS",""],
	["SINK",""],
	["KISS",""],
	["SKINS",""],
	["SINKS",""],
	["SIGNS",""],
	],

	#	Level 92
	[["PRO", ""],
	["POP",""],
	["PROP",""],
	["POPS",""],
	["PROPS",""],
	],

	#	Level 93
	[["TON", ""],
	["OUT",""],
	["NUT",""],
	["NOT",""],
	["UNTO",""],
	["MOUNT",""],
	],

	#	Level 94
	[["RUM", ""],
	["OUR",""],
#	["HUM",""],
	["HOUR",""],
	["HUMOR",""],
	],

	#	Level 95
	[["HUT", ""],
	["THUS",""],
	["SHUT",""],
	["HUTS",""],
	["SHUTS",""],
	],

	#	Level 96
	[["ORE", ""],
	["SORE",""],
	["SOLE",""],
	["ROSE",""],
	["ROLE",""],
	["LOSE",""],
	["LORE",""],
	["ROLES",""],
	["LOSER",""],
	],

	#	Level 97
	[["TAMED", "clue1"],
	["MEAD", "clue2"],
	["EAT", "clue3"],
	["ATE", "clue4"],
	["A", "clue4"],
	["MADE", "clue5"],
	["DAM", "clue6"],
	["MATED", "clue7"],
	],

	#	Level 98
	[["WAY", ""],
#	["LAY",""],
	["LAW",""],
	["ALL",""],
	["WALL",""],
	["ALLY",""],
	["WALLY",""],
	],

	#	Level 99
	[["MAR", ""],
#	["FAR",""],
	["ARM",""],
	["RAM",""],
	["MARS",""],
	["FARM",""],
#	["ARMS",""],
	["FARMS",""],
	],

	#	Level 100
	[["WAR", ""],
	["RAW",""],
	["ERA",""],
	["EAR",""],
	["AWE",""],
	["ARE",""],
	["WEAR",""],
	["AREA",""],
	["AWARE",""],
	],

	#	Level 101
	[["TOP", ""],
	["POT",""],
#	["OPT",""],
	["LOT",""],
	["TOPS",""],
	["STOP",""],
	["SPOT",""],
	["SLOT",""],
	["POTS",""],
	["POST",""],
	["PLOT",""],
	["LOTS",""],
	["PLOTS",""],
	],


	[["IS", ""],
	["SIX",""],
	],
	
	
	
]





