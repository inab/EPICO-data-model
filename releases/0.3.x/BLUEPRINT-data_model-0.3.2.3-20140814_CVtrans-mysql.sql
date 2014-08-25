-- File BLUEPRINT-data_model-0.3.2.3-20140814_CVtrans-mysql.sql (mysql dialect)
-- Generated from BLUEPRINT 0.3.2.3
-- Thu Aug 14 13:05:35 2014

SET storage_engine=InnoDB;
ALTER TABLE sdata_donor ADD COLUMN donor_sex_term VARCHAR(1024);

UPDATE sdata_donor , sex_CVkeys , sex_CV
SET
	sdata_donor.donor_sex_term = sex_CV.descr
WHERE
	sdata_donor.donor_sex_term IS NULL AND
	sdata_donor.donor_sex = sex_CVkeys.cvkey
	AND sex_CVkeys.idkey = sex_CV.idkey
;
ALTER TABLE sdata_donor_donor_region_of_residence ADD COLUMN donor_region_of_residence_term VARCHAR(1024);

UPDATE sdata_donor_donor_region_of_residence , ISO3166_CVkeys , ISO3166_CV
SET
	sdata_donor_donor_region_of_residence.donor_region_of_residence_term = ISO3166_CV.descr
WHERE
	sdata_donor_donor_region_of_residence.donor_region_of_residence_term IS NULL AND
	sdata_donor_donor_region_of_residence.donor_region_of_residence = ISO3166_CVkeys.cvkey
	AND ISO3166_CVkeys.idkey = ISO3166_CV.idkey
;
ALTER TABLE sdata_specimen ADD COLUMN specimen_term_term VARCHAR(1024);

UPDATE sdata_specimen , _anonCV_1_CVkeys , _anonCV_1_CV
SET
	sdata_specimen.specimen_term_term = _anonCV_1_CV.descr
WHERE
	sdata_specimen.specimen_term_term IS NULL AND
	sdata_specimen.specimen_term = _anonCV_1_CVkeys.cvkey
	AND _anonCV_1_CVkeys.idkey = _anonCV_1_CV.idkey
;
ALTER TABLE sdata_specimen ADD COLUMN donor_disease_term VARCHAR(1024);

UPDATE sdata_specimen , _anonCV_2_CVkeys , _anonCV_2_CV
SET
	sdata_specimen.donor_disease_term = _anonCV_2_CV.descr
WHERE
	sdata_specimen.donor_disease_term IS NULL AND
	sdata_specimen.donor_disease = _anonCV_2_CVkeys.cvkey
	AND _anonCV_2_CVkeys.idkey = _anonCV_2_CV.idkey
;
ALTER TABLE sdata_specimen ADD COLUMN specimen_processing_term VARCHAR(1024);

UPDATE sdata_specimen , _anonCV_3_CVkeys , _anonCV_3_CV
SET
	sdata_specimen.specimen_processing_term = _anonCV_3_CV.descr
WHERE
	sdata_specimen.specimen_processing_term IS NULL AND
	sdata_specimen.specimen_processing = _anonCV_3_CVkeys.cvkey
	AND _anonCV_3_CVkeys.idkey = _anonCV_3_CV.idkey
;
ALTER TABLE sdata_specimen ADD COLUMN specimen_storage_term VARCHAR(1024);

UPDATE sdata_specimen , _anonCV_4_CVkeys , _anonCV_4_CV
SET
	sdata_specimen.specimen_storage_term = _anonCV_4_CV.descr
WHERE
	sdata_specimen.specimen_storage_term IS NULL AND
	sdata_specimen.specimen_storage = _anonCV_4_CVkeys.cvkey
	AND _anonCV_4_CVkeys.idkey = _anonCV_4_CV.idkey
;
ALTER TABLE sdata_sample ADD COLUMN purified_cell_type_term VARCHAR(1024);

