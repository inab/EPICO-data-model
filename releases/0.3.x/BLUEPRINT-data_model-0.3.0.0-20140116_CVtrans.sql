-- File BLUEPRINT-data_model-0.3.0.0-20140116_CVtrans.sql
-- Generated from BLUEPRINT 0.3.0.0
-- Thu Jan 16 18:54:47 2014
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

UPDATE sdata_specimen , _anonCV_0_CVkeys , _anonCV_0_CV
SET
	sdata_specimen.specimen_type_term = _anonCV_0_CV.descr
WHERE
	sdata_specimen.specimen_type_term IS NULL AND
	sdata_specimen.specimen_type = _anonCV_0_CVkeys.cvkey
	AND _anonCV_0_CVkeys.idkey = _anonCV_0_CV.idkey
;
ALTER TABLE sdata_specimen ADD COLUMN specimen_processing_term VARCHAR(1024);

UPDATE sdata_specimen , _anonCV_1_CVkeys , _anonCV_1_CV
SET
	sdata_specimen.specimen_processing_term = _anonCV_1_CV.descr
WHERE
	sdata_specimen.specimen_processing_term IS NULL AND
	sdata_specimen.specimen_processing = _anonCV_1_CVkeys.cvkey
	AND _anonCV_1_CVkeys.idkey = _anonCV_1_CV.idkey
;
ALTER TABLE sdata_specimen ADD COLUMN specimen_storage_term VARCHAR(1024);

UPDATE sdata_specimen , _anonCV_2_CVkeys , _anonCV_2_CV
SET
	sdata_specimen.specimen_storage_term = _anonCV_2_CV.descr
WHERE
	sdata_specimen.specimen_storage_term IS NULL AND
	sdata_specimen.specimen_storage = _anonCV_2_CVkeys.cvkey
	AND _anonCV_2_CVkeys.idkey = _anonCV_2_CV.idkey
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

UPDATE sdata_sample , _anonCV_3_CVkeys , _anonCV_3_CV
SET
	sdata_sample.analyzed_sample_type_term = _anonCV_3_CV.descr
WHERE
	sdata_sample.analyzed_sample_type_term IS NULL AND
	sdata_sample.analyzed_sample_type = _anonCV_3_CVkeys.cvkey
	AND _anonCV_3_CVkeys.idkey = _anonCV_3_CV.idkey
;
ALTER TABLE lab_AbstractExperiment ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_AbstractExperiment , B1_CVkeys , B1_CV
SET
	lab_AbstractExperiment.experimental_group_id_term = B1_CV.descr
WHERE
	lab_AbstractExperiment.experimental_group_id_term IS NULL AND
	lab_AbstractExperiment.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_AbstractExperimentExtraction ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_AbstractExperimentExtraction , B1_CVkeys , B1_CV
SET
	lab_AbstractExperimentExtraction.experimental_group_id_term = B1_CV.descr
WHERE
	lab_AbstractExperimentExtraction.experimental_group_id_term IS NULL AND
	lab_AbstractExperimentExtraction.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_chro ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_chro , B1_CVkeys , B1_CV
SET
	lab_chro.experimental_group_id_term = B1_CV.descr
WHERE
	lab_chro.experimental_group_id_term IS NULL AND
	lab_chro.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_wgbs ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_wgbs , B1_CVkeys , B1_CV
SET
	lab_wgbs.experimental_group_id_term = B1_CV.descr
WHERE
	lab_wgbs.experimental_group_id_term IS NULL AND
	lab_wgbs.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_medip ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_medip , B1_CVkeys , B1_CV
SET
	lab_medip.experimental_group_id_term = B1_CV.descr
WHERE
	lab_medip.experimental_group_id_term IS NULL AND
	lab_medip.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_mre ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_mre , B1_CVkeys , B1_CV
SET
	lab_mre.experimental_group_id_term = B1_CV.descr
WHERE
	lab_mre.experimental_group_id_term IS NULL AND
	lab_mre.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_csi ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_csi , B1_CVkeys , B1_CV
SET
	lab_csi.experimental_group_id_term = B1_CV.descr
WHERE
	lab_csi.experimental_group_id_term IS NULL AND
	lab_csi.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_cs ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_cs , B1_CVkeys , B1_CV
SET
	lab_cs.experimental_group_id_term = B1_CV.descr
WHERE
	lab_cs.experimental_group_id_term IS NULL AND
	lab_cs.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_mrna ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_mrna , B1_CVkeys , B1_CV
