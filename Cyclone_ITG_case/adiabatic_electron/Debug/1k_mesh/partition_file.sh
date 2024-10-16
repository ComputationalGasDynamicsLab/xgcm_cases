# create omega_h mesh file
./../../../../install/omega_h_simmetrix/install/bin/meshsim2osh geqdsk_gene_comp_case5_fix.eqd.sms geqdsk_gene_comp_case5_fix.eqd.smd 1000mesh.osh

# create partition files
./../../../../install/pumi-pic/build/test/print_classification 1000mesh.osh 1000mesh 2 500 1.0
./../../../../install/pumi-pic/build/test/print_classification 1000mesh.osh 1000mesh 4 220 1.0
