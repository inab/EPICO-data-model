-- File BLUEPRINT-data_model-0.2.99.4-20130704_CVtrans.sql
-- Generated from BLUEPRINT 0.2.99.4
-- Thu Jul  4 20:30:32 2013
ALTER TABLE sdata_donor ADD COLUMN donor_sex_term VARCHAR(1024);

UPDATE sdata_donor , sex_CVkeys , sex_CV
SET
	sdata_donor.donor_sex_term = sex_CV.descr
WHERE
	sdata_donor.donor_sex_term IS NULL AND
	sdata_donor.donor_sex = sex_CVkeys.cvkey
	AND sex_CVkeys.idkey = sex_CV.idkey
;
ALTER TABLE sdata_donor ADD COLUMN donor_region_of_residence_term VARCHAR(1024);

UPDATE sdata_donor , ISO3166_CVkeys , ISO3166_CV
SET
	sdata_donor.donor_region_of_residence_term = ISO3166_CV.descr
WHERE
	sdata_donor.donor_region_of_residence_term IS NULL AND
	sdata_donor.donor_region_of_residence = ISO3166_CVkeys.cvkey
	AND ISO3166_CVkeys.idkey = ISO3166_CV.idkey
;
ALTER TABLE sdata_specimen ADD COLUMN specimen_type_term VARCHAR(1024);

UPDATE sdata_specimen , sdata_specimen_specimen_type_CVkeys , sdata_specimen_specimen_type_CV
SET
	sdata_specimen.specimen_type_term = sdata_specimen_specimen_type_CV.descr
WHERE
	sdata_specimen.specimen_type_term IS NULL AND
	sdata_specimen.specimen_type = sdata_specimen_specimen_type_CVkeys.cvkey
	AND sdata_specimen_specimen_type_CVkeys.idkey = sdata_specimen_specimen_type_CV.idkey
;
ALTER TABLE sdata_specimen ADD COLUMN specimen_processing_term VARCHAR(1024);

UPDATE sdata_specimen , sdata_specimen_specimen_processing_CVkeys , sdata_specimen_specimen_processing_CV
SET
	sdata_specimen.specimen_processing_term = sdata_specimen_specimen_processing_CV.descr
WHERE
	sdata_specimen.specimen_processing_term IS NULL AND
	sdata_specimen.specimen_processing = sdata_specimen_specimen_processing_CVkeys.cvkey
	AND sdata_specimen_specimen_processing_CVkeys.idkey = sdata_specimen_specimen_processing_CV.idkey
;
ALTER TABLE sdata_specimen ADD COLUMN specimen_storage_term VARCHAR(1024);

UPDATE sdata_specimen , sdata_specimen_specimen_storage_CVkeys , sdata_specimen_specimen_storage_CV
SET
	sdata_specimen.specimen_storage_term = sdata_specimen_specimen_storage_CV.descr
WHERE
	sdata_specimen.specimen_storage_term IS NULL AND
	sdata_specimen.specimen_storage = sdata_specimen_specimen_storage_CVkeys.cvkey
	AND sdata_specimen_specimen_storage_CVkeys.idkey = sdata_specimen_specimen_storage_CV.idkey
;
ALTER TABLE sdata_sample ADD COLUMN purified_cell_type_term VARCHAR(1024);

UPDATE sdata_sample , CellOntology_CVkeys , CellOntology_CV
SET
	sdata_sample.purified_cell_type_term = CellOntology_CV.descr
WHERE
	sdata_sample.purified_cell_type_term IS NULL AND
	sdata_sample.purified_cell_type = CellOntology_CVkeys.cvkey
	AND CellOntology_CVkeys.idkey = CellOntology_CV.idkey
;
ALTER TABLE sdata_sample ADD COLUMN analyzed_sample_type_term VARCHAR(1024);

UPDATE sdata_sample , sdata_sample_analyzed_sample_type_CVkeys , sdata_sample_analyzed_sample_type_CV
SET
	sdata_sample.analyzed_sample_type_term = sdata_sample_analyzed_sample_type_CV.descr
WHERE
	sdata_sample.analyzed_sample_type_term IS NULL AND
	sdata_sample.analyzed_sample_type = sdata_sample_analyzed_sample_type_CVkeys.cvkey
	AND sdata_sample_analyzed_sample_type_CVkeys.idkey = sdata_sample_analyzed_sample_type_CV.idkey
