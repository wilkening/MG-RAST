###################################
# this is an auto-generated package
# created by: /MG-RAST/bin/elastic_schema_parse.pl
# created on: 2018-07-05T15:32:51
###################################
package ElasticSearch;

use strict;
use warnings;
no warnings('once');

our $ontology = {
	'sample_biome' => 'biome',
	'sample_feature' => 'feature',
	'sample_material' => 'material',
	'sample_metagenome_taxonomy' => 'metagenome_taxonomy'
};

our $mixs = [
	'project_project_name',
	'sample_biome',
	'sample_feature',
	'sample_material',
	'sample_latitude',
	'sample_longitude',
	'sample_country',
	'sample_location',
	'sample_env_package',
	'sample_collection_date',
	'library_investigation_type',
	'library_seq_meth'
];

our $ids = {
	'id' => 'mgm',
	'project_project_id' => 'mgp',
	'sample_sample_id' => 'mgs',
	'library_library_id' => 'mgl',
	'env_package_env_package_id' => 'mge'
};

our $fields = {
	all => 'all_metadata',
	all_project => 'all_project',
	all_sample => 'all_sample',
	all_library => 'all_library',
	all_env_package => 'all_env_package',
	metagenome_id => 'id',
	job_id => 'job_info_job_id',
	created_on => 'job_info_created_on',
	name => 'job_info_name.keyword',
	public => 'job_info_public',
	sequence_type => 'job_info_sequence_type.keyword',
	mixs_compliant => 'job_info_mixs_compliant',
	average_gc_ratio_raw => 'job_stat_average_gc_ratio_raw',
	drisee_score_raw => 'job_stat_drisee_score_raw',
	alpha_diversity_shannon => 'job_stat_alpha_diversity_shannon',
	bp_count_raw => 'job_stat_bp_count_raw',
	average_length_raw => 'job_stat_average_length_raw',
	sequence_count_raw => 'job_stat_sequence_count_raw',
	ncbi_id => 'project_ncbi_id',
	PI_organization_country => 'project_PI_organization_country.keyword',
	PI_organization => 'project_PI_organization.keyword',
	organization => 'project_organization.keyword',
	PI_lastname => 'project_PI_lastname.keyword',
	PI_firstname => 'project_PI_firstname.keyword',
	firstname => 'project_firstname.keyword',
	lastname => 'project_lastname.keyword',
	greengenes_id => 'project_greengenes_id',
	organization_country => 'project_organization_country.keyword',
	project_ebi_id => 'project_project_ebi_id',
	project_funding => 'project_project_funding.keyword',
	project_name => 'project_project_name.keyword',
	project_id => 'project_project_id',
	biome_id => 'sample_biome_id',
	location => 'sample_location.keyword',
	elevation => 'sample_elevation',
	sample_name => 'sample_sample_name.keyword',
	metagenome_taxonomy => 'sample_metagenome_taxonomy.keyword',
	envo_label => 'sample_envo_label',
	latitude => 'sample_latitude',
	temperature => 'sample_temperature',
	biome => 'sample_biome.keyword',
	depth => 'sample_depth',
	envo_id => 'sample_envo_id',
	continent => 'sample_continent.keyword',
	longitude => 'sample_longitude',
	collection_date => 'sample_collection_date',
	ncbi_taxonomy_scientific_name => 'sample_ncbi_taxonomy_scientific_name',
	material => 'sample_material.keyword',
	country => 'sample_country.keyword',
	sample_id => 'sample_sample_id',
	ncbi_taxonomy_id => 'sample_ncbi_taxonomy_id',
	material_id => 'sample_material_id',
	feature_id => 'sample_feature_id',
	altitude => 'sample_altitude',
	sample_ebi_id => 'sample_sample_ebi_id',
	feature => 'sample_feature.keyword',
	metagenome_taxonomy_id => 'sample_metagenome_taxonomy_id',
	env_package => 'sample_env_package.keyword',
	env_package_id => 'env_package_env_package_id',
	env_package_type => 'env_package_env_package_type.keyword',
	env_package_name => 'env_package_env_package_name.keyword',
	library_name => 'library_library_name.keyword',
	investigation_type => 'library_investigation_type.keyword',
	mrna_percent => 'library_mrna_percent',
	library_ebi_id => 'library_library_ebi_id',
	seq_meth => 'library_seq_meth.keyword',
	gold_id => 'library_gold_id',
	target_gene => 'library_target_gene',
	pubmed_id => 'library_pubmed_id',
	library_id => 'library_library_id',
	priority => 'pipeline_parameters_priority.keyword',
	aa_pid => 'pipeline_parameters_aa_pid',
	fgs_type => 'pipeline_parameters_fgs_type.keyword',
	dereplicate => 'pipeline_parameters_dereplicate',
	screen_indexes => 'pipeline_parameters_screen_indexes.keyword',
	assembled => 'pipeline_parameters_assembled',
	m5rna_sims_version => 'pipeline_parameters_m5rna_sims_version',
	prefix_length => 'pipeline_parameters_prefix_length',
	m5nr_sims_version => 'pipeline_parameters_m5nr_sims_version',
	rna_pid => 'pipeline_parameters_rna_pid',
	m5rna_annotation_version => 'pipeline_parameters_m5rna_annotation_version',
	m5nr_annotation_version => 'pipeline_parameters_m5nr_annotation_version',
	pipeline_version => 'pipeline_parameters_pipeline_version',
	max_ambig => 'pipeline_parameters_max_ambig',
	filter_ln_mult => 'pipeline_parameters_filter_ln_mult',
	file_type => 'pipeline_parameters_file_type.keyword',
	filter_ambig => 'pipeline_parameters_filter_ambig',
	filter_ln => 'pipeline_parameters_filter_ln',
	bowtie => 'pipeline_parameters_bowtie',
};

