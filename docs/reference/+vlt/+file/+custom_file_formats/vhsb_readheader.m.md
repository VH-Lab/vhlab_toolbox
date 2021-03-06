# vlt.file.custom_file_formats.vhsb_readheader

```
  VHSB_READHEADER - read a VH Lab Series Binary file header
 
  H = vlt.file.custom_file_formats.vhsb_writeheader(FILE_OBJ_OR_FNAME, ...)
 
  Reads the header portion of the vlt.file.fileobj or filename FILE_OBJ_OR_FNAME.
  At the conclusion of reading, the FILEOBJ or file is closed.
 
  This function returns a structure with the following fields (default in parentheses):
 
  -----------------------------------------------------------------------------------------
  version (1)                       | 32-bit integer describing version. Only 1 is allowed.
  machine_format ('little-endian')  | The machine format. The only value allowed is
                                    |    'little_endian'.
  X_data_size (64)                  | 32-bit integer describing the size (in bytes) of each 
                                    |    data point in the X series.
  X_data_type (4)                   | 8-bit unsigned integer describing whether X type is char (1), uint (2), int (3), or float (4)
  Y_dim ([1 1])                     | 64-bit unsigned integer describing the rows, columns, etc of each Y datum
  Y_data_size (64)                  | 32-bit integer describing the size (in bytes) of each 
                                    |    sample in the Y series.
  Y_data_type (4)                   | 8-bit unsigned integer describing whether Y type is char (1), uint (2), int (3), or float (4)
  X_stored (1)                      | Character 0 or 1 describing whether the X value of the series
                                    |    is stored in the file or just inferred from start and increment.
  X_constantinterval (0)            | Character 0 or 1 describing whether the X value of the series consists
                                    |    of a value that is incremented by a constant interval for each sample
  X_start (0)                       | The value of the first X data sample (same size/type as X_data)
  X_increment (0)                   | The value of the increment (same size/type as X_data)
                                    |
  X_units ('')                      | A 256 character string with the units of X (after any scaling)
  Y_units ('')                      | A 256 character string with the units of Y (after any scaling)
  
  X_usescale (0)                    | Character 0/1 should we scale what is read in X using parameters below?
  Y_usescale (0)                    | Character 0/1 should we scale what is read in Y using parameters below?
  X_scale (1)                       | 64-bit float scale factor
  X_offset (0)                      | 64-bit float offset factor common to all X info
  Y_scale (1)                       | 64-bit float scale factor
  Y_offset (0)                      | 64-bit float offset factor common to all Y info
                                    | 
  headersize (1836)                 | The full header size in bytes
  num_samples (variable)            | The calculated number of samples in the file.
  X_skip_bytes (variable)           | Number of bytes to skip over when reading X samples
  Y_skip_bytes (variable)           | Number of bytes to skip over when reading Y samples
  sample_size (variable)            | The size of each (x,y) pair of samples in bytes
  filesize (variable)               | The size of the file in bytes

```
