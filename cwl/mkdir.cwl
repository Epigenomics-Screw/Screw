cwlVersion: v1.0
class: CommandLineTool

# hints:
#   - class: DockerRequirement
#     dockerPull: "quay.io/epigenomic_screw/screw"

# basecommand: mkdir
baseCommand: mkdir.sh

inputs:
  masterDir:
    type: Directory
    inputBinding:
      prefix: -m
  # subDir:
  #   type: string


outputs: []
  # subDir:
  #   type: Directory