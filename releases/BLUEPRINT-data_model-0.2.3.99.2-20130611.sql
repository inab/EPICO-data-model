-- Generated from BLUEPRINT 0.2.3.99.2
-- Tue Jun 11 18:59:28 2013

-- Donor Data File
CREATE TABLE sdata_donor (
	donor_id VARCHAR(4096) NOT NULL,
	donor_sex VARCHAR(4096),
	donor_region_of_residence VARCHAR(4096) NOT NULL,
	notes VARCHAR(4096),
	PRIMARY KEY (donor_id)
);


-- Specimen Data File
CREATE TABLE sdata_specimen (
	specimen_id VARCHAR(4096) NOT NULL,
	specimen_type VARCHAR(4096) NOT NULL,
	specimen_type_other VARCHAR(4096),
	donor_min_age_at_specimen_acquisition VARCHAR(128) NOT NULL,
	donor_max_age_at_specimen_acquisition VARCHAR(128),
	specimen_processing VARCHAR(4096) NOT NULL,
	specimen_processing_other VARCHAR(4096),
	specimen_storage VARCHAR(4096) NOT NULL,
	specimen_storage_other VARCHAR(4096),
	specimen_biobank VARCHAR(4096),
	specimen_biobank_id VARCHAR(4096),
	specimen_available BOOL,
	donor_id VARCHAR(4096) NOT NULL,
	notes VARCHAR(4096),
	PRIMARY KEY (specimen_id)
);


-- Analyzed Sample Data File
CREATE TABLE sdata_sample (
	sample_id VARCHAR(4096) NOT NULL,
	purified_cell_type VARCHAR(4096) NOT NULL,
	analyzed_sample_type VARCHAR(4096) NOT NULL,
	analyzed_sample_type_other VARCHAR(4096),
	analyzed_sample_interval INTEGER,
	specimen_id VARCHAR(4096) NOT NULL,
	notes VARCHAR(4096),
	PRIMARY KEY (sample_id)
);


-- Expression - Metadata File
CREATE TABLE exp_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	base_analysis_id VARCHAR(4096),
	analysis_group_id VARCHAR(4096) NOT NULL,
	data_status INTEGER NOT NULL,
	assembly_version INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	alignment_algorithm VARCHAR(4096) NOT NULL,
	other_analysis_algorithm VARCHAR(4096),
	seq_coverage DOUBLE PRECISION,
	raw_data_repository INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	experimental_group_id VARCHAR(4096) NOT NULL,
	platform INTEGER NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	PRIMARY KEY (analysis_id)
);


-- Expression - Gene File
CREATE TABLE exp_g (
	analysis_id VARCHAR(4096) NOT NULL,
	gene_stable_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_strand INTEGER,
	quality_score DOUBLE PRECISION,
	probability DOUBLE PRECISION,
	normalized_read_count DOUBLE PRECISION NOT NULL,
	raw_read_count INTEGER NOT NULL,
	normalized_expression_level DOUBLE PRECISION,
	reference_sample VARCHAR(4096),
	is_annotated BOOL NOT NULL,
	probeset_id VARCHAR(4096),
	validation_status INTEGER NOT NULL,
	validation_platform INTEGER,
	note VARCHAR(4096),
	PRIMARY KEY (gene_stable_id,analysis_id)
);


-- Exon Junction - Metadata File
CREATE TABLE jcn_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	base_analysis_id VARCHAR(4096),
	analysis_group_id VARCHAR(4096) NOT NULL,
	data_status INTEGER NOT NULL,
	assembly_version INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	alignment_algorithm VARCHAR(4096) NOT NULL,
	other_analysis_algorithm VARCHAR(4096),
	seq_coverage DOUBLE PRECISION,
	raw_data_repository INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	experimental_group_id VARCHAR(4096) NOT NULL,
	platform INTEGER NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	PRIMARY KEY (analysis_id)
);


-- Exon Junction - Primary Analysis File
CREATE TABLE jcn_p (
	analysis_id VARCHAR(4096) NOT NULL,
	junction_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_strand INTEGER,
	quality_score DOUBLE PRECISION,
	probability DOUBLE PRECISION,
	gene1_stable_id VARCHAR(4096) NOT NULL,
	gene2_stable_id VARCHAR(4096),
	exon1_chromosome VARCHAR(4096) NOT NULL,
	exon1_number_bases INTEGER NOT NULL,
	exon1_end INTEGER NOT NULL,
	exon1_strand INTEGER,
	exon2_chromosome VARCHAR(4096) NOT NULL,
	exon2_number_bases INTEGER NOT NULL,
	exon2_start INTEGER NOT NULL,
	exon2_strand INTEGER,
	is_fusion_gene BOOL,
	is_novel_splice_form BOOL,
	junction_seq VARCHAR(4096),
	junction_type INTEGER,
	junction_read_count INTEGER NOT NULL,
	validation_status INTEGER NOT NULL,
	validation_platform INTEGER,
	note VARCHAR(4096),
	PRIMARY KEY (junction_id,analysis_id)
);


