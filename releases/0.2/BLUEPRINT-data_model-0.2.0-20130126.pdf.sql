
-- Donor Data File
CREATE TABLE cdata_donor (
	donor_id VARCHAR(4096) NOT NULL,
	donor_age_at_diagnosis INTEGER NOT NULL,
	donor_diagnosis_do VARCHAR(4096) NOT NULL,
	donor_region_of_residence VARCHAR(4096) NOT NULL,
	donor_sex INTEGER NOT NULL,
	donor_vital_status INTEGER,
	notes VARCHAR(4096)
);


-- Donor Family History
CREATE TABLE cdata_family (
	donor_id VARCHAR(4096) NOT NULL,
	notes VARCHAR(4096),
	relationship_age INTEGER NOT NULL,
	relationship_diagnosis VARCHAR(4096) NOT NULL,
	relationship_diagnosis_do VARCHAR(4096) NOT NULL,
	relationship_sex INTEGER NOT NULL,
	relationship_type INTEGER NOT NULL,
	relationship_type_other VARCHAR(4096) NOT NULL
);


-- Specimen Data File
CREATE TABLE cdata_specimen (
	specimen_id VARCHAR(4096) NOT NULL,
	donor_id VARCHAR(4096) NOT NULL,
	notes VARCHAR(4096),
	specimen_available BOOL,
	specimen_biobank VARCHAR(4096),
	specimen_biobank_id VARCHAR(4096),
	specimen_processing VARCHAR(4096) NOT NULL,
	specimen_processing_other VARCHAR(4096),
	specimen_storage VARCHAR(4096) NOT NULL,
	specimen_storage_other VARCHAR(4096),
	specimen_type INTEGER NOT NULL,
	specimen_type_other VARCHAR(4096)
);


-- Analyzed Sample Data File
CREATE TABLE cdata_sample (
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	specimen_id VARCHAR(4096) NOT NULL,
	analyzed_sample_interval INTEGER,
	analyzed_sample_type INTEGER NOT NULL,
	analyzed_sample_type_other VARCHAR(4096),
	notes VARCHAR(4096)
);


-- Copy Number Germline Variations - Metadata File
CREATE TABLE cngv_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	alignment_algorithm VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	base_calling_algorithm VARCHAR(4096) NOT NULL,
	control_sample_id VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE,
	variation_calling_algorithm VARCHAR(4096) NOT NULL
);


-- Copy Number Germline Variations – Primary Analysis File
CREATE TABLE cngv_p (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	variation_id VARCHAR(4096) NOT NULL,
	chromosome INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_end_range INTEGER NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_start_range INTEGER NOT NULL,
	chromosome_strand INTEGER,
	copy_number DOUBLE,
	end_probe_id VARCHAR(4096),
	is_annotated BOOL,
	note VARCHAR(4096),
	probability DOUBLE,
	quality_score DOUBLE,
	segment_mean DOUBLE,
	segment_median DOUBLE,
	start_probe_id VARCHAR(4096),
	validation_platform INTEGER,
	validation_status INTEGER NOT NULL,
	variation_type VARCHAR(4096) NOT NULL
);


-- Expression - Metadata File
CREATE TABLE exp_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	alignment_algorithm VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	base_calling_algorithm VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE
);


-- Expression - Gene File
CREATE TABLE exp_g (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	gene_stable_id VARCHAR(4096) NOT NULL,
	chromosome INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_strand INTEGER,
	fold_change DOUBLE,
	is_annotated BOOL NOT NULL,
	normalized_expression_level DOUBLE,
	normalized_read_count DOUBLE NOT NULL,
	note VARCHAR(4096),
	probability DOUBLE,
	probeset_id VARCHAR(4096),
	quality_score DOUBLE,
	raw_read_count INTEGER NOT NULL,
	reference_sample VARCHAR(4096),
	validation_platform INTEGER,
	validation_status INTEGER NOT NULL
);


-- Exon Junction - Metadata File
CREATE TABLE jcn_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	alignment_algorithm VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	base_calling_algorithm VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE
);


