-- Generated from BLUEPRINT 0.2.3.4-a6979008015043a94ca2fa20d6178ec46524e858
-- Tue Mar 26 16:45:07 2013

-- Donor Data File
CREATE TABLE sdata_donor (
	donor_id VARCHAR(4096) NOT NULL,
	donor_region_of_residence VARCHAR(4096) NOT NULL,
	donor_sex VARCHAR(4096),
	notes VARCHAR(4096),
	PRIMARY KEY (donor_id)
);


-- Specimen Data File
CREATE TABLE sdata_specimen (
	specimen_id VARCHAR(4096) NOT NULL,
	donor_id VARCHAR(4096) NOT NULL,
	donor_max_age_at_specimen_acquisition VARCHAR(128),
	donor_min_age_at_specimen_acquisition VARCHAR(128) NOT NULL,
	notes VARCHAR(4096),
	specimen_available BOOL,
	specimen_biobank VARCHAR(4096),
	specimen_biobank_id VARCHAR(4096),
	specimen_processing VARCHAR(4096) NOT NULL,
	specimen_processing_other VARCHAR(4096),
	specimen_storage VARCHAR(4096) NOT NULL,
	specimen_storage_other VARCHAR(4096),
	specimen_type VARCHAR(4096) NOT NULL,
	specimen_type_other VARCHAR(4096),
	PRIMARY KEY (specimen_id)
);


-- Analyzed Sample Data File
CREATE TABLE sdata_sample (
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	specimen_id VARCHAR(4096) NOT NULL,
	analyzed_sample_interval INTEGER,
	analyzed_sample_type VARCHAR(4096) NOT NULL,
	analyzed_sample_type_other VARCHAR(4096),
	notes VARCHAR(4096),
	purified_cell_type VARCHAR(4096) NOT NULL,
	PRIMARY KEY (analyzed_sample_id,specimen_id)
);


-- Expression - Metadata File
CREATE TABLE exp_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	alignment_algorithm VARCHAR(4096) NOT NULL,
	analysis_group_id VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	data_status INTEGER NOT NULL,
	experimental_group_id VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE,
	PRIMARY KEY (analysis_id,analyzed_sample_id)
);


-- Expression - Gene File
CREATE TABLE exp_g (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	gene_stable_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
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
	validation_status INTEGER NOT NULL,
	PRIMARY KEY (gene_stable_id,analysis_id,analyzed_sample_id)
);


-- Exon Junction - Metadata File
CREATE TABLE jcn_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	alignment_algorithm VARCHAR(4096) NOT NULL,
	analysis_group_id VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	data_status INTEGER NOT NULL,
	experimental_group_id VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE,
	PRIMARY KEY (analysis_id,analyzed_sample_id)
);


-- Exon Junction - Primary Analysis File
CREATE TABLE jcn_p (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	junction_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_strand INTEGER,
	exon1_chromosome VARCHAR(4096) NOT NULL,
	exon1_end INTEGER NOT NULL,
	exon1_number_bases INTEGER NOT NULL,
	exon1_strand INTEGER,
	exon2_chromosome VARCHAR(4096) NOT NULL,
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
	validation_status INTEGER NOT NULL,
	PRIMARY KEY (junction_id,analysis_id,analyzed_sample_id)
);


-- Protein-DNA interaction - Metadata File
CREATE TABLE pdna_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	NSC DOUBLE,
	RSC DOUBLE,
	alignment_algorithm VARCHAR(4096) NOT NULL,
	analysis_group_id VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	control_sample_id VARCHAR(4096) NOT NULL,
	data_status INTEGER NOT NULL,
	experimental_group_id VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE,
	PRIMARY KEY (analysis_id,analyzed_sample_id)
);


-- Protein-DNA interaction - Primary Analysis File
CREATE TABLE pdna_p (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	protein_dna_interaction_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_strand INTEGER,
	idr DOUBLE,
	log10_pvalue DOUBLE NOT NULL,
	log10_qvalue DOUBLE,
	note VARCHAR(4096),
	protein_stable_id VARCHAR(4096) NOT NULL,
	rank VARCHAR(4096),
	validation_platform INTEGER,
	validation_status INTEGER NOT NULL,
	PRIMARY KEY (protein_dna_interaction_id,analysis_id,analyzed_sample_id)
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
	analysis_group_id VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	control_sample_id VARCHAR(4096) NOT NULL,
	data_status INTEGER NOT NULL,
	experimental_group_id VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE,
	PRIMARY KEY (analysis_id,analyzed_sample_id)
);