UPDATE sdata_sample , _anonCV_5_CVkeys , _anonCV_5_CV
SET
	sdata_sample.purified_cell_type_term = _anonCV_5_CV.descr
WHERE
	sdata_sample.purified_cell_type_term IS NULL AND
	sdata_sample.purified_cell_type = _anonCV_5_CVkeys.cvkey
	AND _anonCV_5_CVkeys.idkey = _anonCV_5_CV.idkey
;
ALTER TABLE sdata_sample ADD COLUMN analyzed_sample_type_term VARCHAR(1024);

UPDATE sdata_sample , _anonCV_6_CVkeys , _anonCV_6_CV
SET
	sdata_sample.analyzed_sample_type_term = _anonCV_6_CV.descr
WHERE
	sdata_sample.analyzed_sample_type_term IS NULL AND
	sdata_sample.analyzed_sample_type = _anonCV_6_CVkeys.cvkey
	AND _anonCV_6_CVkeys.idkey = _anonCV_6_CV.idkey
;
ALTER TABLE lab_AbstractExperiment ADD COLUMN library_strategy_term VARCHAR(1024);

UPDATE lab_AbstractExperiment , SRALibraryStrategy_CVkeys , SRALibraryStrategy_CV
SET
	lab_AbstractExperiment.library_strategy_term = SRALibraryStrategy_CV.descr
WHERE
	lab_AbstractExperiment.library_strategy_term IS NULL AND
	lab_AbstractExperiment.library_strategy = SRALibraryStrategy_CVkeys.cvkey
	AND SRALibraryStrategy_CVkeys.idkey = SRALibraryStrategy_CV.idkey
;
ALTER TABLE lab_AbstractExperimentExtraction ADD COLUMN library_strategy_term VARCHAR(1024);

UPDATE lab_AbstractExperimentExtraction , SRALibraryStrategy_CVkeys , SRALibraryStrategy_CV
SET
	lab_AbstractExperimentExtraction.library_strategy_term = SRALibraryStrategy_CV.descr
WHERE
	lab_AbstractExperimentExtraction.library_strategy_term IS NULL AND
	lab_AbstractExperimentExtraction.library_strategy = SRALibraryStrategy_CVkeys.cvkey
	AND SRALibraryStrategy_CVkeys.idkey = SRALibraryStrategy_CV.idkey
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
ALTER TABLE lab_AbstractExperiment ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_AbstractExperiment , B5_CVkeys , B5_CV
SET
	lab_AbstractExperiment.platform_term = B5_CV.descr
WHERE
	lab_AbstractExperiment.platform_term IS NULL AND
	lab_AbstractExperiment.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_AbstractExperimentExtraction ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_AbstractExperimentExtraction , B5_CVkeys , B5_CV
SET
	lab_AbstractExperimentExtraction.platform_term = B5_CV.descr
WHERE
	lab_AbstractExperimentExtraction.platform_term IS NULL AND
	lab_AbstractExperimentExtraction.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_chro ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_chro , B5_CVkeys , B5_CV
SET
	lab_chro.platform_term = B5_CV.descr
WHERE
	lab_chro.platform_term IS NULL AND
	lab_chro.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_wgbs ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_wgbs , B5_CVkeys , B5_CV
SET
	lab_wgbs.platform_term = B5_CV.descr
WHERE
	lab_wgbs.platform_term IS NULL AND
	lab_wgbs.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_medip ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_medip , B5_CVkeys , B5_CV
SET
	lab_medip.platform_term = B5_CV.descr
WHERE
	lab_medip.platform_term IS NULL AND
	lab_medip.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_mre ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_mre , B5_CVkeys , B5_CV
SET
	lab_mre.platform_term = B5_CV.descr
WHERE
	lab_mre.platform_term IS NULL AND
	lab_mre.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_csi ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_csi , B5_CVkeys , B5_CV
SET
	lab_csi.platform_term = B5_CV.descr