our $prefixes = {
	'job_info_' => [
		'job_id',
		'created_on',
		'name',
		'public',
		'sequence_type',
		'mixs_compliant',
	],
	'job_stat_' => [
		'average_gc_ratio_raw',
		'drisee_score_raw',
		'alpha_diversity_shannon',
		'bp_count_raw',
		'average_length_raw',
		'sequence_count_raw',
	],
	'project_' => [
		'ncbi_id',
		'PI_organization_country',
		'PI_organization',
		'organization',
		'PI_lastname',
		'PI_firstname',
		'firstname',
		'lastname',
		'greengenes_id',
		'organization_country',
		'project_ebi_id',
		'project_funding',
		'project_name',
		'project_id',
	],
	'sample_' => [
		'biome_id',
		'location',
		'elevation',
		'sample_name',
		'metagenome_taxonomy',
		'envo_label',
		'latitude',
		'temperature',
		'biome',
		'depth',
		'envo_id',
		'continent',
		'longitude',
		'collection_date',
		'ncbi_taxonomy_scientific_name',
		'material',
		'country',
		'sample_id',
		'ncbi_taxonomy_id',
		'material_id',
		'feature_id',
		'altitude',
		'sample_ebi_id',
		'feature',
		'metagenome_taxonomy_id',
		'env_package',
	],
	'env_package_' => [
		'env_package_id',
		'env_package_type',
		'env_package_name',
	],
	'library_' => [
		'library_name',
		'investigation_type',
		'mrna_percent',
		'library_ebi_id',
		'seq_meth',
		'gold_id',
		'target_gene',
		'pubmed_id',
		'library_id',
	],
	'pipeline_parameters_' => [
		'priority',
		'aa_pid',
		'fgs_type',
		'dereplicate',
		'screen_indexes',
		'assembled',
		'm5rna_sims_version',
		'prefix_length',
		'm5nr_sims_version',
		'rna_pid',
		'm5rna_annotation_version',
		'm5nr_annotation_version',
		'pipeline_version',
		'max_ambig',
		'filter_ln_mult',
		'file_type',
		'filter_ambig',
		'filter_ln',
		'bowtie',
	],
};

our $types = {
	all => 'text',
	all_project => 'text',
	all_sample => 'text',
	all_library => 'text',
	all_env_package => 'text',
	metagenome_id => 'keyword',
	job_id => 'integer',
	created_on => 'date',
	name => 'text',
	public => 'boolean',
	sequence_type => 'text',
	mixs_compliant => 'boolean',
	average_gc_ratio_raw => 'float',
	drisee_score_raw => 'float',
	alpha_diversity_shannon => 'float',
	bp_count_raw => 'long',
	average_length_raw => 'float',
	sequence_count_raw => 'integer',
	ncbi_id => 'keyword',
	PI_organization_country => 'text',
	PI_organization => 'text',
	organization => 'text',
	PI_lastname => 'text',
	PI_firstname => 'text',
	firstname => 'text',
	lastname => 'text',
	greengenes_id => 'keyword',
	organization_country => 'text',
	project_ebi_id => 'keyword',
	project_funding => 'text',
	project_name => 'text',
	project_id => 'keyword',
	biome_id => 'keyword',
	location => 'text',
	elevation => 'float',
	sample_name => 'text',
	metagenome_taxonomy => 'text',
	envo_label => 'text',
	latitude => 'float',
	temperature => 'float',
	biome => 'text',
	depth => 'float',
	envo_id => 'keyword',
	continent => 'text',
	longitude => 'float',
	collection_date => 'date',
	ncbi_taxonomy_scientific_name => 'text',
	material => 'text',
	country => 'text',
	sample_id => 'keyword',
	ncbi_taxonomy_id => 'integer',
	material_id => 'keyword',
	feature_id => 'keyword',
	altitude => 'float',
	sample_ebi_id => 'keyword',
	feature => 'text',
	metagenome_taxonomy_id => 'keyword',
	env_package => 'text',
	env_package_id => 'keyword',
	env_package_type => 'text',
	env_package_name => 'text',
	library_name => 'text',
	investigation_type => 'text',
	mrna_percent => 'float',
	library_ebi_id => 'keyword',
	seq_meth => 'text',
	gold_id => 'keyword',
	target_gene => 'text',
	pubmed_id => 'keyword',
	library_id => 'keyword',
	priority => 'text',
	aa_pid => 'integer',
	fgs_type => 'text',
	dereplicate => 'boolean',
	screen_indexes => 'text',
	assembled => 'boolean',
	m5rna_sims_version => 'integer',
	prefix_length => 'integer',
	m5nr_sims_version => 'integer',
	rna_pid => 'integer',
	m5rna_annotation_version => 'integer',
	m5nr_annotation_version => 'integer',
	pipeline_version => 'keyword',
	max_ambig => 'integer',
	filter_ln_mult => 'float',
	file_type => 'text',
	filter_ambig => 'boolean',
	filter_ln => 'boolean',
	bowtie => 'boolean',
};

our $taxa_num = [
	1,
	5,
	10,
	15,
	20,
	25,
];

our $func_num = [
	1,
	3,
	5,
	10,
];

1;
