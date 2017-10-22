cwlVersion: v1.0
class: CommandLineTool

# hints:
#   - class: DockerRequirement
#     dockerPull: "quay.io/epigenomic_screw/screw"

basecommand: mkdir

inputs:
  masterDir: Directory
  subDir: string

arguments:
  - valueFrom: $(inputs.masterDir)/$(inputs.subDir)
    prefix: -p

outputs:
  subDirs:
    type: Directory
    outputBinding:
      glob: $(inputs.masterDir)