-- Protein-DNA interactions - Metadata File
CREATE TABLE pdna_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	base_analysis_id VARCHAR(4096),
	control_sample_id VARCHAR(4096),
	analysis_group_id VARCHAR(4096) NOT NULL,
	data_status INTEGER NOT NULL,
	assembly_version INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	alignment_algorithm VARCHAR(4096) NOT NULL,
	other_analysis_algorithm VARCHAR(4096),
	seq_coverage DOUBLE PRECISION,
	raw_data_repository INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	experimental_group_id VARCHAR(4096) NOT NULL,
	platform INTEGER NOT NULL,
	experimental_protocol VARCHAR(4096),
	NSC DOUBLE PRECISION,
	RSC DOUBLE PRECISION,
	note VARCHAR(4096),
	PRIMARY KEY (analysis_id)
);


-- Protein-DNA interactions - Primary Analysis File
CREATE TABLE pdna_p (
	analysis_id VARCHAR(4096) NOT NULL,
	protein_dna_interaction_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	rank VARCHAR(4096),
	protein_stable_id VARCHAR(4096) NOT NULL,
	log10_pvalue DOUBLE PRECISION NOT NULL,
	log10_qvalue DOUBLE PRECISION,
	idr DOUBLE PRECISION,
	validation_status INTEGER NOT NULL,
	validation_platform INTEGER,
	note VARCHAR(4096),
	PRIMARY KEY (protein_dna_interaction_id,analysis_id)
);


-- Protein-DNA interactions - Secondary Analysis File
CREATE TABLE pdna_s (
	analysis_id VARCHAR(4096) NOT NULL,
	ensembl_version INTEGER NOT NULL,
	gene_affected VARCHAR(4096) NOT NULL,
	transcript_affected VARCHAR(4096),
	protein_dna_interaction_id VARCHAR(4096) NOT NULL,
	note VARCHAR(4096)
);


-- Regulatory regions - Metadata File
CREATE TABLE rreg_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	base_analysis_id VARCHAR(4096),
	control_sample_id VARCHAR(4096),
	analysis_group_id VARCHAR(4096) NOT NULL,
	data_status INTEGER NOT NULL,
	assembly_version INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	alignment_algorithm VARCHAR(4096) NOT NULL,
	other_analysis_algorithm VARCHAR(4096),
	seq_coverage DOUBLE PRECISION,
	raw_data_repository INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	experimental_group_id VARCHAR(4096) NOT NULL,
	platform INTEGER NOT NULL,
	experimental_protocol VARCHAR(4096),
	note VARCHAR(4096),
	PRIMARY KEY (analysis_id)
);


-- Regulatory regions - Primary Analysis File
CREATE TABLE rreg_p (
	analysis_id VARCHAR(4096) NOT NULL,
	regulatory_region_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	chromosome_strand INTEGER,
	quality_score DOUBLE PRECISION,
	probability DOUBLE PRECISION,
	normalized_read_count DOUBLE PRECISION NOT NULL,
	raw_read_count INTEGER NOT NULL,
	validation_status INTEGER NOT NULL,
	validation_platform INTEGER,
	note VARCHAR(4096),
	PRIMARY KEY (regulatory_region_id,analysis_id)
);


-- Regulatory regions - Secondary Analysis File
CREATE TABLE rreg_s (
	analysis_id VARCHAR(4096) NOT NULL,
	ensembl_version INTEGER NOT NULL,
	gene_affected VARCHAR(4096) NOT NULL,
	regulatory_region_id VARCHAR(4096) NOT NULL,
	note VARCHAR(4096)
);


-- DNA *-lation - Metadata File
CREATE TABLE dlat_m (
	analysis_id VARCHAR(4096) NOT NULL,
	analyzed_sample_id VARCHAR(4096) NOT NULL,
	base_analysis_id VARCHAR(4096),
	control_sample_id VARCHAR(4096),
	analysis_group_id VARCHAR(4096) NOT NULL,
	data_status INTEGER NOT NULL,
	assembly_version INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	alignment_algorithm VARCHAR(4096) NOT NULL,
	other_analysis_algorithm VARCHAR(4096),
	seq_coverage DOUBLE PRECISION,
	raw_data_repository INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	experimental_group_id VARCHAR(4096) NOT NULL,
	platform INTEGER NOT NULL,
	experimental_protocol VARCHAR(4096),
	methylation_calling_algorithm VARCHAR(4096),
	mr_type VARCHAR(4096) NOT NULL,
	note VARCHAR(4096),
	PRIMARY KEY (analysis_id)
);