WHERE
	lab_csi.platform_term IS NULL AND
	lab_csi.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_cs ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_cs , B5_CVkeys , B5_CV
SET
	lab_cs.platform_term = B5_CV.descr
WHERE
	lab_cs.platform_term IS NULL AND
	lab_cs.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_mrna ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_mrna , B5_CVkeys , B5_CV
SET
	lab_mrna.platform_term = B5_CV.descr
WHERE
	lab_mrna.platform_term IS NULL AND
	lab_mrna.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_smrna ADD COLUMN platform_term VARCHAR(1024);

UPDATE lab_smrna , B5_CVkeys , B5_CV
SET
	lab_smrna.platform_term = B5_CV.descr
WHERE
	lab_smrna.platform_term IS NULL AND
	lab_smrna.platform = B5_CVkeys.cvkey
	AND B5_CVkeys.idkey = B5_CV.idkey
;
ALTER TABLE lab_AbstractExperiment_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_AbstractExperiment_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_AbstractExperiment_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_AbstractExperiment_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_AbstractExperiment_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_AbstractExperimentExtraction_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_AbstractExperimentExtraction_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_AbstractExperimentExtraction_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_AbstractExperimentExtraction_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_AbstractExperimentExtraction_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_chro_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_chro_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_chro_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_chro_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_chro_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_wgbs_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_wgbs_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_wgbs_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_wgbs_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_wgbs_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_medip_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_medip_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_medip_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_medip_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_medip_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_mre_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_mre_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_mre_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_mre_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_mre_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_csi_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_csi_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_csi_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_csi_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_csi_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_cs_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_cs_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_cs_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_cs_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_cs_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_mrna_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_mrna_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_mrna_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_mrna_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_mrna_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_smrna_experimental_group_id ADD COLUMN experimental_group_id_term VARCHAR(1024);

UPDATE lab_smrna_experimental_group_id , B1_CVkeys , B1_CV
SET
	lab_smrna_experimental_group_id.experimental_group_id_term = B1_CV.descr
WHERE
	lab_smrna_experimental_group_id.experimental_group_id_term IS NULL AND
	lab_smrna_experimental_group_id.experimental_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE exp_m_analysis_group_id ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE exp_m_analysis_group_id , B1_CVkeys , B1_CV
SET
	exp_m_analysis_group_id.analysis_group_id_term = B1_CV.descr
WHERE
	exp_m_analysis_group_id.analysis_group_id_term IS NULL AND
	exp_m_analysis_group_id.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE jcn_m_analysis_group_id ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE jcn_m_analysis_group_id , B1_CVkeys , B1_CV
SET
	jcn_m_analysis_group_id.analysis_group_id_term = B1_CV.descr
WHERE
	jcn_m_analysis_group_id.analysis_group_id_term IS NULL AND
	jcn_m_analysis_group_id.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE pdna_m_analysis_group_id ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE pdna_m_analysis_group_id , B1_CVkeys , B1_CV
SET
	pdna_m_analysis_group_id.analysis_group_id_term = B1_CV.descr
WHERE
	pdna_m_analysis_group_id.analysis_group_id_term IS NULL AND
	pdna_m_analysis_group_id.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE rreg_m_analysis_group_id ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE rreg_m_analysis_group_id , B1_CVkeys , B1_CV
SET
	rreg_m_analysis_group_id.analysis_group_id_term = B1_CV.descr
WHERE
	rreg_m_analysis_group_id.analysis_group_id_term IS NULL AND
	rreg_m_analysis_group_id.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE dlat_m_analysis_group_id ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE dlat_m_analysis_group_id , B1_CVkeys , B1_CV
SET
	dlat_m_analysis_group_id.analysis_group_id_term = B1_CV.descr
WHERE
	dlat_m_analysis_group_id.analysis_group_id_term IS NULL AND
	dlat_m_analysis_group_id.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE dlat_dm_analysis_group_id ADD COLUMN analysis_group_id_term VARCHAR(1024);

