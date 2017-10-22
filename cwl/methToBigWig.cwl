cwlVersion: v1.0
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"
baseCommand: tsvToBigWig.R
arguments: ["-d", $(runtime.outdir)]

inputs:
  # outDir:
  #   type: Directory
  #   inputBinding:
  #     prefix: -d
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