;
ALTER TABLE exp_m ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE exp_m , B1_CVkeys , B1_CV
SET
	exp_m.analysis_group_id_term = B1_CV.descr
WHERE
	exp_m.analysis_group_id_term IS NULL AND
	exp_m.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE exp_m ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE exp_m , B1_CVkeys , B1_CV
SET
	exp_m.experimental_group_id_term = B1_CV.descr
WHERE
	exp_m.experimental_group_id_term IS NULL AND
	exp_m.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE jcn_m ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE jcn_m , B1_CVkeys , B1_CV
SET
	jcn_m.analysis_group_id_term = B1_CV.descr
WHERE
	jcn_m.analysis_group_id_term IS NULL AND
	jcn_m.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE jcn_m ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE jcn_m , B1_CVkeys , B1_CV
SET
	jcn_m.experimental_group_id_term = B1_CV.descr
WHERE
	jcn_m.experimental_group_id_term IS NULL AND
	jcn_m.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE pdna_m ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE pdna_m , B1_CVkeys , B1_CV
SET
	pdna_m.analysis_group_id_term = B1_CV.descr
WHERE
	pdna_m.analysis_group_id_term IS NULL AND
	pdna_m.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE pdna_m ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE pdna_m , B1_CVkeys , B1_CV
SET
	pdna_m.experimental_group_id_term = B1_CV.descr
WHERE
	pdna_m.experimental_group_id_term IS NULL AND
	pdna_m.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE rreg_m ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE rreg_m , B1_CVkeys , B1_CV
SET
	rreg_m.analysis_group_id_term = B1_CV.descr
WHERE
	rreg_m.analysis_group_id_term IS NULL AND
	rreg_m.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE rreg_m ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE rreg_m , B1_CVkeys , B1_CV
SET
	rreg_m.experimental_group_id_term = B1_CV.descr
WHERE
	rreg_m.experimental_group_id_term IS NULL AND
	rreg_m.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE dlat_m ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE dlat_m , B1_CVkeys , B1_CV
SET
	dlat_m.analysis_group_id_term = B1_CV.descr
WHERE
	dlat_m.analysis_group_id_term IS NULL AND
	dlat_m.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE dlat_m ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE dlat_m , B1_CVkeys , B1_CV
SET
	dlat_m.experimental_group_id_term = B1_CV.descr
WHERE
	dlat_m.experimental_group_id_term IS NULL AND
	dlat_m.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE dlat_dm ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE dlat_dm , B1_CVkeys , B1_CV
SET
	dlat_dm.analysis_group_id_term = B1_CV.descr
WHERE
	dlat_dm.analysis_group_id_term IS NULL AND
	dlat_dm.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE exp_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE exp_m , exp_m_data_status_CVkeys , exp_m_data_status_CV
SET
	exp_m.data_status_term = exp_m_data_status_CV.descr
WHERE
	exp_m.data_status_term IS NULL AND
	exp_m.data_status = exp_m_data_status_CVkeys.cvkey
	AND exp_m_data_status_CVkeys.idkey = exp_m_data_status_CV.idkey
;
ALTER TABLE exp_m ADD COLUMN assembly_version_term VARCHAR(1024);

UPDATE exp_m , B10_CVkeys , B10_CV
SET
	exp_m.assembly_version_term = B10_CV.descr
WHERE
	exp_m.assembly_version_term IS NULL AND
	exp_m.assembly_version = B10_CVkeys.cvkey
	AND B10_CVkeys.idkey = B10_CV.idkey
;
ALTER TABLE jcn_m ADD COLUMN assembly_version_term VARCHAR(1024);

UPDATE jcn_m , B10_CVkeys , B10_CV
SET
	jcn_m.assembly_version_term = B10_CV.descr
WHERE
	jcn_m.assembly_version_term IS NULL AND
	jcn_m.assembly_version = B10_CVkeys.cvkey
	AND B10_CVkeys.idkey = B10_CV.idkey
;
ALTER TABLE pdna_m ADD COLUMN assembly_version_term VARCHAR(1024);

UPDATE pdna_m , B10_CVkeys , B10_CV
SET
	pdna_m.assembly_version_term = B10_CV.descr
WHERE
	pdna_m.assembly_version_term IS NULL AND
	pdna_m.assembly_version = B10_CVkeys.cvkey
	AND B10_CVkeys.idkey = B10_CV.idkey
;
ALTER TABLE rreg_m ADD COLUMN assembly_version_term VARCHAR(1024);