SET
	lab_mrna.experimental_group_id_term = B1_CV.descr
WHERE
	lab_mrna.experimental_group_id_term IS NULL AND
	lab_mrna.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_smrna ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_smrna , B1_CVkeys , B1_CV
SET
	lab_smrna.experimental_group_id_term = B1_CV.descr
WHERE
	lab_smrna.experimental_group_id_term IS NULL AND
	lab_smrna.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
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
ALTER TABLE jcn_m ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE jcn_m , B1_CVkeys , B1_CV
SET
	jcn_m.analysis_group_id_term = B1_CV.descr
WHERE
	jcn_m.analysis_group_id_term IS NULL AND
	jcn_m.analysis_group_id = B1_CVkeys.cvkey
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
ALTER TABLE rreg_m ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE rreg_m , B1_CVkeys , B1_CV
SET
	rreg_m.analysis_group_id_term = B1_CV.descr
WHERE
	rreg_m.analysis_group_id_term IS NULL AND
	rreg_m.analysis_group_id = B1_CVkeys.cvkey
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
ALTER TABLE dlat_dm ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE dlat_dm , B1_CVkeys , B1_CV
SET
	dlat_dm.analysis_group_id_term = B1_CV.descr
WHERE
	dlat_dm.analysis_group_id_term IS NULL AND
	dlat_dm.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_AbstractExperiment ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_AbstractExperiment , B12_CVkeys , B12_CV
SET
	lab_AbstractExperiment.raw_data_repository_term = B12_CV.descr
WHERE
	lab_AbstractExperiment.raw_data_repository_term IS NULL AND
	lab_AbstractExperiment.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE lab_AbstractExperimentExtraction ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_AbstractExperimentExtraction , B12_CVkeys , B12_CV
SET
	lab_AbstractExperimentExtraction.raw_data_repository_term = B12_CV.descr
WHERE
	lab_AbstractExperimentExtraction.raw_data_repository_term IS NULL AND
	lab_AbstractExperimentExtraction.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE lab_chro ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_chro , B12_CVkeys , B12_CV
SET
	lab_chro.raw_data_repository_term = B12_CV.descr
WHERE
	lab_chro.raw_data_repository_term IS NULL AND
	lab_chro.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE lab_wgbs ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_wgbs , B12_CVkeys , B12_CV
SET
	lab_wgbs.raw_data_repository_term = B12_CV.descr
WHERE
	lab_wgbs.raw_data_repository_term IS NULL AND
	lab_wgbs.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE lab_medip ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_medip , B12_CVkeys , B12_CV
SET
	lab_medip.raw_data_repository_term = B12_CV.descr
WHERE
	lab_medip.raw_data_repository_term IS NULL AND
	lab_medip.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE lab_mre ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_mre , B12_CVkeys , B12_CV
SET
	lab_mre.raw_data_repository_term = B12_CV.descr
WHERE
	lab_mre.raw_data_repository_term IS NULL AND
	lab_mre.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE lab_csi ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_csi , B12_CVkeys , B12_CV
SET
	lab_csi.raw_data_repository_term = B12_CV.descr
WHERE
	lab_csi.raw_data_repository_term IS NULL AND
	lab_csi.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE lab_cs ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_cs , B12_CVkeys , B12_CV
SET
	lab_cs.raw_data_repository_term = B12_CV.descr
WHERE
	lab_cs.raw_data_repository_term IS NULL AND
	lab_cs.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE lab_mrna ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_mrna , B12_CVkeys , B12_CV
SET
	lab_mrna.raw_data_repository_term = B12_CV.descr
WHERE
	lab_mrna.raw_data_repository_term IS NULL AND
	lab_mrna.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE lab_smrna ADD COLUMN raw_data_repository_term VARCHAR(1024);

UPDATE lab_smrna , B12_CVkeys , B12_CV
SET
	lab_smrna.raw_data_repository_term = B12_CV.descr
WHERE
	lab_smrna.raw_data_repository_term IS NULL AND
	lab_smrna.raw_data_repository = B12_CVkeys.cvkey
	AND B12_CVkeys.idkey = B12_CV.idkey
;
ALTER TABLE exp_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE exp_m , _anonCV_4_CVkeys , _anonCV_4_CV
SET
	exp_m.data_status_term = _anonCV_4_CV.descr