-- DNA *-lation - Single Nucleotide File
CREATE TABLE dlat_n (
	analysis_id VARCHAR(4096) NOT NULL,
	d_lated_fragment_id VARCHAR(4096) NOT NULL,
	d_lation_type VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_strand INTEGER,
	total_reads DOUBLE PRECISION NOT NULL,
	c_total_reads DOUBLE PRECISION NOT NULL,
	d_lated_reads DOUBLE PRECISION NOT NULL,
	quality_score DOUBLE PRECISION,
	probability DOUBLE PRECISION,
	methylation DOUBLE PRECISION NOT NULL,
	validation_status INTEGER NOT NULL,
	validation_platform INTEGER,
	note VARCHAR(4096),
	PRIMARY KEY (d_lated_fragment_id,analysis_id)
);


-- DNA *-lation - Methylated Region (CpGs, HMR) File
CREATE TABLE dlat_mr (
	analysis_id VARCHAR(4096) NOT NULL,
	d_lated_fragment_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	total_reads DOUBLE PRECISION NOT NULL,
	c_total_reads DOUBLE PRECISION NOT NULL,
	d_lated_reads DOUBLE PRECISION NOT NULL,
	quality_score DOUBLE PRECISION,
	probability DOUBLE PRECISION,
	beta_value DOUBLE PRECISION,
	validation_status INTEGER NOT NULL,
	validation_platform INTEGER,
	note VARCHAR(4096),
	PRIMARY KEY (d_lated_fragment_id,analysis_id)
);


-- DNA *-lation - Annotation File
CREATE TABLE dlat_s (
	analysis_id VARCHAR(4096) NOT NULL,
	ensembl_version INTEGER NOT NULL,
	gene_affected VARCHAR(4096) NOT NULL,
	d_lated_fragment_id VARCHAR(4096) NOT NULL,
	note VARCHAR(4096)
);


-- DNA differential *-lation - Metadata File
CREATE TABLE dlat_dm (
	analysis_id VARCHAR(4096) NOT NULL,
	part_a_analysis_id VARCHAR(4096) NOT NULL,
	part_b_analysis_id VARCHAR(4096) NOT NULL,
	analysis_group_id VARCHAR(4096) NOT NULL,
	data_status INTEGER NOT NULL,
	assembly_version INTEGER NOT NULL,
	program_versions VARCHAR(4096),
	alignment_algorithm VARCHAR(4096) NOT NULL,
	other_analysis_algorithm VARCHAR(4096),
	seq_coverage DOUBLE PRECISION,
	raw_data_repository INTEGER NOT NULL,
	raw_data_accession VARCHAR(4096),
	note VARCHAR(4096),
	PRIMARY KEY (analysis_id)
);


-- DNA *-lation - Differentially Methylated Region (DMR) File
CREATE TABLE dlat_dmr (
	analysis_id VARCHAR(4096) NOT NULL,
	d_lated_fragment_id VARCHAR(4096) NOT NULL,
	chromosome VARCHAR(4096) NOT NULL,
	chromosome_start INTEGER NOT NULL,
	chromosome_end INTEGER NOT NULL,
	rank VARCHAR(4096),
	n_cpgs INTEGER NOT NULL,
	n_sig_cpgs INTEGER NOT NULL,
	hyper_role VARCHAR(4096) NOT NULL,
	abs_avg_diff DOUBLE PRECISION NOT NULL,
	rel_avg_diff DOUBLE PRECISION NOT NULL,
	cpg_start INTEGER NOT NULL,
	validation_status INTEGER NOT NULL,
	validation_platform INTEGER,
	note VARCHAR(4096),
	PRIMARY KEY (d_lated_fragment_id,analysis_id)
);


-- Expression - Gene File foreign keys from inheritance
ALTER TABLE exp_g ADD FOREIGN KEY (analysis_id)
REFERENCES exp_m(analysis_id);

-- Exon Junction - Primary Analysis File foreign keys from inheritance
ALTER TABLE jcn_p ADD FOREIGN KEY (analysis_id)
REFERENCES jcn_m(analysis_id);

