Since we are trying to use the same "input" file for both XGC and XGCm code,
the following line in the "input" file, should be modified when running XGCm:
  sml_surf_file='geqdsk_gene_comp_case5_fix.eqd.flx.aif_xgcm'
While running XGC code, it should be changed as follows:
  sml_surf_file='geqdsk_gene_comp_case5_fix.eqd.flx.aif'

Basically, use flux surface index file generated specifically for each code.
For further details, refer to: https://github.com/SCOREC/xgcm/issues/67
