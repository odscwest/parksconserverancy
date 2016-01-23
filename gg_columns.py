'''
Contains one function `define_column(col_name)` that prints and returns the definition of a column from the golden gate conservancy dataset.
'''


DEFINITIONS = {
    'Site-Year Code':
    'Four letter shortening of the full site name using the first two letters of the first word and first two letters of the second word. \n\nIf the site has more than two words in the name, initials  are used (e.g. Sutro Dunes = SUDO, Navy Memorial Slope = NMS). \n\nThe year the observations were made is attached to the site name (e.g. all observations taken in 2012 will have xxxx-2012 as a name).',

    'Transect Number':
    'The discrete line along which observations are made. \n\nIn this study this could be any number between zero and infinity, but should be sequential and at regular intervals.',

    'Point Number':
    'Discrete locations along the transect at predetermined intervals where observations are made. \n\nIn this case a dowel rod is dropped perpendicular to the tape and parallel to a standing person to the ground. In this study this could be any number between zero and infinity, though the numbers should be sequential and at regular intervals.',

    'Height':
    'Distance from the ground where plants cross the point on the transect. In this study, height classes were used:\n- Low = 0 to 0.5 meters\n- Medium = 0.51 to 2.0 meters\n- High = 2.1 to 15 meters\n- S (for super high) = 15+ meters',

    'Scientific Name':
    'The Latin genus and species assigned to the plant based on the Jepson Manual of California (1993 version, it has since been updated with new names in 2012). \n\nThe Jepson can be accessed online at ucjeps.berkeley.edu or on CalFlora at www.calflora.org',

    'Plant Code':
    'Four letter shortening of the plant name based on the first two letters of the genus and first two letters of the species. \n\nIf duplicates exist at a site, USDA plants (plants.usda.gov) will be consulted on the number to be added to the end (e.g. TRLA16 is Triteleia laxa, TRLA3 is Trichostemma lanatum).',

    'Native Status':
    'Whether the plant is considered native or exotic as defined by the Jepson Manual of California (1993).',

    'Life History':
    'Describes whether the plant is an annual or perennial plant. \n\nIf “shrub” is listed, this should be replaced with “perennial.” If “biennial” is listed, it should be replaced with “annual.”',

    'Stature':
    'In other studies this grouping has been called “guild.” \n\nIn this study the choices are forb*, grass, rush/sedge, shrub, or tree.\n\n*A forb is a soft-bodied plant that does not make a woody stem.'
}

def define_column(col_name):
    '''Takes a column name from the data set and returns the definition of that data column.
    '''
    coldef = DEFINITIONS[col_name]
    print coldef
    return coldef
