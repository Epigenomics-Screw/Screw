cwlVersion: v1.0
class: Workflow

requirements:
  - class: MultipleInputFeatureRequirement

inputs:
  pairDirectory: Directory
  annotation: File

outputs:
  tableDistance:
    type: File
    outputSource: distanceMatrix/tableDistance
  tableHeat:
    type: File
    outputSource: heatMap/tableHeat

steps:
  distanceMatrix:
    run: pairwise-distance.cwl
    in: 
      pairDirectory: pairDirectory
    out: [tableDistance]
  heatMap:
    run: pairwise-euc-heatmap.cwl
    in:
      pairwiseTable: distanceMatrix/tableDistance
      annotation: annotation
    out: [tableHeat]
