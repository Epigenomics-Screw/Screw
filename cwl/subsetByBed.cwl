cwlVersion: v1.0
class: CommandLineTool
baseCommand: subsetByBed.R
hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"
arguments: ["-d", $(runtime.outdir)]

inputs:
  # outDir:
  #   type: Directory
  #   inputBinding:
  #     prefix: -d
  toSubset:
    type: File
    inputBinding:
      prefix: -i
  bedFile:
    type: File
    inputBinding:
      prefix: -b
outputs:
  subsetted:
    type: File
    outputBinding:
      glob: "*.sym"
