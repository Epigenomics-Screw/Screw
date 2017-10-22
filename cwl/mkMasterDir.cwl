cwlVersion: v1.0
class: CommandLineTool

# hints:
#   - class: DockerRequirement
#     dockerPull: "quay.io/epigenomic_screw/screw"

basecommand: mkdir

inputs:
  masterDir: Directory

arguments:
  - valueFrom: $(inputs.masterDir)
    prefix: -p

outputs:
  masterDir:
    type: Directory
    outputBinding:
      glob: $(inputs.masterDir)
