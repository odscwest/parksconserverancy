import pandas as pd

def fix_misspellings(df):
    spelling_fixes = {
        "anagallis arvensis": "anagalis arvensis",
        'gnaphalium luteo-album': 'gnaphalium luteoalbum',
        'ceanothus thrysiflorus': 'ceanothus thyrsiflorus',
        'anthriscus cacaulis': 'anthriscus caucalis',
        'marah fabaceous': 'marah fabaceus',
        'medicago indica': 'melilotus indica',
        'artemisa pycnocephala': 'artemisia pycnocephala',
        'artemisa californica': 'artemisia californica',
        'artemisa pycnocephala': 'artemisia pycnocephala',
        'baccharius pilularis': 'baccharis pilularis',
        'juncus lesuerii': 'juncus lesueurii',
        'juncus leseuerii': 'juncus lesueurii',
        'mimulus auranticus': 'mimulus aurantiacus',
        'phacilia californica': 'phacelia californica',
        'sonchus oleraceous': 'sonchus oleraceus',
        'viscia sativa': 'vicia sativa',
        'anthriscus cacaulis': 'anthriscus caucalis',
        'artemisa pycnocephala': 'artemisia pycnocephala',
        'iris douglasii': 'iris douglasiana',
        'polygonum paranychium': 'polygonum paronychia',
        'taraxacum officinalis': 'taraxacum offianale',
        'tree stump': 'dead tree stump',
        'annual grass litter': 'litter',
        'grass litter': 'litter',
        'pira litter': 'litter',
        'solanum': 'solanum sp.',
        'thatch': 'litter',
        'bromus diandrus ': 'bromus diandrus',
        'avsp litter': 'litter',
        'brdi litter': 'litter',
        'bromus corinatus ssp. maritimus': 'bromus corinatus',
        'brma litter': 'litter',
        'cuma litter': 'litter',
        'cypress litter': 'litter',
        'grass litter': 'litter',
        'grindelia hirsutula var. hirsutula': 'grindelia hirsutula',
        'hedera helix ssp. canariensis': 'hedera helix',
        "losp litter": 'litter',
        "pira litter": 'litter',
        "thatch/woody debris" : 'litter',
        "cuma pira litter": 'litter',
        "grindelia hirsutula var. maritima": "grindelia hirsutula",
        "plant debris litter": "litter",
        "unknown grass": 'grass',
        'tarp/fabric': 'litter'
    }
    species = df.species
    [species.replace(to_replace=misspelled, value=spelled, inplace=True)
     for misspelled, spelled in spelling_fixes.iteritems()]
    df.species = species
    return df

def lower_case_all_str_cols(df):
    # lowercase all string cols names
    str_cols = [u'site_year_code', u'species', u'plant_code', u'native_status',
            u'life_history', u'stature']

    def lower(col):
        df[col] = df[col].str.lower()

    [lower(col) for col in str_cols]
    return df

# find and replace spelling mistakes
spelling_fixes = {
    "anagallis arvensis": "anagalis arvensis",
    'gnaphalium luteo-album': 'gnaphalium luteoalbum',
    'ceanothus thrysiflorus': 'ceanothus thyrsiflorus',
    'anthriscus cacaulis': 'anthriscus caucalis',
    'marah fabaceous': 'marah fabaceus',
    'medicago indica': 'melilotus indica',
    'artemisa pycnocephala': 'artemisia pycnocephala',
    'artemisa californica': 'artemisia californica',
    'artemisa pycnocephala': 'artemisia pycnocephala',
    'baccharius pilularis': 'baccharis pilularis',
    'juncus lesuerii': 'juncus lesueurii',
    'juncus leseuerii': 'juncus lesueurii',
    'mimulus auranticus': 'mimulus aurantiacus',
    'phacilia californica': 'phacelia californica',
    'sonchus oleraceous': 'sonchus oleraceus',
    'viscia sativa': 'vicia sativa',
    'anthriscus cacaulis': 'anthriscus caucalis',
    'artemisa pycnocephala': 'artemisia pycnocephala',
    'iris douglasii': 'iris douglasiana',
    'polygonum paranychium': 'polygonum paronychia',
    'taraxacum officinalis': 'taraxacum offianale',
    'tree stump': 'dead tree stump',
    'annual grass litter': 'litter',
    'grass litter': 'litter',
    'pira litter': 'litter',
    'solanum': 'solanum sp.',
    'thatch': 'litter',
    'annual exotic grass': 'grass',
    'bromus diandrus ': 'bromus diandrus',
    'avsp litter': 'litter',
    'brdi litter': 'litter',
    'bromus corinatus ssp. maritimus': 'bromus corinatus',
    'brma litter': 'litter',
    'cuma litter': 'litter',
    'cypress litter': 'litter',
    'grass litter': 'litter',
    'grindelia hirsutula var. hirsutula': 'grindelia hirsutula',
    'hedera helix ssp. canariensis': 'hedera helix',
    "losp litter": 'litter',
    "pira litter": 'litter',
    "thatch/woody debris" : 'litter',
    "cuma pira litter": 'litter',
    "grindelia hirsutula var. maritima": "grindelia hirsutula",
    "plant debris litter": "litter",
    "unknown grass": 'grass',
    'tarp/fabric': 'litter'
}

def replace_missing_data(raw_df, correct_species_info):
    joined_species_info = pd.merge(raw_df, correct_species_info, on='species',
                               how='left')

    # select the native status, life history, plant code, and stature for species
    # from the species_info
    cleaned = joined_species_info[[u'site_year_code', u'transect', u'point',
                               u'height',u'species',
                               u'native_status_y', u'life_history_y',
                               u'plant_code_y', u'stature_y']]
    # drop the _y in the column name resulting from the join
    cleaned.columns = [u'site_year_code', u'transect', u'point',
                               u'height',u'species',
                               u'native_status', u'life_history', u'plant_code',
                               u'stature']
    return cleaned

# Load raw data
raw_df = pd.read_csv("landsend_veg_2007_2012.csv", na_values = ['-', ''])

# Record to original count for validation once data transform is complete
original_count = raw_df.count()

# rename columns to be code friendly
raw_df.columns = [u'site_year_code', u'transect', u'point', u'height',
                  u'species', u'plant_code', u'native_status',
                  u'life_history', u'stature']
# lower case species names
lower_cased = lower_case_all_str_cols(raw_df)
# correct misspellings in species names
fixed_spelling = fix_misspellings(lower_cased)
# Load outside species info
species_info = pd.read_csv("species_info.csv")
# correct species values with ground truth
cleaned = replace_missing_data(fixed_spelling, species_info)
# validate that we have the same number of rows
transformed_count = cleaned.count()

# Do we have the same numver of rows?
# How many more species labels have we joined in?
print "original row count: [%s]\ntransformed row count: [%s]" % \
      (original_count, transformed_count)

# write results to file.
cleaned.to_csv("cleaned_landsend_veg_2007_2012.csv", index=False)