UPDATE dlat_dm_analysis_group_id , B1_CVkeys , B1_CV
SET
	dlat_dm_analysis_group_id.analysis_group_id_term = B1_CV.descr
WHERE
	dlat_dm_analysis_group_id.analysis_group_id_term IS NULL AND
	dlat_dm_analysis_group_id.analysis_group_id = B1_CVkeys.cvkey
	AND B1_CVkeys.idkey = B1_CV.idkey
;
ALTER TABLE lab_chro_features ADD COLUMN feature_term VARCHAR(1024);

UPDATE lab_chro_features , _anonCV_7_CVkeys , _anonCV_7_CV
SET
	lab_chro_features.feature_term = _anonCV_7_CV.descr
WHERE
	lab_chro_features.feature_term IS NULL AND
	lab_chro_features.feature = _anonCV_7_CVkeys.cvkey
	AND _anonCV_7_CVkeys.idkey = _anonCV_7_CV.idkey
;
ALTER TABLE lab_wgbs_features ADD COLUMN feature_term VARCHAR(1024);

UPDATE lab_wgbs_features , wgbsFeatures_CVkeys , wgbsFeatures_CV
SET
	lab_wgbs_features.feature_term = wgbsFeatures_CV.descr
WHERE
	lab_wgbs_features.feature_term IS NULL AND
	lab_wgbs_features.feature = wgbsFeatures_CVkeys.cvkey
	AND wgbsFeatures_CVkeys.idkey = wgbsFeatures_CV.idkey
;
ALTER TABLE lab_medip_features ADD COLUMN feature_term VARCHAR(1024);

UPDATE lab_medip_features , medipFeatures_CVkeys , medipFeatures_CV
SET
	lab_medip_features.feature_term = medipFeatures_CV.descr
WHERE
	lab_medip_features.feature_term IS NULL AND
	lab_medip_features.feature = medipFeatures_CVkeys.cvkey
	AND medipFeatures_CVkeys.idkey = medipFeatures_CV.idkey
;
ALTER TABLE lab_mre_features ADD COLUMN feature_term VARCHAR(1024);

UPDATE lab_mre_features , mreFeatures_CVkeys , mreFeatures_CV
SET
	lab_mre_features.feature_term = mreFeatures_CV.descr
WHERE
	lab_mre_features.feature_term IS NULL AND
	lab_mre_features.feature = mreFeatures_CVkeys.cvkey
	AND mreFeatures_CVkeys.idkey = mreFeatures_CV.idkey
;
ALTER TABLE lab_csi_features ADD COLUMN feature_term VARCHAR(1024);

UPDATE lab_csi_features , csiFeatures_CVkeys , csiFeatures_CV
SET
	lab_csi_features.feature_term = csiFeatures_CV.descr
WHERE
	lab_csi_features.feature_term IS NULL AND
	lab_csi_features.feature = csiFeatures_CVkeys.cvkey
	AND csiFeatures_CVkeys.idkey = csiFeatures_CV.idkey
;
ALTER TABLE lab_cs_features ADD COLUMN feature_term VARCHAR(1024);

UPDATE lab_cs_features , csFeatures_CVkeys , csFeatures_CV
SET
	lab_cs_features.feature_term = csFeatures_CV.descr
WHERE
	lab_cs_features.feature_term IS NULL AND
	lab_cs_features.feature = csFeatures_CVkeys.cvkey
	AND csFeatures_CVkeys.idkey = csFeatures_CV.idkey
;
ALTER TABLE lab_mrna_features ADD COLUMN feature_term VARCHAR(1024);

UPDATE lab_mrna_features , mrnaFeatures_CVkeys , mrnaFeatures_CV
SET
	lab_mrna_features.feature_term = mrnaFeatures_CV.descr
WHERE
	lab_mrna_features.feature_term IS NULL AND
	lab_mrna_features.feature = mrnaFeatures_CVkeys.cvkey
	AND mrnaFeatures_CVkeys.idkey = mrnaFeatures_CV.idkey
