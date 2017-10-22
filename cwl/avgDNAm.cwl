cwlVersion: v1.0
class: CommandLineTool
baseCommand: avgDNAm_LOLA.R
hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"
arguments: ["-d", $(runtime.outdir)]
inputs:
  bwInput:
    type: File
    inputBinding:
      prefix: -i
  lolaRDB:
    type: Directory
    inputBinding:
      prefix: -b
  lolaCollections:
    type: string[]
    inputBinding:
      prefix: -c
      itemSeparator: ","
      separate: true
outputs:
  avgDNAmResults:
    type: File
    outputBinding:
      glob: "*.csv"
requirements:
  - class: InlineJavascriptRequirement