-- Regulatory regions - Primary Analysis File
CREATE TABLE rreg_p (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	regulatory_region_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_strand INTEGER,
	normalized_read_count DOUBLE NOT NULL,
	note VARCHAR(4096),
	probability DOUBLE,
	quality_score DOUBLE,
	raw_read_count INTEGER NOT NULL,
	validation_platform INTEGER,
	validation_status INTEGER NOT NULL,
	PRIMARY KEY (regulatory_region_id,analysis_id,analyzed_sample_id)
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
	analysis_group_id VARCHAR(4096) NOT NULL,
	assembly_version INTEGER NOT NULL,
	control_sample_id VARCHAR(4096) NOT NULL,
	data_status INTEGER NOT NULL,
	experimental_group_id VARCHAR(4096) NOT NULL,
	experimental_protocol VARCHAR(4096),
	methylation_calling_algorithm VARCHAR(4096),
	note VARCHAR(4096),
	other_analysis_algorithm VARCHAR(4096),
	platform INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	raw_data_accession VARCHAR(4096),
	raw_data_repository INTEGER NOT NULL,
	seq_coverage DOUBLE,
	PRIMARY KEY (analysis_id,analyzed_sample_id)
);


-- DNA *-lation - Primary Analysis File
CREATE TABLE dlat_p (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	d_lated_fragment_id VARCHAR(4096) NOT NULL,
	beta_value DOUBLE,
	c_total_reads DOUBLE NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
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
	validation_status INTEGER NOT NULL,
	PRIMARY KEY (d_lated_fragment_id,analysis_id,analyzed_sample_id)
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


-- Specimen Data File foreign keys
ALTER TABLE sdata_specimen ADD FOREIGN KEY (donor_id)
REFERENCES sdata_donor(donor_id);

-- Analyzed Sample Data File foreign keys
ALTER TABLE sdata_sample ADD FOREIGN KEY (specimen_id)
REFERENCES sdata_specimen(specimen_id);

-- Expression - Gene File foreign keys
ALTER TABLE exp_g ADD FOREIGN KEY (analysis_id,analyzed_sample_id)
REFERENCES exp_m(analysis_id,analyzed_sample_id);

-- Exon Junction - Primary Analysis File foreign keys
ALTER TABLE jcn_p ADD FOREIGN KEY (analysis_id,analyzed_sample_id)
REFERENCES jcn_m(analysis_id,analyzed_sample_id);

-- Protein-DNA interaction - Primary Analysis File foreign keys
ALTER TABLE pdna_p ADD FOREIGN KEY (analysis_id,analyzed_sample_id)
REFERENCES pdna_m(analysis_id,analyzed_sample_id);

-- Protein-DNA interaction - Secondary Analysis File foreign keys
ALTER TABLE pdna_s ADD FOREIGN KEY (analysis_id,analyzed_sample_id,protein_dna_interaction_id)
REFERENCES pdna_p(analysis_id,analyzed_sample_id,protein_dna_interaction_id);

-- Regulatory regions - Primary Analysis File foreign keys
ALTER TABLE rreg_p ADD FOREIGN KEY (analysis_id,analyzed_sample_id)
REFERENCES rreg_m(analysis_id,analyzed_sample_id);

-- Regulatory regions - Secondary Analysis File foreign keys
ALTER TABLE rreg_s ADD FOREIGN KEY (analysis_id,analyzed_sample_id,regulatory_region_id)
REFERENCES rreg_p(analysis_id,analyzed_sample_id,regulatory_region_id);

-- DNA *-lation - Primary Analysis File foreign keys
ALTER TABLE dlat_p ADD FOREIGN KEY (analysis_id,analyzed_sample_id)
REFERENCES dlat_m(analysis_id,analyzed_sample_id);

-- DNA *-lation - Secondary Analysis File foreign keys
ALTER TABLE dlat_s ADD FOREIGN KEY (analysis_id,analyzed_sample_id,d_lated_fragment_id)
REFERENCES dlat_p(analysis_id,analyzed_sample_id,d_lated_fragment_id);