-- Exon Junction - Primary Analysis File
CREATE TABLE jcn_p (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	junction_id VARCHAR(4096) NOT NULL,
	chromosome INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_strand INTEGER,
	exon1_chromosome INTEGER NOT NULL,
	exon1_end INTEGER NOT NULL,
	exon1_number_bases INTEGER NOT NULL,
	exon1_strand INTEGER,
	exon2_chromosome INTEGER NOT NULL,
	exon2_number_bases INTEGER NOT NULL,
	exon2_start INTEGER NOT NULL,
	exon2_strand INTEGER,
	gene1_stable_id VARCHAR(4096) NOT NULL,
	gene2_stable_id VARCHAR(4096),
	is_fusion_gene BOOL,
	is_novel_splice_form BOOL,
	junction_read_count INTEGER NOT NULL,
	junction_seq VARCHAR(4096),
	junction_type INTEGER,
	note VARCHAR(4096),
	probability DOUBLE,
	quality_score DOUBLE,
	validation_platform INTEGER,
	validation_status INTEGER NOT NULL
);


-- Protein-DNA interaction - Metadata File
CREATE TABLE pdna_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	NSC DOUBLE,
	RSC DOUBLE,
	alignment_algorithm VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	base_calling_algorithm VARCHAR(4096) NOT NULL,
	control_sample_id VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE
);


-- Protein-DNA interaction - Primary Analysis File
CREATE TABLE pdna_p (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	protein_dna_interaction_id VARCHAR(4096) NOT NULL,
	chromosome INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_strand INTEGER,
	fdr DOUBLE NOT NULL,
	idr DOUBLE NOT NULL,
	note VARCHAR(4096),
	protein_stable_id VARCHAR(4096) NOT NULL,
	rank VARCHAR(4096),
	validation_platform INTEGER,
	validation_status INTEGER NOT NULL
);


-- Protein-DNA interaction - Secondary Analysis File
CREATE TABLE pdna_s (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	ensembl_version INTEGER NOT NULL,
	gene_affected VARCHAR(4096) NOT NULL,
	note VARCHAR(4096),
	protein_dna_interaction_id VARCHAR(4096) NOT NULL,
	transcript_affected VARCHAR(4096)
);


-- Regulatory regions - Metadata File
CREATE TABLE rreg_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	alignment_algorithm VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	base_calling_algorithm VARCHAR(4096) NOT NULL,
	control_sample_id VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE
);


-- Regulatory regions - Primary Analysis File
CREATE TABLE rreg_p (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	regulatory_region_id VARCHAR(4096) NOT NULL,
	chromosome INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_strand INTEGER,
	normalized_read_count DOUBLE NOT NULL,
	note VARCHAR(4096),
	probability DOUBLE,
	quality_score DOUBLE,
	raw_read_count INTEGER NOT NULL,
	validation_platform INTEGER,
	validation_status INTEGER NOT NULL
);


-- Regulatory regions - Secondary Analysis File
CREATE TABLE rreg_s (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	ensembl_version INTEGER NOT NULL,
	gene_affected VARCHAR(4096) NOT NULL,
	note VARCHAR(4096),
	regulatory_region_id VARCHAR(4096) NOT NULL
);


-- DNA *-lation - Metadata File
CREATE TABLE dlat_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	alignment_algorithm VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	base_calling_algorithm VARCHAR(4096) NOT NULL,
	control_sample_id VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	methylation_calling_algorithm VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE
);


-- DNA *-lation - Primary Analysis File
CREATE TABLE dlat_p (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	d_lated_fragment_id VARCHAR(4096) NOT NULL,
	beta_value DOUBLE,
	c_total_reads DOUBLE NOT NULL,
	chromosome INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_strand INTEGER,
	d_lated_reads DOUBLE NOT NULL,
	d_lation_type VARCHAR(4096) NOT NULL,
	note VARCHAR(4096),
	probability DOUBLE,
	quality_score DOUBLE,
	total_reads DOUBLE NOT NULL,
	validation_platform INTEGER,
	validation_status INTEGER NOT NULL
);


-- DNA *-lation - Secondary Analysis File
CREATE TABLE dlat_s (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	d_lated_fragment_id VARCHAR(4096) NOT NULL,
	ensembl_version INTEGER NOT NULL,
	gene_affected VARCHAR(4096) NOT NULL,
	note VARCHAR(4096)
);

