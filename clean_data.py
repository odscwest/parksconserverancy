import pandas as pd

raw_df = pd.read_csv("landsend_veg_2007_2012.csv", na_values = '-')

original_count = raw_df.count()

# rename columns
raw_df.columns = [u'site_year_code', u'transect', u'point', u'height ',
                  u'species', u'plant_code', u'native_status',
                  u'life_history', u'stature']

species_info = raw_df[[u'species', u'plant_code', u'native_status',
                       u'life_history', u'stature']]
species_info.replace(to_replace="Anagallis arvensis", value="Anagalis arvensis")
species_info = species_info.dropna(how='any')
known_species_info = species_info.drop_duplicates()
joined_species_info = pd.merge(raw_df, known_species_info, on='species',
                           how='left')
# select the native status and life history with the least nulls
cleaned = joined_species_info[[u'site_year_code', u'transect', u'point',
                           u'height ',u'species',
                           u'native_status_y', u'life_history_y',
                           u'plant_code_y', u'stature_y']]
cleaned.columns = [u'site_year_code', u'transect', u'point',
                           u'height ',u'species',
                           u'native_status', u'life_history', u'plant_code',
                           u'stature']

transformed_count = cleaned.count()

print "original row count: [%s]\ntransformed row count: [%s]" % \
      (original_count, transformed_count)

cleaned.to_csv("cleaned_landsend_veg_2007_2012.csv", index=False)

# missing values:
"""
Annual exotic grass
Annual grass litter
Anthriscus cacaulis
Artemisia californica
Bromus hordeaceus
Castilleja affinis
Chenopodium califoricum
Claytonia perfoliata
Dudleya farinosa
Erodium sp
Galium aparine
Gnaphalium sp
Grass litter
Heracleum lanatum
Heteromeles arbutifolia
Iris douglasiana
Juncus bufonius
Juncus leseuerii
Leymus triticoides
Lotus scoparius
Lotus strigosus
Marah fabaceous
Medicago indica
Medicago polymorpha
Melilotus indica
Oxalis incarnata
Phacilia californica
Pinus radiata
PIRA litter
Poa annua
Polygonum arenastrum
Ribes sanguineum
Rumex acetosella
Satureja douglasii
Silene gallica
Sisyrinchium bellum
Solanum nigrum
Sonchus oleraceus
Stachys ajugoides
Stellaria media
Taraxacum offianale
Vicia sativa
Vulpia myuros
Vulpia sp
Hedera helix ssp. canariensis
Pteridium aquilinum
Cynosurus echinatus
Toxicodendron diversilobum
Holcus lanatus
Rhamnus californica
Carpobrotus edulis
Abronia latifolia
Achillea millefolium
Artemisia pycnocephala
Avena fatua
ericameria ericoides
Grindelia hirsutula var. maritima
Juncus sp.
Lavatera arborea
mimulus auranticus
Oxalis pes-caprae
Tanacetum camphoratum
Tetragonia tetragonioides
Malva neglecta
Mimulus auranticus
Juncus patens
Cardionema ramosissimum
Equisetum laevigatum
Phacelia californica
Senecio vulgaris
Taraxacum officinalis
Vulpia bromoides
Artemisia californica
Avena barbada
Baccharius pilularis
Bromus Carinatus
Bromus diandrus
Festuca rubra
Rumex Salicifolius
Solanum
"""