cwlVersion: v1.0
class: CommandLineTool

hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"

# basecommand: mkdir
baseCommand: mkdir.sh

inputs:
  # dirNames:
  #   type: string[]
  masterDir:
    type: Directory


# arguments: ["meth", "meth_sym", "prop_meth", "cov_bw subset"]


outputs:
  subDir:
    type: Directory[]