cwlVersion: v1.0
class: CommandLineTool
baseCommand: tsvToBigWig.R
hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"
arguments: ["-d", $(runtime.outdir)]

inputs:
  toConvert:
    type: File
    inputBinding:
      prefix: -i
outputs:
  methBW:
    type: File
    outputBinding:
      glob: "*.prop_meth.bw"
  covBW:
    type: File
    outputBinding:
      glob: "*.cov.bw"
