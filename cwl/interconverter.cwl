cwlVersion: v1.0
class: CommandLineTool
baseCommand: interconverter.sh
hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"
# arguments: ["-d", $(runtime.outdir)]

inputs:
  outDir:
    type: string
    inputBinding:
      prefix: -d
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
