import pandas as pd

# This script is not longer needed.
# It was used to find malformed species data, and beginning to correct it.

# load all data point
raw_df = pd.read_csv("landsend_veg_2007_2012.csv", na_values = ['-', ''])

species_info = raw_df[[u'species', u'plant_code', u'native_status',
                       u'life_history', u'stature']]

# find and replace spelling mistakes
spelling_fixes = {
    "anagallis arvensis": "anagalis arvensis",
    'gnaphalium luteo-album': 'gnaphalium luteoalbum',
    'ceanothus thrysiflorus': 'ceanothus thyrsiflorus',
    'anthriscus cacaulis': 'anthriscus caucalis',
    'marah fabaceous': 'marah fabaceus',
    'medicago indica': 'melilotus indica'
}

[species_info.replace(to_replace=misspelled, value=spelled, inplace=True)
 for misspelled, spelled in spelling_fixes.iteritems()]

species_info = species_info.dropna(how='any')
known_species_info = species_info.drop_duplicates()
known_species_info = known_species_info[known_species_info.species !=
                                        'mimulus auranticus']

cond = ((~((known_species_info.species == 'ehrharta erecta')
         & (known_species_info.life_history == 'Annual'))) &
        (~((known_species_info.species == 'elymus glaucus') & (
             known_species_info.stature == 'Forb'))) &
        (~((known_species_info.species == 'artemisia pycnocephala')
         & (known_species_info.stature == 'Forb'))))

known_species_info = known_species_info[cond]

# load file with missing labels
missing_species_info = pd.read_csv("missing_species_info.csv")

missing_species_info['species'] = missing_species_info['species'].str.lower()
known_species_info = known_species_info.append(missing_species_info,
                                               ignore_index=True).drop_duplicates()
joined_species_info = pd.merge(raw_df, known_species_info, on='species',
                           how='left')