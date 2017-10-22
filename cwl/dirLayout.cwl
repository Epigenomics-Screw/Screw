cwlVersion: v1.0
class: ExpressionTool

requirements:
  InlineJavascriptRequirement: {}

inputs:
  meth:
    type: File
  meth_sym:
    type: File
  prop_meth:
    type: File
  cov_bw:
    type: File
  subset:
    type: File
  distanceMatrix:
    type: File
  heatMap:
    type: File


expression: |
  ${ 
    // inputs.meth.basename = "*.meth";
    // inputs.meth_sym.basename = "*.sym";
    // inputs.prop_meth.basename = "*.prop_meth.bw";
    // inputs.cov_bw.basename = "*.cov.bw";
    // inputs.subset.basename = "*.sym";
    // inputs.distanceMatrix.basename = "pairwise-euc.txt";
    // inputs.heatMap.basename = "*.pdf";

    // to include: meth meth_sym prop_meth cov_bw subset cluster
    var r = {
      "outputs":

        { "class": "Directory",
          "basename": "results",
          "listing": [

            { "class": "Directory",
              "basename": "meth",
              "listing": [
                inputs.meth, ] 
            },
            { "class": "Directory",
              "basename": "meth_sym",
              "listing": [
                inputs.meth_sym ] 
            },
            { "class": "Directory",
              "basename": "prop_meth",
              "listing": [
                inputs.prop_meth ] 
            },
            { "class": "Directory",
              "basename": "cov_bw",
              "listing": [
                inputs.cov_bw ] 
            },
            { "class": "Directory",
              "basename": "subset",
              "listing": [
                inputs.subset ] 
            },

            inputs.distanceMatrix,
            inputs.heatMap
          ] 
        } 
    };
    return r; }

outputs:
  results: Directory