UPDATE rreg_m , B10_CVkeys , B10_CV
SET
	rreg_m.assembly_version_term = B10_CV.descr
WHERE
	rreg_m.assembly_version_term IS NULL AND
	rreg_m.assembly_version = B10_CVkeys.cvkey
	AND B10_CVkeys.idkey = B10_CV.idkey
;
ALTER TABLE dlat_m ADD COLUMN assembly_version_term VARCHAR(1024);

UPDATE dlat_m , B10_CVkeys , B10_CV
SET
	dlat_m.assembly_version_term = B10_CV.descr
WHERE
	dlat_m.assembly_version_term IS NULL AND
	dlat_m.assembly_version = B10_CVkeys.cvkey
	AND B10_CVkeys.idkey = B10_CV.idkey
;
ALTER TABLE dlat_dm ADD COLUMN assembly_version_term VARCHAR(1024);

UPDATE dlat_dm , B10_CVkeys , B10_CV
SET
	dlat_dm.assembly_version_term = B10_CV.descr
WHERE
	dlat_dm.assembly_version_term IS NULL AND
	dlat_dm.assembly_version = B10_CVkeys.cvkey
	AND B10_CVkeys.idkey = B10_CV.idkey
;
ALTER TABLE exp_m ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE exp_m , B12_CVkeys , B12_CV
SET
	exp_m.raw_data_repository_term = B12_CV.descr
WHERE
	exp_m.raw_data_repository_term IS NULL AND
	exp_m.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE jcn_m ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE jcn_m , B12_CVkeys , B12_CV
SET
	jcn_m.raw_data_repository_term = B12_CV.descr
WHERE
	jcn_m.raw_data_repository_term IS NULL AND
	jcn_m.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE pdna_m ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE pdna_m , B12_CVkeys , B12_CV
SET
	pdna_m.raw_data_repository_term = B12_CV.descr
WHERE
	pdna_m.raw_data_repository_term IS NULL AND
	pdna_m.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE rreg_m ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE rreg_m , B12_CVkeys , B12_CV
SET
	rreg_m.raw_data_repository_term = B12_CV.descr
WHERE
	rreg_m.raw_data_repository_term IS NULL AND
	rreg_m.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE dlat_m ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE dlat_m , B12_CVkeys , B12_CV
SET
	dlat_m.raw_data_repository_term = B12_CV.descr
WHERE
	dlat_m.raw_data_repository_term IS NULL AND
	dlat_m.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE dlat_dm ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE dlat_dm , B12_CVkeys , B12_CV
SET
	dlat_dm.raw_data_repository_term = B12_CV.descr
WHERE
	dlat_dm.raw_data_repository_term IS NULL AND
	dlat_dm.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE exp_m ADD COLUMN platform_term VARCHAR(1024);

UPDATE exp_m , B5_CVkeys , B5_CV
SET
	exp_m.platform_term = B5_CV.descr
WHERE
	exp_m.platform_term IS NULL AND
	exp_m.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE exp_g ADD COLUMN validation_platform_term VARCHAR(1024);

UPDATE exp_g , B5_CVkeys , B5_CV
SET
	exp_g.validation_platform_term = B5_CV.descr
WHERE
	exp_g.validation_platform_term IS NULL AND
	exp_g.validation_platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE jcn_m ADD COLUMN platform_term VARCHAR(1024);

UPDATE jcn_m , B5_CVkeys , B5_CV
SET
	jcn_m.platform_term = B5_CV.descr
WHERE
	jcn_m.platform_term IS NULL AND
	jcn_m.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE jcn_p ADD COLUMN validation_platform_term VARCHAR(1024);

UPDATE jcn_p , B5_CVkeys , B5_CV
SET
	jcn_p.validation_platform_term = B5_CV.descr
WHERE
	jcn_p.validation_platform_term IS NULL AND
	jcn_p.validation_platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE pdna_m ADD COLUMN platform_term VARCHAR(1024);

UPDATE pdna_m , B5_CVkeys , B5_CV
SET
	pdna_m.platform_term = B5_CV.descr
WHERE
	pdna_m.platform_term IS NULL AND
	pdna_m.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE pdna_p ADD COLUMN validation_platform_term VARCHAR(1024);

UPDATE pdna_p , B5_CVkeys , B5_CV
SET
	pdna_p.validation_platform_term = B5_CV.descr