-- Protein-DNA interactions - Primary Analysis File foreign keys from inheritance
ALTER TABLE pdna_p ADD FOREIGN KEY (analysis_id)
REFERENCES pdna_m(analysis_id);

-- Protein-DNA interactions - Secondary Analysis File foreign keys from inheritance
ALTER TABLE pdna_s ADD FOREIGN KEY (analysis_id,protein_dna_interaction_id)
REFERENCES pdna_p(analysis_id,protein_dna_interaction_id);

-- Regulatory regions - Primary Analysis File foreign keys from inheritance
ALTER TABLE rreg_p ADD FOREIGN KEY (analysis_id)
REFERENCES rreg_m(analysis_id);

-- Regulatory regions - Secondary Analysis File foreign keys from inheritance
ALTER TABLE rreg_s ADD FOREIGN KEY (analysis_id,regulatory_region_id)
REFERENCES rreg_p(analysis_id,regulatory_region_id);

-- DNA *-lation - Single Nucleotide File foreign keys from inheritance
ALTER TABLE dlat_n ADD FOREIGN KEY (analysis_id)
REFERENCES dlat_m(analysis_id);

-- DNA *-lation - Methylated Region (CpGs, HMR) File foreign keys from inheritance
ALTER TABLE dlat_mr ADD FOREIGN KEY (analysis_id)
REFERENCES dlat_m(analysis_id);

-- DNA *-lation - Annotation File foreign keys from inheritance
ALTER TABLE dlat_s ADD FOREIGN KEY (analysis_id,d_lated_fragment_id)
REFERENCES dlat_mr(analysis_id,d_lated_fragment_id);

-- DNA *-lation - Differentially Methylated Region (DMR) File foreign keys from inheritance
ALTER TABLE dlat_dmr ADD FOREIGN KEY (analysis_id)
REFERENCES dlat_dm(analysis_id);

-- Specimen Data File foreign keys from related-to
ALTER TABLE sdata_specimen ADD FOREIGN KEY (donor_id)
REFERENCES sdata_donor(donor_id);

-- Analyzed Sample Data File foreign keys from related-to
ALTER TABLE sdata_sample ADD FOREIGN KEY (specimen_id)
REFERENCES sdata_specimen(specimen_id);

-- Expression - Metadata File foreign keys from related-to
ALTER TABLE exp_m ADD FOREIGN KEY (analyzed_sample_id)
REFERENCES sdata_sample(sample_id);

ALTER TABLE exp_m ADD FOREIGN KEY (base_analysis_id)
REFERENCES exp_m(analysis_id);

-- Exon Junction - Metadata File foreign keys from related-to
ALTER TABLE jcn_m ADD FOREIGN KEY (analyzed_sample_id)
REFERENCES sdata_sample(sample_id);

ALTER TABLE jcn_m ADD FOREIGN KEY (base_analysis_id)
REFERENCES jcn_m(analysis_id);

-- Protein-DNA interactions - Metadata File foreign keys from related-to
ALTER TABLE pdna_m ADD FOREIGN KEY (analyzed_sample_id)
REFERENCES sdata_sample(sample_id);

ALTER TABLE pdna_m ADD FOREIGN KEY (base_analysis_id)
REFERENCES pdna_m(analysis_id);

ALTER TABLE pdna_m ADD FOREIGN KEY (control_sample_id)
REFERENCES sdata_sample(sample_id);

-- Regulatory regions - Metadata File foreign keys from related-to
ALTER TABLE rreg_m ADD FOREIGN KEY (analyzed_sample_id)
REFERENCES sdata_sample(sample_id);

ALTER TABLE rreg_m ADD FOREIGN KEY (base_analysis_id)
REFERENCES rreg_m(analysis_id);

ALTER TABLE rreg_m ADD FOREIGN KEY (control_sample_id)
REFERENCES sdata_sample(sample_id);

-- DNA *-lation - Metadata File foreign keys from related-to
ALTER TABLE dlat_m ADD FOREIGN KEY (analyzed_sample_id)
REFERENCES sdata_sample(sample_id);

ALTER TABLE dlat_m ADD FOREIGN KEY (base_analysis_id)
REFERENCES dlat_m(analysis_id);

ALTER TABLE dlat_m ADD FOREIGN KEY (control_sample_id)
REFERENCES sdata_sample(sample_id);

-- DNA differential *-lation - Metadata File foreign keys from related-to
ALTER TABLE dlat_dm ADD FOREIGN KEY (part_a_analysis_id)
REFERENCES dlat_m(analysis_id);

ALTER TABLE dlat_dm ADD FOREIGN KEY (part_b_analysis_id)
REFERENCES dlat_m(analysis_id);
