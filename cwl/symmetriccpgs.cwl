cwlVersion: v1.0
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"
baseCommand: symmetriccpgs.sh
arguments: ["-d", $(runtime.outdir)]

inputs:
  # outDir:
  #   type: Directory
  #   inputBinding:
  #     prefix: -d
  toCombine:
    type: File
    inputBinding:
      prefix: -i
outputs:
  combined:
    type: File
    outputBinding:
      glob: "*.sym"