WHERE
	pdna_p.validation_platform_term IS NULL AND
	pdna_p.validation_platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE rreg_m ADD COLUMN platform_term VARCHAR(1024);

UPDATE rreg_m , B5_CVkeys , B5_CV
SET
	rreg_m.platform_term = B5_CV.descr
WHERE
	rreg_m.platform_term IS NULL AND
	rreg_m.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE rreg_p ADD COLUMN validation_platform_term VARCHAR(1024);

UPDATE rreg_p , B5_CVkeys , B5_CV
SET
	rreg_p.validation_platform_term = B5_CV.descr
WHERE
	rreg_p.validation_platform_term IS NULL AND
	rreg_p.validation_platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE dlat_m ADD COLUMN platform_term VARCHAR(1024);

UPDATE dlat_m , B5_CVkeys , B5_CV
SET
	dlat_m.platform_term = B5_CV.descr
WHERE
	dlat_m.platform_term IS NULL AND
	dlat_m.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE dlat_n ADD COLUMN validation_platform_term VARCHAR(1024);

UPDATE dlat_n , B5_CVkeys , B5_CV
SET
	dlat_n.validation_platform_term = B5_CV.descr
WHERE
	dlat_n.validation_platform_term IS NULL AND
	dlat_n.validation_platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE dlat_mr ADD COLUMN validation_platform_term VARCHAR(1024);

UPDATE dlat_mr , B5_CVkeys , B5_CV
SET
	dlat_mr.validation_platform_term = B5_CV.descr
WHERE
	dlat_mr.validation_platform_term IS NULL AND
	dlat_mr.validation_platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE dlat_dmr ADD COLUMN validation_platform_term VARCHAR(1024);

UPDATE dlat_dmr , B5_CVkeys , B5_CV
SET
	dlat_dmr.validation_platform_term = B5_CV.descr
WHERE
	dlat_dmr.validation_platform_term IS NULL AND
	dlat_dmr.validation_platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE exp_g ADD COLUMN chromosome_term VARCHAR(1024);

UPDATE exp_g , B6_CVkeys , B6_CV
SET
	exp_g.chromosome_term = B6_CV.descr
WHERE
	exp_g.chromosome_term IS NULL AND
	exp_g.chromosome = B6_CVkeys.cvkey
	AND B6_CVkeys.idkey = B6_CV.idkey
;
ALTER TABLE jcn_p ADD COLUMN chromosome_term VARCHAR(1024);

UPDATE jcn_p , B6_CVkeys , B6_CV
SET
	jcn_p.chromosome_term = B6_CV.descr
WHERE
	jcn_p.chromosome_term IS NULL AND
	jcn_p.chromosome = B6_CVkeys.cvkey
	AND B6_CVkeys.idkey = B6_CV.idkey
;
ALTER TABLE jcn_p ADD COLUMN exon1_chromosome_term VARCHAR(1024);

UPDATE jcn_p , B6_CVkeys , B6_CV
SET
	jcn_p.exon1_chromosome_term = B6_CV.descr
WHERE
	jcn_p.exon1_chromosome_term IS NULL AND
	jcn_p.exon1_chromosome = B6_CVkeys.cvkey
	AND B6_CVkeys.idkey = B6_CV.idkey
;
ALTER TABLE jcn_p ADD COLUMN exon2_chromosome_term VARCHAR(1024);

UPDATE jcn_p , B6_CVkeys , B6_CV
SET
	jcn_p.exon2_chromosome_term = B6_CV.descr
WHERE
	jcn_p.exon2_chromosome_term IS NULL AND
	jcn_p.exon2_chromosome = B6_CVkeys.cvkey
	AND B6_CVkeys.idkey = B6_CV.idkey
;
ALTER TABLE pdna_p ADD COLUMN chromosome_term VARCHAR(1024);

UPDATE pdna_p , B6_CVkeys , B6_CV
SET
	pdna_p.chromosome_term = B6_CV.descr
WHERE
	pdna_p.chromosome_term IS NULL AND
	pdna_p.chromosome = B6_CVkeys.cvkey
	AND B6_CVkeys.idkey = B6_CV.idkey
;
ALTER TABLE rreg_p ADD COLUMN chromosome_term VARCHAR(1024);

UPDATE rreg_p , B6_CVkeys , B6_CV
SET
	rreg_p.chromosome_term = B6_CV.descr
