cwlVersion: v1.0
class: CommandLineTool
baseCommand: poolCpGs.R
hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"

inputs:
  poolCpGs:
    type: Directory
    inputBinding:
      prefix: -i
  outfile:
    type: string
    inputBinding:
      prefix: -o

outputs:
  pooled:
    type: File
    outputBinding:
      glob: "*.txt"


