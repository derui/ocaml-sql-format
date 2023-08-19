Display help of executable
  $ ../../install/default/bin/ocaml-sql-format --help
  OCAML-SQL-FORMAT(1)         Ocaml-sql-format Manual        OCAML-SQL-FORMAT(1)
  
  NNAAMMEE
         ocaml-sql-format - print formatted SQL or write it directly
  
  SSYYNNOOPPSSIISS
         ooccaammll--ssqqll--ffoorrmmaatt [----ccoonnffiigg=_C_O_N_F_I_G] [----wwrriittee] [_O_P_T_I_O_N]… [_F_I_L_E]…
  
  AARRGGUUMMEENNTTSS
         _F_I_L_E
             Path of files
  
  OOPPTTIIOONNSS
         --cc _C_O_N_F_I_G, ----ccoonnffiigg=_C_O_N_F_I_G (absent=~~//..ooccaammll--ssqqll--ffoorrmmaatt..ttoommll or
         OOCCAAMMLL__SSQQLL__FFOORRMMAATT__CCOONNFFIIGG env)
             Specify configuration file
  
         --ww, ----wwrriittee
             Overwrite file.
  
  CCOOMMMMOONN OOPPTTIIOONNSS
         ----hheellpp[=_F_M_T] (default=aauuttoo)
             Show this help in format _F_M_T. The value _F_M_T must be one of aauuttoo,
             ppaaggeerr, ggrrooffff or ppllaaiinn. With aauuttoo, the format is ppaaggeerr or ppllaaiinn
             whenever the TTEERRMM env var is dduummbb or undefined.
  
         ----vveerrssiioonn
             Show version information.
  
  EEXXIITT SSTTAATTUUSS
         ooccaammll--ssqqll--ffoorrmmaatt exits with:
  
         0   on success.
  
         123 on indiscriminate errors reported on standard error.
  
         124 on command line parsing errors.
  
         125 on unexpected internal errors (bugs).
  
  EENNVVIIRROONNMMEENNTT
         These environment variables affect the execution of ooccaammll--ssqqll--ffoorrmmaatt:
  
         OOCCAAMMLL__SSQQLL__FFOORRMMAATT__CCOONNFFIIGG
             Overrides the default configuration file to format
  
  BBUUGGSS
         Email bug report to <derutakayu@gmail.com>
  
  Ocaml-sql-format 0.1.0                                     OCAML-SQL-FORMAT(1)
