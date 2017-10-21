cwlVersion: v1.0
class: Workflow

inputs:
  toConvert: File
  format: string

outputs:
  converted: 
    type: File
    outputSource: convertMethylation/converted
  combined: 
    type: File
    outputSource: mergeSymmetric/combined
  methBW:
    type: File
    outputSource: methylationBigWIG/methBW
  covBW:
    type: File
    outputSource: methylationBigWIG/covBW

steps:
  convertMethylation:
    run: interconverter.cwl
    in:
      toConvert: toConvert
      format: format 
    out: [converted]
  mergeSymmetric:
    run: symmetriccpgs.cwl
    in:
      toCombine: convertMethylation/converted
    out: [combined]
  methylationBigWIG:
    run: methToBigWig.cwl
    in: 
      toConvert: mergeSymmetric/combined
    out: [methBW, covBW]
    