WHERE
	rreg_p.chromosome_term IS NULL AND
	rreg_p.chromosome = B6_CVkeys.cvkey
	AND B6_CVkeys.idkey = B6_CV.idkey
;
ALTER TABLE dlat_n ADD COLUMN chromosome_term VARCHAR(1024);

UPDATE dlat_n , B6_CVkeys , B6_CV
SET
	dlat_n.chromosome_term = B6_CV.descr
WHERE
	dlat_n.chromosome_term IS NULL AND
	dlat_n.chromosome = B6_CVkeys.cvkey
	AND B6_CVkeys.idkey = B6_CV.idkey
;
ALTER TABLE dlat_mr ADD COLUMN chromosome_term VARCHAR(1024);

UPDATE dlat_mr , B6_CVkeys , B6_CV
SET
	dlat_mr.chromosome_term = B6_CV.descr
WHERE
	dlat_mr.chromosome_term IS NULL AND
	dlat_mr.chromosome = B6_CVkeys.cvkey
	AND B6_CVkeys.idkey = B6_CV.idkey
;
ALTER TABLE dlat_dmr ADD COLUMN chromosome_term VARCHAR(1024);

UPDATE dlat_dmr , B6_CVkeys , B6_CV
SET
	dlat_dmr.chromosome_term = B6_CV.descr
WHERE
	dlat_dmr.chromosome_term IS NULL AND
	dlat_dmr.chromosome = B6_CVkeys.cvkey
	AND B6_CVkeys.idkey = B6_CV.idkey
;
ALTER TABLE exp_g ADD COLUMN chromosome_strand_term VARCHAR(1024);

UPDATE exp_g , strand_CVkeys , strand_CV
SET
	exp_g.chromosome_strand_term = strand_CV.descr
WHERE
	exp_g.chromosome_strand_term IS NULL AND
	exp_g.chromosome_strand = strand_CVkeys.cvkey
	AND strand_CVkeys.idkey = strand_CV.idkey
;
ALTER TABLE jcn_p ADD COLUMN chromosome_strand_term VARCHAR(1024);

UPDATE jcn_p , strand_CVkeys , strand_CV
SET
	jcn_p.chromosome_strand_term = strand_CV.descr
WHERE
	jcn_p.chromosome_strand_term IS NULL AND
	jcn_p.chromosome_strand = strand_CVkeys.cvkey
	AND strand_CVkeys.idkey = strand_CV.idkey
;
ALTER TABLE jcn_p ADD COLUMN exon1_strand_term VARCHAR(1024);

UPDATE jcn_p , strand_CVkeys , strand_CV
SET
	jcn_p.exon1_strand_term = strand_CV.descr
WHERE
	jcn_p.exon1_strand_term IS NULL AND
	jcn_p.exon1_strand = strand_CVkeys.cvkey
	AND strand_CVkeys.idkey = strand_CV.idkey
;
ALTER TABLE jcn_p ADD COLUMN exon2_strand_term VARCHAR(1024);

UPDATE jcn_p , strand_CVkeys , strand_CV
SET
	jcn_p.exon2_strand_term = strand_CV.descr
WHERE
	jcn_p.exon2_strand_term IS NULL AND
	jcn_p.exon2_strand = strand_CVkeys.cvkey
	AND strand_CVkeys.idkey = strand_CV.idkey
;
ALTER TABLE dlat_n ADD COLUMN chromosome_strand_term VARCHAR(1024);

UPDATE dlat_n , strand_CVkeys , strand_CV
SET
	dlat_n.chromosome_strand_term = strand_CV.descr
WHERE
	dlat_n.chromosome_strand_term IS NULL AND
	dlat_n.chromosome_strand = strand_CVkeys.cvkey
	AND strand_CVkeys.idkey = strand_CV.idkey
;
ALTER TABLE exp_g ADD COLUMN validation_status_term VARCHAR(1024);

UPDATE exp_g , validationStatus_CVkeys , validationStatus_CV
SET
	exp_g.validation_status_term = validationStatus_CV.descr
WHERE
	exp_g.validation_status_term IS NULL AND
	exp_g.validation_status = validationStatus_CVkeys.cvkey
	AND validationStatus_CVkeys.idkey = validationStatus_CV.idkey
;
ALTER TABLE jcn_p ADD COLUMN validation_status_term VARCHAR(1024);

UPDATE jcn_p , validationStatus_CVkeys , validationStatus_CV
SET
	jcn_p.validation_status_term = validationStatus_CV.descr
