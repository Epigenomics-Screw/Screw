cwlVersion: v1.0
class: Workflow

requirements:
  - class:  SubworkflowFeatureRequirement

inputs:
  inputDir: Directory
  inputFile: File

outputs: []

steps:
# Retrieve an array of files from the input directory
  directory_to_array:
    run: directoryToArray.cwl
    in:
      directory: inputDir
    out: [ array_of_files ]

# Setting & moving files to subdirectories
  directoryLayout:
    run: dirLayout.cwl
    in:
      #every output file
      meth: directory_to_array/array_of_files
      meth_sym: directory_to_array/array_of_files
      prop_meth: directory_to_array/array_of_files
      cov_bw: directory_to_array/array_of_files
      subset: directory_to_array/array_of_files
      distanceMatrix: inputFile
      heatMap: inputFile
    out: [ results ]


