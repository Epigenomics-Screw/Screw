cwlVersion: v1.0
class: CommandLineTool

hints:
  - class: DockerRequirement
    dockerPull: "quay.io/epigenomic_screw/screw"

basecommand: mkdir

inputs:
  dirNames:
    type: string[]

# arguments: ["meth", "meth_sym", "prop_meth", "cov_bw subset"]