WHERE
	jcn_p.validation_status_term IS NULL AND
	jcn_p.validation_status = validationStatus_CVkeys.cvkey
	AND validationStatus_CVkeys.idkey = validationStatus_CV.idkey
;
ALTER TABLE pdna_p ADD COLUMN validation_status_term VARCHAR(1024);

UPDATE pdna_p , validationStatus_CVkeys , validationStatus_CV
SET
	pdna_p.validation_status_term = validationStatus_CV.descr
WHERE
	pdna_p.validation_status_term IS NULL AND
	pdna_p.validation_status = validationStatus_CVkeys.cvkey
	AND validationStatus_CVkeys.idkey = validationStatus_CV.idkey
;
ALTER TABLE rreg_p ADD COLUMN validation_status_term VARCHAR(1024);

UPDATE rreg_p , validationStatus_CVkeys , validationStatus_CV
SET
	rreg_p.validation_status_term = validationStatus_CV.descr
WHERE
	rreg_p.validation_status_term IS NULL AND
	rreg_p.validation_status = validationStatus_CVkeys.cvkey
	AND validationStatus_CVkeys.idkey = validationStatus_CV.idkey
;
ALTER TABLE dlat_n ADD COLUMN validation_status_term VARCHAR(1024);

UPDATE dlat_n , validationStatus_CVkeys , validationStatus_CV
SET
	dlat_n.validation_status_term = validationStatus_CV.descr
WHERE
	dlat_n.validation_status_term IS NULL AND
	dlat_n.validation_status = validationStatus_CVkeys.cvkey
	AND validationStatus_CVkeys.idkey = validationStatus_CV.idkey
;
ALTER TABLE dlat_mr ADD COLUMN validation_status_term VARCHAR(1024);

UPDATE dlat_mr , validationStatus_CVkeys , validationStatus_CV
SET
	dlat_mr.validation_status_term = validationStatus_CV.descr
WHERE
	dlat_mr.validation_status_term IS NULL AND
	dlat_mr.validation_status = validationStatus_CVkeys.cvkey
	AND validationStatus_CVkeys.idkey = validationStatus_CV.idkey
;
ALTER TABLE dlat_dmr ADD COLUMN validation_status_term VARCHAR(1024);

UPDATE dlat_dmr , validationStatus_CVkeys , validationStatus_CV
SET
	dlat_dmr.validation_status_term = validationStatus_CV.descr
WHERE
	dlat_dmr.validation_status_term IS NULL AND
	dlat_dmr.validation_status = validationStatus_CVkeys.cvkey
	AND validationStatus_CVkeys.idkey = validationStatus_CV.idkey
;
ALTER TABLE jcn_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE jcn_m , jcn_m_data_status_CVkeys , jcn_m_data_status_CV
SET
	jcn_m.data_status_term = jcn_m_data_status_CV.descr
WHERE
	jcn_m.data_status_term IS NULL AND
	jcn_m.data_status = jcn_m_data_status_CVkeys.cvkey
	AND jcn_m_data_status_CVkeys.idkey = jcn_m_data_status_CV.idkey
;
ALTER TABLE jcn_p ADD COLUMN junction_type_term VARCHAR(1024);

UPDATE jcn_p , junctionType_CVkeys , junctionType_CV
SET
	jcn_p.junction_type_term = junctionType_CV.descr
WHERE
	jcn_p.junction_type_term IS NULL AND
	jcn_p.junction_type = junctionType_CVkeys.cvkey
	AND junctionType_CVkeys.idkey = junctionType_CV.idkey
;
ALTER TABLE pdna_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE pdna_m , pdna_m_data_status_CVkeys , pdna_m_data_status_CV
SET
	pdna_m.data_status_term = pdna_m_data_status_CV.descr
WHERE
	pdna_m.data_status_term IS NULL AND
	pdna_m.data_status = pdna_m_data_status_CVkeys.cvkey
	AND pdna_m_data_status_CVkeys.idkey = pdna_m_data_status_CV.idkey
;
ALTER TABLE pdna_s ADD COLUMN gene_affected_term VARCHAR(1024);

UPDATE pdna_s , EnsemblGenes_CVkeys , EnsemblGenes_CV
SET
	pdna_s.gene_affected_term = EnsemblGenes_CV.descr
WHERE
	pdna_s.gene_affected_term IS NULL AND
	pdna_s.gene_affected = EnsemblGenes_CVkeys.cvkey
	AND EnsemblGenes_CVkeys.idkey = EnsemblGenes_CV.idkey
