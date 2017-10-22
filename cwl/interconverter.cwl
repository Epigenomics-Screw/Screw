cwlVersion: v1.0
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"
baseCommand: interconverter.sh
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
  format:
    type: string
    inputBinding:
      prefix: -f
outputs:
  converted:
    type: File
    outputBinding:
      glob: "*.meth"
