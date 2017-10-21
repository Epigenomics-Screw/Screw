cwlVersion: v1.0
class: Workflow

requirements:
  - class:  SubworkflowFeatureRequirement
  - class:  ScatterFeatureRequirement


inputs:
  inputDir: Directory 
  format: string
  outputDir: Directory


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
    out: [ subDir ]
  directory_to_array:
    run: directoryToArray.cwl
    in:
      directory: inputDir
    out: [ array_of_files ]
  preprocess:
    run: preprocess.cwl
    in: 
      toConvert: directory_to_array/array_of_files
      format: format  
    out: [ converted, combined, methBW, covBW]

    scatter: toConvert