;
ALTER TABLE dlat_s ADD COLUMN gene_affected_term VARCHAR(1024);

UPDATE dlat_s , EnsemblGenes_CVkeys , EnsemblGenes_CV
SET
	dlat_s.gene_affected_term = EnsemblGenes_CV.descr
WHERE
	dlat_s.gene_affected_term IS NULL AND
	dlat_s.gene_affected = EnsemblGenes_CVkeys.cvkey
	AND EnsemblGenes_CVkeys.idkey = EnsemblGenes_CV.idkey
;
ALTER TABLE pdna_s ADD COLUMN transcript_affected_term VARCHAR(1024);

UPDATE pdna_s , EnsemblTranscripts_CVkeys , EnsemblTranscripts_CV
SET
	pdna_s.transcript_affected_term = EnsemblTranscripts_CV.descr
WHERE
	pdna_s.transcript_affected_term IS NULL AND
	pdna_s.transcript_affected = EnsemblTranscripts_CVkeys.cvkey
	AND EnsemblTranscripts_CVkeys.idkey = EnsemblTranscripts_CV.idkey
;
ALTER TABLE rreg_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE rreg_m , rreg_m_data_status_CVkeys , rreg_m_data_status_CV
SET
	rreg_m.data_status_term = rreg_m_data_status_CV.descr
WHERE
	rreg_m.data_status_term IS NULL AND
	rreg_m.data_status = rreg_m_data_status_CVkeys.cvkey
	AND rreg_m_data_status_CVkeys.idkey = rreg_m_data_status_CV.idkey
;
ALTER TABLE dlat_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE dlat_m , dlat_m_data_status_CVkeys , dlat_m_data_status_CV
SET
	dlat_m.data_status_term = dlat_m_data_status_CV.descr
WHERE
	dlat_m.data_status_term IS NULL AND
	dlat_m.data_status = dlat_m_data_status_CVkeys.cvkey
	AND dlat_m_data_status_CVkeys.idkey = dlat_m_data_status_CV.idkey
;
ALTER TABLE dlat_m ADD COLUMN mr_type_term VARCHAR(1024);

UPDATE dlat_m , dlat_m_mr_type_CVkeys , dlat_m_mr_type_CV
SET
	dlat_m.mr_type_term = dlat_m_mr_type_CV.descr
WHERE
	dlat_m.mr_type_term IS NULL AND
	dlat_m.mr_type = dlat_m_mr_type_CVkeys.cvkey
	AND dlat_m_mr_type_CVkeys.idkey = dlat_m_mr_type_CV.idkey
;
ALTER TABLE dlat_n ADD COLUMN d_lation_type_term VARCHAR(1024);

UPDATE dlat_n , dlat_n_d_lation_type_CVkeys , dlat_n_d_lation_type_CV
SET
	dlat_n.d_lation_type_term = dlat_n_d_lation_type_CV.descr
WHERE
	dlat_n.d_lation_type_term IS NULL AND
	dlat_n.d_lation_type = dlat_n_d_lation_type_CVkeys.cvkey
	AND dlat_n_d_lation_type_CVkeys.idkey = dlat_n_d_lation_type_CV.idkey
;
ALTER TABLE dlat_dm ADD COLUMN data_status_term VARCHAR(1024);

UPDATE dlat_dm , dlat_dm_data_status_CVkeys , dlat_dm_data_status_CV
SET
	dlat_dm.data_status_term = dlat_dm_data_status_CV.descr
WHERE
	dlat_dm.data_status_term IS NULL AND
	dlat_dm.data_status = dlat_dm_data_status_CVkeys.cvkey
	AND dlat_dm_data_status_CVkeys.idkey = dlat_dm_data_status_CV.idkey
;
ALTER TABLE dlat_dmr ADD COLUMN hyper_role_term VARCHAR(1024);

UPDATE dlat_dmr , dlat_dmr_hyper_role_CVkeys , dlat_dmr_hyper_role_CV
SET
	dlat_dmr.hyper_role_term = dlat_dmr_hyper_role_CV.descr
WHERE
	dlat_dmr.hyper_role_term IS NULL AND
	dlat_dmr.hyper_role = dlat_dmr_hyper_role_CVkeys.cvkey
	AND dlat_dmr_hyper_role_CVkeys.idkey = dlat_dmr_hyper_role_CV.idkey
;