WHERE
	exp_m.data_status_term IS NULL AND
	exp_m.data_status = _anonCV_4_CVkeys.cvkey
	AND _anonCV_4_CVkeys.idkey = _anonCV_4_CV.idkey
;
ALTER TABLE jcn_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE jcn_m , _anonCV_4_CVkeys , _anonCV_4_CV
SET
	jcn_m.data_status_term = _anonCV_4_CV.descr
WHERE
	jcn_m.data_status_term IS NULL AND
	jcn_m.data_status = _anonCV_4_CVkeys.cvkey
	AND _anonCV_4_CVkeys.idkey = _anonCV_4_CV.idkey
;
ALTER TABLE pdna_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE pdna_m , _anonCV_4_CVkeys , _anonCV_4_CV
SET
	pdna_m.data_status_term = _anonCV_4_CV.descr
WHERE
	pdna_m.data_status_term IS NULL AND
	pdna_m.data_status = _anonCV_4_CVkeys.cvkey
	AND _anonCV_4_CVkeys.idkey = _anonCV_4_CV.idkey
;
ALTER TABLE rreg_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE rreg_m , _anonCV_4_CVkeys , _anonCV_4_CV
SET
	rreg_m.data_status_term = _anonCV_4_CV.descr
WHERE
	rreg_m.data_status_term IS NULL AND
	rreg_m.data_status = _anonCV_4_CVkeys.cvkey
	AND _anonCV_4_CVkeys.idkey = _anonCV_4_CV.idkey
;
ALTER TABLE dlat_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE dlat_m , _anonCV_4_CVkeys , _anonCV_4_CV
SET
	dlat_m.data_status_term = _anonCV_4_CV.descr
WHERE
	dlat_m.data_status_term IS NULL AND
	dlat_m.data_status = _anonCV_4_CVkeys.cvkey
	AND _anonCV_4_CVkeys.idkey = _anonCV_4_CV.idkey
;
ALTER TABLE dlat_dm ADD COLUMN data_status_term VARCHAR(1024);

UPDATE dlat_dm , _anonCV_4_CVkeys , _anonCV_4_CV
SET
	dlat_dm.data_status_term = _anonCV_4_CV.descr
WHERE
	dlat_dm.data_status_term IS NULL AND
	dlat_dm.data_status = _anonCV_4_CVkeys.cvkey
	AND _anonCV_4_CVkeys.idkey = _anonCV_4_CV.idkey
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
ALTER TABLE jcn_p ADD COLUMN junction_type_term VARCHAR(1024);

UPDATE jcn_p , junctionType_CVkeys , junctionType_CV
SET
	jcn_p.junction_type_term = junctionType_CV.descr
WHERE
	jcn_p.junction_type_term IS NULL AND
	jcn_p.junction_type = junctionType_CVkeys.cvkey
	AND junctionType_CVkeys.idkey = junctionType_CV.idkey
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
ALTER TABLE dlat_m ADD COLUMN mr_type_term VARCHAR(1024);

UPDATE dlat_m , _anonCV_5_CVkeys , _anonCV_5_CV
SET
	dlat_m.mr_type_term = _anonCV_5_CV.descr
WHERE
	dlat_m.mr_type_term IS NULL AND
	dlat_m.mr_type = _anonCV_5_CVkeys.cvkey
	AND _anonCV_5_CVkeys.idkey = _anonCV_5_CV.idkey
;
ALTER TABLE dlat_n ADD COLUMN d_lation_type_term VARCHAR(1024);

UPDATE dlat_n , _anonCV_6_CVkeys , _anonCV_6_CV
SET
	dlat_n.d_lation_type_term = _anonCV_6_CV.descr
WHERE
	dlat_n.d_lation_type_term IS NULL AND
	dlat_n.d_lation_type = _anonCV_6_CVkeys.cvkey
	AND _anonCV_6_CVkeys.idkey = _anonCV_6_CV.idkey
;
ALTER TABLE dlat_dmr ADD COLUMN hyper_role_term VARCHAR(1024);

UPDATE dlat_dmr , _anonCV_7_CVkeys , _anonCV_7_CV
SET
	dlat_dmr.hyper_role_term = _anonCV_7_CV.descr
WHERE
	dlat_dmr.hyper_role_term IS NULL AND
	dlat_dmr.hyper_role = _anonCV_7_CVkeys.cvkey
	AND _anonCV_7_CVkeys.idkey = _anonCV_7_CV.idkey
;