;
ALTER TABLE lab_smrna_features ADD COLUMN feature_term VARCHAR(1024);

UPDATE lab_smrna_features , smrnaFeatures_CVkeys , smrnaFeatures_CV
SET
	lab_smrna_features.feature_term = smrnaFeatures_CV.descr
WHERE
	lab_smrna_features.feature_term IS NULL AND
	lab_smrna_features.feature = smrnaFeatures_CVkeys.cvkey
	AND smrnaFeatures_CVkeys.idkey = smrnaFeatures_CV.idkey
;
ALTER TABLE exp_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE exp_m , _anonCV_0_CVkeys , _anonCV_0_CV
SET
	exp_m.data_status_term = _anonCV_0_CV.descr
WHERE
	exp_m.data_status_term IS NULL AND
	exp_m.data_status = _anonCV_0_CVkeys.cvkey
	AND _anonCV_0_CVkeys.idkey = _anonCV_0_CV.idkey
;
ALTER TABLE jcn_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE jcn_m , _anonCV_0_CVkeys , _anonCV_0_CV
SET
	jcn_m.data_status_term = _anonCV_0_CV.descr
WHERE
	jcn_m.data_status_term IS NULL AND
	jcn_m.data_status = _anonCV_0_CVkeys.cvkey
	AND _anonCV_0_CVkeys.idkey = _anonCV_0_CV.idkey
;
ALTER TABLE pdna_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE pdna_m , _anonCV_0_CVkeys , _anonCV_0_CV
SET
	pdna_m.data_status_term = _anonCV_0_CV.descr
WHERE
	pdna_m.data_status_term IS NULL AND
	pdna_m.data_status = _anonCV_0_CVkeys.cvkey
	AND _anonCV_0_CVkeys.idkey = _anonCV_0_CV.idkey
;
ALTER TABLE rreg_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE rreg_m , _anonCV_0_CVkeys , _anonCV_0_CV
SET
	rreg_m.data_status_term = _anonCV_0_CV.descr
WHERE
	rreg_m.data_status_term IS NULL AND
	rreg_m.data_status = _anonCV_0_CVkeys.cvkey
	AND _anonCV_0_CVkeys.idkey = _anonCV_0_CV.idkey
;
ALTER TABLE dlat_m ADD COLUMN data_status_term VARCHAR(1024);

UPDATE dlat_m , _anonCV_0_CVkeys , _anonCV_0_CV
SET
	dlat_m.data_status_term = _anonCV_0_CV.descr
WHERE
	dlat_m.data_status_term IS NULL AND
	dlat_m.data_status = _anonCV_0_CVkeys.cvkey
	AND _anonCV_0_CVkeys.idkey = _anonCV_0_CV.idkey
;
ALTER TABLE dlat_dm ADD COLUMN data_status_term VARCHAR(1024);

UPDATE dlat_dm , _anonCV_0_CVkeys , _anonCV_0_CV
SET
	dlat_dm.data_status_term = _anonCV_0_CV.descr
WHERE
	dlat_dm.data_status_term IS NULL AND
	dlat_dm.data_status = _anonCV_0_CVkeys.cvkey
	AND _anonCV_0_CVkeys.idkey = _anonCV_0_CV.idkey
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
ALTER TABLE exp_g ADD COLUMN gene_stable_id_term VARCHAR(1024);

UPDATE exp_g , EnsemblGenes_CVkeys , EnsemblGenes_CV
SET
	exp_g.gene_stable_id_term = EnsemblGenes_CV.descr
WHERE
	exp_g.gene_stable_id_term IS NULL AND
	exp_g.gene_stable_id = EnsemblGenes_CVkeys.cvkey
	AND EnsemblGenes_CVkeys.idkey = EnsemblGenes_CV.idkey
;
ALTER TABLE pdna_s_gene_affected ADD COLUMN gene_affected_term VARCHAR(1024);

