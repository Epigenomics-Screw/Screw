cwlVersion: v1.0
class: Workflow

requirements:
  - class:  SubworkflowFeatureRequirement
  - class:  ScatterFeatureRequirement
  # - class: InlineJavascriptRequirement

inputs:
  inputDir: Directory 
  outputDir: Directory
  format: string
  subsetBed: File
  annotationFile: File


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
  subsettedMeth:
    type: File[]
    outputSource: subset_by_bed/subsetted


steps:
# Making the directories (predetermined) for organizing the result files
  mkdir:
    run: mkdir.cwl
    in: 
      masterDir: outputDir
    out: []

# TODO: Test
  # mkdir2:
  #   in:
  #     masterDir: outputDir      
  #   run:
  #     class: Workflow
  #     inputs:
  #       masterDir: outputDir            
  #     outputs: []

  #     steps:
  #       master:
  #         in:
  #           masterDir: outputDir            
  #         run: mkMasterDir.cwl
  #         out: [masterDir]
  #       subDirs:
  #         in: 
  #           masterDir: outputDir
  #           subDir: [ "meth", "meth_sym", "prop_meth", "cov_bw", "subset" ]
  #         run: mkSubDirs.cwl
  #         scatter: subDir
  #         out: []

  #   out: []

# Retrieve an array of files from the input directory
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

# TODO: Test
  subset_by_bed:
    run: subsetByBed.cwl
    in:
      outDir: outputDir
      toSubset: preprocess/combined
      bedFile: subsetBed
    scatter: toSubset
    out: subsettedMeth

# TODO
  clustering:
    run: clustering.cwl
    in:
      pairDirectory: outputDir
      annotation: annotationFile
    out:
      tbDist: File
      tbHeat: File


