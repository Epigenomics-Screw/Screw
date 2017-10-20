cwlVersion: v1.0
class: CommandLineTool
baseCommand: pairwise-distance.sh
hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"
stdout: pairwise-euc.txt
inputs:
  pairDirectory:
    type: Directory
    inputBinding:
      prefix: -i
outputs:
  tableDistance:
    type: File
    outputBinding:
      glob: "pairwise-euc.txt"