UPDATE pdna_s_gene_affected , EnsemblGenes_CVkeys , EnsemblGenes_CV
SET
	pdna_s_gene_affected.gene_affected_term = EnsemblGenes_CV.descr
WHERE
	pdna_s_gene_affected.gene_affected_term IS NULL AND
	pdna_s_gene_affected.gene_affected = EnsemblGenes_CVkeys.cvkey
	AND EnsemblGenes_CVkeys.idkey = EnsemblGenes_CV.idkey
;
ALTER TABLE dlat_s_gene_affected ADD COLUMN gene_affected_term VARCHAR(1024);

UPDATE dlat_s_gene_affected , EnsemblGenes_CVkeys , EnsemblGenes_CV
SET
	dlat_s_gene_affected.gene_affected_term = EnsemblGenes_CV.descr
WHERE
	dlat_s_gene_affected.gene_affected_term IS NULL AND
	dlat_s_gene_affected.gene_affected = EnsemblGenes_CVkeys.cvkey
	AND EnsemblGenes_CVkeys.idkey = EnsemblGenes_CV.idkey
;
ALTER TABLE exp_g ADD COLUMN transcript_stable_id_term VARCHAR(1024);

UPDATE exp_g , EnsemblTranscripts_CVkeys , EnsemblTranscripts_CV
SET
	exp_g.transcript_stable_id_term = EnsemblTranscripts_CV.descr
WHERE
	exp_g.transcript_stable_id_term IS NULL AND
	exp_g.transcript_stable_id = EnsemblTranscripts_CVkeys.cvkey
	AND EnsemblTranscripts_CVkeys.idkey = EnsemblTranscripts_CV.idkey
;
ALTER TABLE pdna_s_transcript_affected ADD COLUMN transcript_affected_term VARCHAR(1024);

UPDATE pdna_s_transcript_affected , EnsemblTranscripts_CVkeys , EnsemblTranscripts_CV
SET
	pdna_s_transcript_affected.transcript_affected_term = EnsemblTranscripts_CV.descr
WHERE
	pdna_s_transcript_affected.transcript_affected_term IS NULL AND
	pdna_s_transcript_affected.transcript_affected = EnsemblTranscripts_CVkeys.cvkey
	AND EnsemblTranscripts_CVkeys.idkey = EnsemblTranscripts_CV.idkey
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
ALTER TABLE dlat_m ADD COLUMN mr_type_term VARCHAR(1024);

UPDATE dlat_m , _anonCV_8_CVkeys , _anonCV_8_CV
SET
	dlat_m.mr_type_term = _anonCV_8_CV.descr
WHERE
	dlat_m.mr_type_term IS NULL AND
	dlat_m.mr_type = _anonCV_8_CVkeys.cvkey
	AND _anonCV_8_CVkeys.idkey = _anonCV_8_CV.idkey
;
ALTER TABLE dlat_n ADD COLUMN d_lation_type_term VARCHAR(1024);

UPDATE dlat_n , _anonCV_9_CVkeys , _anonCV_9_CV
SET
	dlat_n.d_lation_type_term = _anonCV_9_CV.descr
WHERE
	dlat_n.d_lation_type_term IS NULL AND
	dlat_n.d_lation_type = _anonCV_9_CVkeys.cvkey
	AND _anonCV_9_CVkeys.idkey = _anonCV_9_CV.idkey
;
ALTER TABLE dlat_dmr ADD COLUMN hyper_role_term VARCHAR(1024);

UPDATE dlat_dmr , _anonCV_10_CVkeys , _anonCV_10_CV
SET
	dlat_dmr.hyper_role_term = _anonCV_10_CV.descr
WHERE
	dlat_dmr.hyper_role_term IS NULL AND
	dlat_dmr.hyper_role = _anonCV_10_CVkeys.cvkey
	AND _anonCV_10_CVkeys.idkey = _anonCV_10_CV.idkey
;
