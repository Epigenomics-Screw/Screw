cwlVersion: v1.0
class: Workflow

requirements:
  - class:  SubworkflowFeatureRequirement
  - class:  ScatterFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  inputDir: Directory 
  outputDir: string
  format: string


outputs:
  converted: 
    type: File[]
    outputSource: preprocess/converted
  combined: 
    type: File[]
    outputSource: preprocess/combined
  methBW:
    type: File[]
    outputSource: preprocess/methBW
  covBW:
    type: File[]
    outputSource: preprocess/covBW

steps:
  mkdir:
    run: mkdir.cwl
    in: 
      masterDir: outputDir
      # subDir: $(["meth", "meth_sym", "prop_meth", "cov_bw subset"])
    out: subDir
    # scatter: subDir
  directory_to_array:
    run: directoryToArray.cwl
    in:
      directory: inputDir
    out: [ array_of_files ]
  preprocess:
    run: preprocess.cwl
    in: 
      outDir: outputDir
      toConvert: directory_to_array/array_of_files
      format: format  
    out: [ converted, combined, methBW, covBW ]

    scatter: toConvert
